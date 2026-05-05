import { ReactNode } from 'react'

interface FeatureSectionProps {
  eyebrow: string
  headline: string
  description: string
  mockup: ReactNode
  reverse?: boolean
}

export function FeatureSection({ eyebrow, headline, description, mockup, reverse }: FeatureSectionProps) {
  return (
    <section className="border-t border-[rgba(255,255,255,0.06)]">
      <div
        className={`max-w-[1344px] mx-auto px-4 sm:px-6 py-14 md:py-24 flex flex-col gap-10 lg:gap-16 ${
          reverse ? 'lg:flex-row-reverse' : 'lg:flex-row'
        } items-center`}
      >
        {/* Text */}
        <div className="flex-1 max-w-[480px]">
          <p className="text-[11px] font-semibold tracking-[0.1em] uppercase text-accent mb-5">
            {eyebrow}
          </p>
          <h2
            className="font-semibold text-head leading-[1.1] mb-5"
            style={{ fontSize: 'clamp(1.75rem, 3vw, 2.5rem)', letterSpacing: '-0.022em' }}
          >
            {headline}
          </h2>
          <p className="text-[16px] leading-relaxed" style={{ color: '#8a8f98' }}>
            {description}
          </p>
        </div>

        {/* Mockup */}
        <div className="flex-1 w-full max-w-[580px]">
          {mockup}
        </div>
      </div>
    </section>
  )
}
