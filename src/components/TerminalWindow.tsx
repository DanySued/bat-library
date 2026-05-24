interface Props {
  title: string
  lines: string[]
}

function lineColor(line: string): string {
  if (line.startsWith('> '))            return '#57B5E7'   // command — accent
  if (/^\s*$/.test(line))               return 'transparent'
  if (/error|failed|denied/i.test(line)) return '#f87171'  // red
  if (/done|success|complete|ok\b|finish/i.test(line)) return '#4ade80' // green
  if (/warning|caution|skip/i.test(line)) return '#facc15' // yellow
  return '#c8d3e0'                                          // default output
}

export function TerminalWindow({ title, lines }: Props) {
  return (
    <div className="rounded-xl overflow-hidden border border-[rgba(255,255,255,0.08)] font-mono text-[12px] leading-relaxed">
      {/* Title bar */}
      <div className="flex items-center gap-2 px-4 py-2.5 bg-[#1a1a2e] border-b border-[rgba(255,255,255,0.06)]">
        <span className="w-3 h-3 rounded-full bg-[#ff5f57]" />
        <span className="w-3 h-3 rounded-full bg-[#febc2e]" />
        <span className="w-3 h-3 rounded-full bg-[#28c840]" />
        <span className="ml-2 text-[11px] text-[rgba(255,255,255,0.35)] tracking-wide select-none">{title}</span>
      </div>

      {/* Body */}
      <div className="bg-[#0d0d14] px-5 py-4 overflow-x-auto">
        <div className="flex items-center gap-1.5 mb-3 text-[rgba(255,255,255,0.2)] text-[11px]">
          <span>C:\Users\user&gt;</span>
          <span className="text-[#57B5E7]">{title}</span>
        </div>
        {lines.map((line, i) => (
          <div
            key={i}
            className="whitespace-pre"
            style={{ color: lineColor(line), minHeight: '1.25rem' }}
          >
            {line.startsWith('> ') ? (
              <>
                <span className="text-[rgba(255,255,255,0.3)]">C:\&gt; </span>
                <span>{line.slice(2)}</span>
              </>
            ) : line}
          </div>
        ))}
        <div className="mt-2 inline-block w-2 h-4 bg-[#57B5E7] opacity-70 animate-pulse" />
      </div>
    </div>
  )
}
