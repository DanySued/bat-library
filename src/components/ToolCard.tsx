import { useState, useEffect, useRef, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { toast } from 'sonner'
import { Download, Bookmark, Info } from 'lucide-react'
import Lottie from 'lottie-react'
import checkmarkData from '@/animations/checkmark.json'
import { cn } from '@/lib/utils'
import { getIcon } from '@/lib/icons'
import { Badge } from '@/components/ui/badge'
import { useBookmarks } from '@/contexts/BookmarksContext'
import { useDownloads } from '@/contexts/DownloadsContext'
import type { Tool } from '@/data/tools'

const RISK_LABEL: Record<1|2|3|4|5, string> = {
  1: 'Safe', 2: 'Low', 3: 'Moderate', 4: 'High', 5: 'Destructive',
}
const RISK_COLOR: Record<1|2|3|4|5, string> = {
  1: '#4ade80', 2: '#a3e635', 3: '#facc15', 4: '#fb923c', 5: '#f87171',
}

function formatCount(n: number): string {
  if (n >= 1000) return `${(n / 1000).toFixed(1).replace(/\.0$/, '')}k`
  return String(n)
}

interface ToolCardProps {
  tool: Tool
  onBookmarkChange?: () => void
}

export function ToolCard({ tool, onBookmarkChange }: ToolCardProps) {
  const navigate = useNavigate()
  const { isBookmarked, toggle } = useBookmarks()
  const { getCount, recordDownload } = useDownloads()
  const [code, setCode] = useState<string | null>(null)
  const [copied, setCopied] = useState(false)
  const cardRef = useRef<HTMLDivElement>(null)

  const IconComp  = getIcon(tool.icon)
  const CopyIcon  = getIcon('Copy')
  const ShieldIcon   = getIcon('ShieldAlert')

  useEffect(() => {
    if (!cardRef.current) return
    const el = cardRef.current
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          observer.disconnect()
          fetch(`/files/${tool.id}.bat`)
            .then(r => r.ok ? r.text() : Promise.reject())
            .then(setCode)
            .catch(() => setCode(''))
        }
      },
      { rootMargin: '300px' }
    )
    observer.observe(el)
    return () => observer.disconnect()
  }, [tool.id])

  const handleCopy = useCallback(async (e: React.MouseEvent) => {
    e.stopPropagation()
    if (code == null) return
    await navigator.clipboard.writeText(code)
    setCopied(true)
    toast('Copied to clipboard')
    setTimeout(() => setCopied(false), 2000)
  }, [code])

  const handleBookmark = useCallback((e: React.MouseEvent) => {
    e.stopPropagation()
    toggle(tool.id)
    onBookmarkChange?.()
  }, [tool.id, toggle, onBookmarkChange])

  const bookmarked = isBookmarked(tool.id)
  const dlCount = getCount(tool.id, tool.downloads)

  return (
    <div
      ref={cardRef}
      onClick={() => navigate(`/bat/${tool.id}`)}
      className="group flex flex-col bg-bg2 border border-[rgba(255,255,255,0.06)] rounded-xl p-5 cursor-pointer transition-all duration-200 hover:bg-bg3 hover:border-accent/50 hover:shadow-[0_4px_32px_rgba(87,181,231,0.12)] hover:-translate-y-0.5"
    >
      {/* Bookmark */}
      <div className="flex justify-end mb-1">
        <button
          onClick={handleBookmark}
          aria-label={bookmarked ? 'Remove bookmark' : 'Bookmark this tool'}
          className="text-dim hover:text-accent transition-colors duration-150 w-11 h-11 -mr-3 -mt-2 flex items-center justify-center"
        >
          {bookmarked
            ? <Bookmark size={16} fill="currentColor" className="text-accent" />
            : <Bookmark size={16} />
          }
        </button>
      </div>

      {/* Icon + Title + description */}
      <div className="flex flex-col items-center text-center flex-1 mb-4">
        <div className="text-accent mb-3">
          {IconComp && <IconComp size={28} />}
        </div>
        <h3 className="font-bold text-head text-[17px] leading-snug mb-1.5">{tool.name}</h3>
        <p className="text-dim text-[13px] leading-relaxed">{tool.desc}</p>
      </div>

      {/* Risk + downloads */}
      <div className="flex items-center justify-center gap-4 mb-3 mt-1">
        <span className="flex items-center gap-1.5 text-[12px]" style={{ color: RISK_COLOR[tool.riskScore] }}>
          <span
            className="w-1.5 h-1.5 rounded-full flex-shrink-0"
            style={{ backgroundColor: RISK_COLOR[tool.riskScore] }}
          />
          {RISK_LABEL[tool.riskScore]}
        </span>
        <span className="w-px h-3 bg-white/10" />
        <span className="flex items-center gap-1 text-[12px] text-dim">
          <Download size={11} />
          {formatCount(dlCount)}
        </span>
      </div>

      {/* Footer */}
      <div className="flex items-center justify-between mt-auto">
        <button
          onClick={e => { e.stopPropagation(); navigate(`/bat/${tool.id}`) }}
          className="flex items-center justify-center w-11 h-11 -ml-2 rounded-md text-dim hover:text-accent transition-colors duration-150"
          aria-label="View details"
        >
          <Info size={16} />
        </button>
        <div className="flex items-center gap-0.5">
          <button
            onClick={handleCopy}
            aria-label="Copy script"
            className={cn(
              'flex items-center justify-center w-11 h-11 transition-colors duration-150',
              copied ? 'text-accent' : 'text-dim hover:text-accent'
            )}
          >
            {copied
              ? <Lottie animationData={checkmarkData} loop={false} style={{ width: 16, height: 16 }} />
              : CopyIcon && <CopyIcon size={14} />
            }
          </button>
          <a
            href={`/files/${tool.id}.bat`}
            download={`${tool.id}.bat`}
            onClick={e => {
              e.stopPropagation()
              recordDownload(tool.id)
            }}
            className="flex items-center justify-center w-11 h-11 -mr-2 text-dim hover:text-accent transition-colors duration-150"
            aria-label="Download"
          >
            <Download size={14} />
          </a>
        </div>
      </div>
    </div>
  )
}
