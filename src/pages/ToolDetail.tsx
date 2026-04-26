import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { toast } from 'sonner'
import { TOOLS } from '@/data/tools'
import { Badge } from '@/components/ui/badge'
import { getIcon } from '@/lib/icons'
import { getBookmarks, toggleBookmark } from '@/lib/bookmarks'
import { cn } from '@/lib/utils'

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
  tip:     { iconName: 'Lightbulb',     color: 'text-orange' },
}

export function ToolDetail() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const tool = TOOLS.find(t => t.id === id)

  const [code, setCode]         = useState<string | null>(null)
  const [copied, setCopied]     = useState(false)
  const [bookmarked, setBookmarked] = useState(() => getBookmarks().includes(id ?? ''))

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
          <p className="text-[16px] mb-4">Tool not found</p>
          <button
            onClick={() => navigate('/')}
            className="text-orange hover:opacity-80 text-[14px] transition-opacity"
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

  const handleBookmark = () => {
    const next = toggleBookmark(tool.id)
    setBookmarked(next.includes(tool.id))
  }

  return (
    <div className="min-h-screen">
      {/* Nav */}
      <nav className="sticky top-0 z-50 bg-bg/90 backdrop-blur-md border-b border-rule">
        <div className="max-w-[900px] mx-auto px-6 h-14 flex items-center justify-between">
          <button
            onClick={() => navigate('/')}
            className="inline-flex items-center gap-2 text-[13px] text-dim hover:text-body transition-colors duration-150 px-2 py-1 rounded hover:bg-bg2 -ml-2"
          >
            {ArrowLeft && <ArrowLeft size={14} />}
            Back to tools
          </button>

          <button
            onClick={handleBookmark}
            aria-label={bookmarked ? 'Remove bookmark' : 'Bookmark'}
            className="text-dim hover:text-orange transition-colors duration-150 p-1.5 rounded hover:bg-bg2"
          >
            {bookmarked
              ? BookmarkIcon && <BookmarkIcon size={16} fill="currentColor" className="text-orange" />
              : BookmarkIcon && <BookmarkIcon size={16} />
            }
          </button>
        </div>
      </nav>

      <main className="max-w-[900px] mx-auto px-6 py-12 pb-20">
        {/* Header */}
        <div className="mb-10">
          <div className="text-orange mb-4">
            {IconComp && <IconComp size={44} />}
          </div>
          <h1 className="font-serif font-bold text-head text-[36px] leading-tight tracking-[-0.5px] mb-3">
            {tool.name}
          </h1>
          <div className="flex items-center gap-2 flex-wrap mb-5">
            <Badge variant="secondary">{tool.cat}</Badge>
            {tool.admin && <Badge variant="danger">Admin Required</Badge>}
          </div>
          <p className="text-body text-[16px] leading-relaxed max-w-[640px]">
            {tool.explanation}
          </p>
        </div>

        {/* Source code */}
        <section className="mb-10">
          <h2 className="font-serif font-bold text-head text-[20px] mb-4">Source code</h2>
          <div className="relative bg-code-bg border border-rule border-l-2 border-l-orange-dim rounded-lg overflow-hidden">
            {code === null ? (
              <div className="p-4 text-dim text-[12px] font-mono animate-pulse">Loading...</div>
            ) : code === '' ? (
              <div className="p-4 text-dim text-[12px] font-mono">Source unavailable</div>
            ) : (
              <pre className="text-code-fg text-[12px] font-mono leading-relaxed overflow-x-auto overflow-y-auto max-h-[420px] p-4 whitespace-pre">
                {code}
              </pre>
            )}
            <button
              onClick={handleCopy}
              aria-label="Copy script"
              className={cn(
                'absolute top-3 right-3 inline-flex items-center gap-1.5 px-2.5 py-1.5 rounded border text-[11px] font-mono transition-all duration-150',
                copied
                  ? 'bg-orange/10 border-orange text-orange'
                  : 'bg-bg3 border-rule text-dim hover:border-orange hover:text-orange'
              )}
            >
              {copied
                ? CheckIcon && <CheckIcon size={11} />
                : CopyIcon && <CopyIcon size={11} />
              }
              {copied ? 'Copied' : 'Copy'}
            </button>
          </div>
        </section>

        {/* What it does */}
        <section className="mb-10">
          <h2 className="font-serif font-bold text-head text-[20px] mb-4">What it does</h2>
          <ul className="divide-y divide-rule/40">
            {tool.whatItDoes.map((item, i) => (
              <li key={i} className="flex items-start gap-3 py-3">
                <span className="text-orange mt-0.5 flex-shrink-0 text-[13px] leading-none">✓</span>
                <span className="text-body text-[15px]">{item}</span>
              </li>
            ))}
          </ul>
        </section>

        {/* How to use */}
        <section className="mb-10">
          <h2 className="font-serif font-bold text-head text-[20px] mb-4">How to use</h2>
          <ol className="space-y-3.5">
            {tool.howToUse.map((step, i) => (
              <li key={i} className="flex items-start gap-3">
                <span className="flex-shrink-0 w-5 h-5 rounded-full bg-orange/10 border border-orange/20 text-orange text-[10px] font-mono flex items-center justify-center mt-0.5">
                  {i + 1}
                </span>
                <span className="text-body text-[15px]">{step}</span>
              </li>
            ))}
          </ol>
        </section>

        {/* Cautions */}
        <section className="mb-10">
          <h2 className="font-serif font-bold text-head text-[20px] mb-4">Cautions & notes</h2>
          <div className="bg-danger/[0.04] border border-danger/15 rounded-lg p-5 divide-y divide-rule/30">
            {tool.cautions.map((raw, i) => {
              const { type, text } = parseCaution(raw)
              const { iconName, color } = cautionStyle[type]
              const CautionIcon = getIcon(iconName)
              return (
                <div key={i} className="flex items-start gap-3 py-2.5 first:pt-0 last:pb-0">
                  {CautionIcon && <CautionIcon size={14} className={cn('flex-shrink-0 mt-0.5', color)} />}
                  <span className="text-body text-[14px] leading-relaxed">{text}</span>
                </div>
              )
            })}
          </div>
        </section>

        {/* Download */}
        <section>
          <h2 className="font-serif font-bold text-head text-[20px] mb-4">Download</h2>
          <a
            href={`/files/${tool.id}.bat`}
            download={`${tool.id}.bat`}
            className="inline-flex items-center gap-2 px-5 py-2.5 bg-orange text-bg rounded-lg font-bold text-[14px] hover:opacity-85 transition-opacity duration-150"
          >
            {DownloadIcon && <DownloadIcon size={15} />}
            Download {tool.id}.bat
          </a>
          <p className="mt-3 text-dim text-[13px]">
            Right-click the file → "Run as administrator" to execute.
          </p>
        </section>
      </main>
    </div>
  )
}
