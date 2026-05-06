import { FeatureSection } from './FeatureSection'

// Mockup 1: Terminal running a script
function TerminalMockup() {
  return (
    <div
      className="rounded-2xl border border-[rgba(255,255,255,0.06)] bg-bg2 overflow-hidden"
      style={{ boxShadow: '0 24px 64px rgba(0,0,0,0.5)' }}
    >
      <div className="flex items-center gap-2 px-5 py-3 border-b border-[rgba(255,255,255,0.06)] bg-bg3">
        <span className="w-2.5 h-2.5 rounded-full bg-danger/60" />
        <span className="w-2.5 h-2.5 rounded-full bg-accent/40" />
        <span className="w-2.5 h-2.5 rounded-full bg-code-fg/40" />
        <span className="ml-3 text-[11px] text-dim font-mono">Administrator: Command Prompt</span>
      </div>
      <div className="p-5 font-mono text-[12px] space-y-1.5">
        <div className="text-dim">C:\&gt; <span className="text-code-fg">WeeklyClean.bat</span></div>
        <div className="text-[rgba(255,255,255,0.3)]">──────────────────────────────</div>
        <div className="text-body">[Phase 1] Clearing temp files...</div>
        <div className="text-code-fg">  ✓ %TEMP% cleared (247 MB freed)</div>
        <div className="text-code-fg">  ✓ Windows Temp cleared (83 MB freed)</div>
        <div className="text-body">[Phase 2] Emptying Recycle Bin...</div>
        <div className="text-code-fg">  ✓ Recycle Bin emptied</div>
        <div className="text-body">[Phase 3] Flushing DNS cache...</div>
        <div className="text-code-fg">  ✓ DNS cache flushed</div>
        <div className="text-body">[Phase 4] Clearing browser cache...</div>
        <div className="text-code-fg">  ✓ Chrome cache cleared (1.2 GB freed)</div>
        <div className="text-[rgba(255,255,255,0.3)]">──────────────────────────────</div>
        <div className="text-accent font-semibold">Done. Total freed: 1.53 GB</div>
        <div className="flex items-center gap-1.5 mt-2">
          <span className="w-1.5 h-3 bg-body/70 animate-pulse" />
        </div>
      </div>
    </div>
  )
}

// Mockup 2: Source code viewer
function SourceMockup() {
  return (
    <div
      className="rounded-2xl border border-[rgba(255,255,255,0.06)] bg-bg2 overflow-hidden"
      style={{ boxShadow: '0 24px 64px rgba(0,0,0,0.5)' }}
    >
      <div className="flex items-center justify-between px-5 py-3 border-b border-[rgba(255,255,255,0.06)] bg-bg3">
        <div className="flex items-center gap-2">
          <span className="w-2.5 h-2.5 rounded-full bg-danger/60" />
          <span className="w-2.5 h-2.5 rounded-full bg-accent/40" />
          <span className="w-2.5 h-2.5 rounded-full bg-code-fg/40" />
        </div>
        <span className="text-[11px] text-dim font-mono">Source code</span>
        <button className="text-[11px] text-accent font-mono px-2 py-0.5 rounded border border-accent/30 bg-accent/5">
          Copy
        </button>
      </div>
      <div className="p-5 font-mono text-[12px] space-y-1 bg-[#0c0c10]">
        {[
          ['1', '@echo', ' off'],
          ['2', 'title', ' RAMCleaner'],
          ['3', '', ''],
          ['4', ':: ', 'Ask for elevated rights'],
          ['5', 'net session', ' >nul 2>&1'],
          ['6', 'if %errorLevel%', ' == 0 goto :elevated'],
          ['7', 'echo ', 'Requesting admin...'],
          ['8', 'powershell', ' Start-Process...'],
          ['9', '', ''],
          ['10', ':elevated', ''],
        ].map(([num, a, b], i) => (
          <div key={i} className="flex gap-4">
            <span className="text-[rgba(255,255,255,0.15)] select-none w-5 text-right flex-shrink-0">{num}</span>
            <span>
              <span className="text-accent">{a}</span>
              <span className="text-body">{b}</span>
            </span>
          </div>
        ))}
      </div>
    </div>
  )
}

// Mockup 3: Category filter
function CategoryMockup() {
  const cats = [
    { label: 'All', active: false },
    { label: 'Cleaning', active: true },
    { label: 'Backup', active: false },
    { label: 'Fast PC', active: false },
    { label: 'Organizing', active: false },
    { label: 'Aesthetic', active: false },
  ]
  const cards = [
    { name: 'CleanWindows MASTER', desc: 'Complete debloat & optimization', admin: true },
    { name: 'WeeklyClean', desc: 'Temp files, DNS, browser cache', admin: false },
    { name: 'EmptyFolderCleaner', desc: 'Recursively removes empty folders', admin: false },
  ]
  return (
    <div
      className="rounded-2xl border border-[rgba(255,255,255,0.06)] bg-bg2 overflow-hidden p-5 space-y-4"
      style={{ boxShadow: '0 24px 64px rgba(0,0,0,0.5)' }}
    >
      <div className="flex gap-1.5 flex-wrap">
        {cats.map(c => (
          <span
            key={c.label}
            className={`px-3 py-1 rounded-full text-[11px] border transition-colors ${
              c.active
                ? 'bg-white text-black border-accent font-semibold'
                : 'bg-bg3 text-dim border-[rgba(255,255,255,0.06)]'
            }`}
          >
            {c.label}
          </span>
        ))}
      </div>
      <div className="space-y-2">
        {cards.map(card => (
          <div
            key={card.name}
            className="flex items-center justify-between px-4 py-3 rounded-xl bg-bg3 border border-[rgba(255,255,255,0.04)]"
          >
            <div>
              <div className="text-[13px] text-head font-medium">{card.name}</div>
              <div className="text-[11px] text-dim mt-0.5">{card.desc}</div>
            </div>
            <div className="flex items-center gap-2">
              {card.admin && (
                <span className="text-[10px] px-2 py-0.5 rounded-full bg-danger/10 text-danger border border-danger/20">
                  Admin
                </span>
              )}
              <span className="text-[11px] px-2.5 py-1 rounded-lg bg-white text-black font-semibold">↓</span>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

export function FeatureSections() {
  return (
    <>
      <FeatureSection
        eyebrow="Instant Results"
        headline="One click. Full power."
        description="Every script runs with a single double-click (or right-click → Run as administrator for admin tasks). No menus, no wizards, no reboots mid-script. Run it, let it finish, done."
        mockup={<TerminalMockup />}
      />

      <FeatureSection
        eyebrow="Full Transparency"
        headline="Know what you're running."
        description="Every script's source code is shown directly in the library — right there on the card. Read it before you run it. Copy it, audit it, modify it. No black boxes."
        mockup={<SourceMockup />}
        reverse
      />

    </>
  )
}
