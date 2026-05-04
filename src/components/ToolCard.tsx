import { useState, useEffect, useRef, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { toast } from 'sonner'
import { cn } from '@/lib/utils'
import { getIcon } from '@/lib/icons'
import { Badge } from '@/components/ui/badge'
import { getBookmarks, toggleBookmark } from '@/lib/bookmarks'
import type { Tool } from '@/data/tools'

interface ToolCardProps {
  tool: Tool
  onBookmarkChange: () => void
}

export function ToolCard({ tool, onBookmarkChange }: ToolCardProps) {
  const navigate = useNavigate()
  const [code, setCode] = useState<string | null>(null)
  const [bookmarked, setBookmarked] = useState(() => getBookmarks().includes(tool.id))
  const [copied, setCopied] = useState(false)
  const cardRef = useRef<HTMLDivElement>(null)

  const IconComp  = getIcon(tool.icon)
  const CopyIcon  = getIcon('Copy')
  const CheckIcon = getIcon('Check')
  const BookmarkIcon = getIcon('Bookmark')
  const DownloadIcon = getIcon('Download')
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
    const next = toggleBookmark(tool.id)
    setBookmarked(next.includes(tool.id))
    onBookmarkChange()
  }, [tool.id, onBookmarkChange])

  return (
    <div
      ref={cardRef}
      onClick={() => navigate(`/bat/${tool.id}`)}
      className="group flex flex-col bg-bg2 border border-[rgba(255,255,255,0.06)] rounded-xl p-5 cursor-pointer transition-all duration-200 hover:bg-bg3 hover:border-orange/50 hover:shadow-[0_4px_32px_rgba(207,123,75,0.12)] hover:-translate-y-0.5"
    >
      {/* Top row: tool icon + bookmark */}
      <div className="flex items-start justify-between mb-3">
        <div className="text-orange">
          {IconComp && <IconComp size={22} />}
        </div>
        <button
          onClick={handleBookmark}
          aria-label={bookmarked ? 'Remove bookmark' : 'Bookmark this tool'}
          className="text-dim hover:text-orange transition-colors duration-150 p-0.5 -mr-0.5 -mt-0.5"
        >
          {bookmarked
            ? BookmarkIcon && <BookmarkIcon size={16} fill="currentColor" className="text-orange" />
            : BookmarkIcon && <BookmarkIcon size={16} />
          }
        </button>
      </div>

      {/* Title + description */}
      <h3 className="font-bold text-head text-[17px] leading-snug mb-1.5">{tool.name}</h3>
      <p className="text-dim text-[13px] leading-relaxed mb-4">{tool.desc}</p>

      {/* Code block */}
      <div
        onClick={e => e.stopPropagation()}
        className="relative bg-code-bg border border-[rgba(255,255,255,0.04)] border-l-2 border-l-orange-dim rounded-lg overflow-hidden mb-4 flex-1"
      >
        {code === null ? (
          <div className="p-3 text-dim text-[11px] font-mono animate-pulse">Loading...</div>
        ) : code === '' ? (
          <div className="p-3 text-dim text-[11px] font-mono">Preview unavailable</div>
        ) : (
          <pre className="text-code-fg text-[11px] font-mono leading-relaxed overflow-x-auto overflow-y-auto max-h-[170px] p-3 whitespace-pre">
            {code}
          </pre>
        )}

        <button
          onClick={handleCopy}
          aria-label="Copy script to clipboard"
          className={cn(
            'absolute top-2 right-2 p-1.5 rounded border transition-all duration-150',
            copied
              ? 'bg-orange/10 border-orange text-orange'
              : 'bg-bg3 border-rule text-dim hover:border-orange hover:text-orange'
          )}
        >
          {copied
            ? CheckIcon && <CheckIcon size={11} />
            : CopyIcon && <CopyIcon size={11} />
          }
        </button>
      </div>

      {/* Footer */}
      <div className="flex items-center justify-between mt-auto">
        <div>
          {tool.admin && (
            <Badge variant="danger" className="gap-1">
              {ShieldIcon && <ShieldIcon size={9} />}
              Admin
            </Badge>
          )}
        </div>
        <a
          href={`/files/${tool.id}.bat`}
          download={`${tool.id}.bat`}
          onClick={e => e.stopPropagation()}
          className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-orange text-bg rounded-md text-[12px] font-bold hover:opacity-85 transition-opacity duration-150"
        >
          {DownloadIcon && <DownloadIcon size={11} />}
          Download
        </a>
      </div>
    </div>
  )
}
