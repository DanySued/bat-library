const STATS = [
  '35 Scripts',
  '6 Categories',
  'Free Forever',
  'No Installation',
  'Open Source',
  'Run on Any PC',
  'No Data Collected',
  'Source Code Visible',
  'Admin Scripts Labeled',
  'Download Every Script',
]

const duplicated = [...STATS, ...STATS]

export function StatsMarquee() {
  return (
    <div className="relative border-y border-[rgba(255,255,255,0.06)] py-4 overflow-hidden">
      {/* Edge fades */}
      <div
        className="absolute left-0 inset-y-0 z-10 w-24 pointer-events-none"
        style={{ background: 'linear-gradient(to right, #07070a, transparent)' }}
      />
      <div
        className="absolute right-0 inset-y-0 z-10 w-24 pointer-events-none"
        style={{ background: 'linear-gradient(to left, #07070a, transparent)' }}
      />

      <div className="marquee-track">
        {duplicated.map((stat, i) => (
          <div key={i} className="flex items-center gap-3 px-6 whitespace-nowrap">
            <span className="text-[13px] text-dim font-medium">{stat}</span>
            <span className="text-orange/40 text-[10px]">✦</span>
          </div>
        ))}
      </div>
    </div>
  )
}
