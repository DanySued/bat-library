import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { toast } from 'sonner'
import Lottie from 'lottie-react'
import checkmarkData from '@/animations/checkmark.json'
import { TOOLS } from '@/data/tools'
import { Badge } from '@/components/ui/badge'
import { getIcon } from '@/lib/icons'
import { useBookmarks } from '@/contexts/BookmarksContext'
import { useDownloads } from '@/contexts/DownloadsContext'
import { cn } from '@/lib/utils'
import { Nav } from '@/components/layout/Nav'
import { Footer } from '@/components/layout/Footer'

type CautionType = 'warning' | 'safe' | 'tip'

function parseCaution(text: string): { type: CautionType; text: string } {
  if (text.startsWith('⚠️')) return { type: 'warning', text: text.slice(2).trim() }
  if (text.startsWith('✅')) return { type: 'safe',    text: text.slice(2).trim() }
  if (text.startsWith('💡')) return { type: 'tip',     text: text.slice(2).trim() }
  return { type: 'tip', text }
}

const cautionStyle: Record<CautionType, { iconName: string; color: string }> = {
  warning: { iconName: 'AlertTriangle', color: 'text-danger' },
  safe:    { iconName: 'CheckCircle',   color: 'text-code-fg' },
  tip:     { iconName: 'Lightbulb',     color: 'text-accent' },
}

export function ToolDetail() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const tool = TOOLS.find(t => t.id === id)

  const { isBookmarked, toggle } = useBookmarks()
  const { recordDownload } = useDownloads()
  const [code, setCode]         = useState<string | null>(null)
  const [copied, setCopied]     = useState(false)

  useEffect(() => {
    if (!id) return
    fetch(`/files/${id}.bat`)
      .then(r => r.ok ? r.text() : Promise.reject())
      .then(setCode)
      .catch(() => setCode(''))
  }, [id])

  useEffect(() => {
    if (tool) document.title = `${tool.name} — BAT Library`
    return () => { document.title = 'BAT Library — Windows Optimization Scripts' }
  }, [tool])

  if (!tool) {
    return (
      <div className="min-h-screen flex items-center justify-center text-dim">
        <div className="text-center">
          <p className="text-[16px] mb-4 text-head">Script not found</p>
          <button
            onClick={() => navigate('/bat')}
            className="text-accent hover:opacity-80 text-[14px] transition-opacity"
          >
            ← Back to library
          </button>
        </div>
      </div>
    )
  }

  const IconComp     = getIcon(tool.icon)
  const CopyIcon     = getIcon('Copy')
  const CheckIcon    = getIcon('Check')
  const DownloadIcon = getIcon('Download')
  const BookmarkIcon = getIcon('Bookmark')
  const ArrowLeft    = getIcon('ArrowLeft')

  const handleCopy = async () => {
    if (!code) return
    await navigator.clipboard.writeText(code)
    setCopied(true)
    toast('Copied to clipboard')
    setTimeout(() => setCopied(false), 2000)
  }

  const bookmarked = isBookmarked(tool.id)
  const handleBookmark = () => toggle(tool.id)

  return (
    <div className="min-h-screen flex flex-col">
      <Nav />

      {/* Tool nav */}
      <div className="sticky top-16 z-40 bg-bg/80 backdrop-blur-[20px] border-b border-[rgba(255,255,255,0.06)]">
        <div className="max-w-[900px] mx-auto px-4 sm:px-6 h-12 flex items-center justify-between">
          <button
            onClick={() => navigate('/bat')}
            className="inline-flex items-center gap-2 text-[13px] text-dim hover:text-body transition-colors duration-150 px-2 py-1 rounded hover:bg-white/5 -ml-2"
          >
            {ArrowLeft && <ArrowLeft size={14} />}
            Back to library
          </button>

          <button
            onClick={handleBookmark}
            aria-label={bookmarked ? 'Remove bookmark' : 'Bookmark'}
            className="text-dim hover:text-accent transition-colors duration-150 p-1.5 rounded hover:bg-white/5"
          >
            {bookmarked
              ? BookmarkIcon && <BookmarkIcon size={16} fill="currentColor" className="text-accent" />
              : BookmarkIcon && <BookmarkIcon size={16} />
            }
          </button>
        </div>
      </div>

      <main className="max-w-[900px] mx-auto w-full px-4 sm:px-6 py-8 md:py-12 pb-16 md:pb-20 flex-1">
        {/* Header */}
        <div className="mb-16">
          <div className="text-accent mb-4">
            {IconComp && <IconComp size={40} />}
          </div>
          <h1
            className="font-semibold text-head leading-tight mb-3"
            style={{ fontSize: 'clamp(1.75rem, 4vw, 2.25rem)', letterSpacing: '-0.022em' }}
          >
            {tool.name}
          </h1>

          <p className="text-[16px] leading-relaxed max-w-[640px]" style={{ color: '#d0d6e0' }}>
            {tool.explanation}
          </p>
        </div>

        {/* What it does */}
        <section className="mb-10">
          <h2 className="font-semibold text-head text-[18px] mb-5" style={{ letterSpacing: '-0.022em' }}>
            What it does
          </h2>
          <ul className="divide-y divide-[rgba(255,255,255,0.04)]">
            {tool.whatItDoes.map((item, i) => (
              <li key={i} className="flex items-start gap-3 py-3">
                <span className="text-accent mt-0.5 flex-shrink-0 text-[13px] leading-none">✓</span>
                <span className="text-[15px]" style={{ color: '#d0d6e0' }}>{item}</span>
              </li>
            ))}
          </ul>
        </section>

        {/* Cautions */}
        <section className="mb-10">
          <h2 className="font-semibold text-head text-[18px] mb-5" style={{ letterSpacing: '-0.022em' }}>
            Risks & notes
          </h2>

          {/* Risk meter */}
          {(() => {
            const labels: Record<1|2|3|4|5, string> = {
              1: 'Safe',
              2: 'Low',
              3: 'Moderate',
              4: 'High',
              5: 'Destructive',
            }
            const colors: Record<1|2|3|4|5, string> = {
              1: '#4ade80',
              2: '#a3e635',
              3: '#facc15',
              4: '#fb923c',
              5: '#f87171',
            }
            const score = tool.riskScore
            const color = colors[score]
            const label = labels[score]
            return (
              <div className="flex items-center gap-4 mb-5">
                <div className="flex items-center gap-1">
                  {([1,2,3,4,5] as const).map(i => (
                    <div
                      key={i}
                      className="rounded-full transition-all duration-300"
                      style={{
                        width: 28,
                        height: 6,
                        backgroundColor: i <= score ? color : 'rgba(255,255,255,0.08)',
                        opacity: i <= score ? (0.5 + (i / score) * 0.5) : 1,
                      }}
                    />
                  ))}
                </div>
                <span className="text-[13px] font-medium" style={{ color }}>{label}</span>
              </div>
            )
          })()}

          <div className="bg-danger/[0.04] border border-danger/15 rounded-xl p-5 divide-y divide-[rgba(255,255,255,0.04)]">
            {tool.cautions.map((raw, i) => {
              const { type, text } = parseCaution(raw)
              const { iconName, color } = cautionStyle[type]
              const CautionIcon = getIcon(iconName)
              return (
                <div key={i} className="flex items-start gap-3 py-2.5 first:pt-0 last:pb-0">
                  {CautionIcon && <CautionIcon size={14} className={cn('flex-shrink-0 mt-0.5', color)} />}
                  <span className="text-[14px] leading-relaxed" style={{ color: '#d0d6e0' }}>{text}</span>
                </div>
              )
            })}
          </div>
        </section>

        {/* Source code */}
        <section className="mb-10">
          <h2
            className="font-semibold text-head text-[18px] mb-4"
            style={{ letterSpacing: '-0.022em' }}
          >
            Source code
          </h2>
          <div className="relative bg-code-bg border border-[rgba(255,255,255,0.06)] border-l-2 border-l-accent-dim rounded-xl overflow-hidden">
            {code === null ? (
              <div className="p-4 text-dim text-[12px] font-mono animate-pulse">Loading...</div>
            ) : code === '' ? (
              <div className="p-4 text-dim text-[12px] font-mono">Source unavailable</div>
            ) : (
              <pre className="text-code-fg text-[12px] font-mono leading-relaxed overflow-x-auto overflow-y-auto max-h-[420px] p-5 whitespace-pre">
                {code}
              </pre>
            )}
            <button
              onClick={handleCopy}
              aria-label="Copy script"
              className={cn(
                'absolute top-3 right-3 inline-flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg border text-[11px] font-mono transition-all duration-150',
                copied
                  ? 'bg-accent/10 border-accent text-accent'
                  : 'bg-bg3 border-[rgba(255,255,255,0.08)] text-dim hover:border-accent hover:text-accent'
              )}
            >
              {copied
                ? <Lottie animationData={checkmarkData} loop={false} style={{ width: 11, height: 11 }} />
                : CopyIcon && <CopyIcon size={11} />
              }
              {copied ? 'Copied' : 'Copy'}
            </button>
          </div>
        </section>

        {/* Download */}
        <section className="flex flex-col items-center text-center mt-10">

          <a
            href={`/files/${tool.id}.bat`}
            download={`${tool.id}.bat`}
            onClick={() => recordDownload(tool.id)}
            className="group inline-flex items-center gap-2 px-6 py-3 bg-white text-black rounded-full font-semibold text-[14px] hover:bg-white/90 transition-colors duration-150 active:scale-[0.98]"
          >
            {DownloadIcon && <DownloadIcon size={15} className="transition-transform duration-200 group-hover:translate-y-0.5" />}
            Download {tool.id}.bat
          </a>
        </section>
      </main>

      <Footer />
    </div>
  )
}
