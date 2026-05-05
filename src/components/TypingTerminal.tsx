import { useState, useEffect } from 'react'

type LineType = 'command' | 'divider' | 'phase' | 'success' | 'result'

interface Line {
  text: string
  type: LineType
  charDelay: number
  pauseAfter: number
}

const LINES: Line[] = [
  { text: 'C:\\> WeeklyClean.bat',                      type: 'command', charDelay: 55, pauseAfter: 120 },
  { text: '──────────────────────────────',              type: 'divider', charDelay: 8,  pauseAfter: 60  },
  { text: '[Phase 1] Clearing temp files...',            type: 'phase',   charDelay: 22, pauseAfter: 80  },
  { text: '  ✓ %TEMP% cleared (247 MB freed)',           type: 'success', charDelay: 16, pauseAfter: 40  },
  { text: '  ✓ Windows Temp cleared (83 MB freed)',      type: 'success', charDelay: 16, pauseAfter: 80  },
  { text: '[Phase 2] Emptying Recycle Bin...',           type: 'phase',   charDelay: 22, pauseAfter: 80  },
  { text: '  ✓ Recycle Bin emptied',                    type: 'success', charDelay: 16, pauseAfter: 80  },
  { text: '[Phase 3] Flushing DNS cache...',             type: 'phase',   charDelay: 22, pauseAfter: 80  },
  { text: '  ✓ DNS cache flushed',                      type: 'success', charDelay: 16, pauseAfter: 80  },
  { text: '  ✓ Chrome cache cleared (1.2 GB freed)',    type: 'success', charDelay: 16, pauseAfter: 80  },
  { text: '──────────────────────────────',              type: 'divider', charDelay: 8,  pauseAfter: 60  },
  { text: 'Done. Total freed: 1.53 GB',                 type: 'result',  charDelay: 30, pauseAfter: 3000 },
]

const LINE_STYLE: Record<LineType, string> = {
  command: 'text-dim',
  divider: 'text-white/20',
  phase:   'text-body',
  success: 'text-code-fg',
  result:  'text-accent font-semibold',
}

export function TypingTerminal() {
  const [committed, setCommitted] = useState<string[]>([])
  const [lineIdx, setLineIdx]     = useState(0)
  const [charIdx, setCharIdx]     = useState(0)
  const [pausing, setPausing]     = useState(false)

  useEffect(() => {
    const line = LINES[lineIdx % LINES.length]

    if (pausing) {
      const t = setTimeout(() => {
        const next = lineIdx + 1
        if (next >= LINES.length) {
          // Reset loop
          setCommitted([])
          setLineIdx(0)
          setCharIdx(0)
        } else {
          setCommitted(prev => [...prev, line.text])
          setLineIdx(next)
          setCharIdx(0)
        }
        setPausing(false)
      }, line.pauseAfter)
      return () => clearTimeout(t)
    }

    if (charIdx < line.text.length) {
      const t = setTimeout(() => setCharIdx(c => c + 1), line.charDelay)
      return () => clearTimeout(t)
    } else {
      setPausing(true)
    }
  }, [lineIdx, charIdx, pausing])

  const activeLine = LINES[lineIdx % LINES.length]
  const partial    = activeLine.text.slice(0, charIdx)

  return (
    <div
      className="rounded-2xl border border-[rgba(255,255,255,0.06)] bg-bg2 overflow-hidden"
      style={{ boxShadow: '0 24px 80px rgba(0,0,0,0.6)' }}
    >
      {/* Window chrome */}
      <div className="flex items-center gap-2 px-5 py-3 border-b border-[rgba(255,255,255,0.06)] bg-bg3">
        <span className="w-3 h-3 rounded-full bg-danger/60" />
        <span className="w-3 h-3 rounded-full bg-accent/40" />
        <span className="w-3 h-3 rounded-full bg-code-fg/40" />
        <span className="ml-4 text-[12px] text-dim font-mono">Administrator: Command Prompt</span>
      </div>

      {/* Output */}
      <div className="p-6 font-mono text-[12px] leading-relaxed min-h-[220px]">
        {committed.map((text, i) => (
          <div key={i} className={LINE_STYLE[LINES[i].type]}>
            {text}
          </div>
        ))}

        {/* Active typing line */}
        {!pausing && (
          <div className={LINE_STYLE[activeLine.type]}>
            {partial}
            <span className="inline-block w-[2px] h-[13px] bg-current align-middle ml-px animate-[blink_1s_step-end_infinite]" />
          </div>
        )}
      </div>
    </div>
  )
}
