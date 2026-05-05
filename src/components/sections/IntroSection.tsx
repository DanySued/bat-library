const PILLS = ['Open Source', 'No Dependencies', 'No Data Collection', 'Works Offline']

export function IntroSection() {
  return (
    <section className="max-w-[1344px] mx-auto px-4 sm:px-6 py-14 md:py-24">
      <div className="max-w-[640px]">
        {/* Eyebrow */}
        <p className="text-[11px] font-semibold tracking-[0.1em] uppercase text-accent mb-5">
          Why Bat Library
        </p>

        <h2
          className="font-semibold text-head leading-[1.1] mb-6"
          style={{ fontSize: 'clamp(1.75rem, 3vw, 2.75rem)', letterSpacing: '-0.022em' }}
        >
          Windows maintenance shouldn't require a manual.
        </h2>

        <p className="text-[16px] leading-relaxed mb-8" style={{ color: '#8a8f98' }}>
          Every script is a plain text file. Open it, read it, understand it — then run it.
          No installers, no accounts, no hidden processes. Just batch files that do exactly
          what they say.
        </p>

        {/* Pills */}
        <div className="flex gap-2 flex-wrap">
          {PILLS.map(pill => (
            <span
              key={pill}
              className="px-3.5 py-1.5 rounded-full border border-[rgba(255,255,255,0.08)] text-[13px] text-dim bg-white/[0.03]"
            >
              {pill}
            </span>
          ))}
        </div>
      </div>
    </section>
  )
}
