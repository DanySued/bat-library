import { Link } from 'react-router-dom'
import { ArrowRight } from 'lucide-react'
import { getIcon } from '@/lib/icons'
import { TOOLS, CATEGORIES } from '@/data/tools'

export function CategoryShowcase() {
  const cats = CATEGORIES.filter(c => c.id !== 'all' && c.id !== 'saved')

  return (
    <section className="border-t border-[rgba(255,255,255,0.06)]">
      <div className="max-w-[1344px] mx-auto px-6 py-24">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-12">
          <div>
            <p className="text-[11px] font-semibold tracking-[0.1em] uppercase text-orange mb-4">
              Browse by Category
            </p>
            <h2
              className="font-semibold text-head leading-[1.1]"
              style={{ fontSize: 'clamp(1.75rem, 3vw, 2.5rem)', letterSpacing: '-0.022em' }}
            >
              Every type of fix,
              <br />organized.
            </h2>
          </div>
          <Link
            to="/bat"
            className="inline-flex items-center gap-2 text-[13px] text-orange hover:opacity-80 transition-opacity flex-shrink-0"
          >
            View all scripts <ArrowRight size={13} />
          </Link>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-px bg-[rgba(255,255,255,0.06)]">
          {cats.map(cat => {
            const IconComp = getIcon(cat.icon)
            const count = TOOLS.filter(t => t.cat === cat.id).length
            const featured = TOOLS.filter(t => t.cat === cat.id).slice(0, 3)

            return (
              <Link
                key={cat.id}
                to={`/bat`}
                className="group bg-bg2 p-7 flex flex-col gap-4 transition-colors duration-200 hover:bg-bg3"
              >
                <div className="flex items-start justify-between">
                  <div className="w-10 h-10 rounded-xl bg-orange/10 border border-orange/15 flex items-center justify-center text-orange transition-colors group-hover:bg-orange/15">
                    {IconComp && <IconComp size={18} />}
                  </div>
                  <span className="text-[12px] text-dim tabular-nums">{count} scripts</span>
                </div>

                <div>
                  <h3 className="text-head text-[16px] font-semibold mb-1">{cat.label}</h3>
                  <ul className="space-y-0.5">
                    {featured.map(t => (
                      <li key={t.id} className="text-[12px] text-dim truncate">{t.name}</li>
                    ))}
                    {count > 3 && (
                      <li className="text-[12px] text-orange/60">+{count - 3} more</li>
                    )}
                  </ul>
                </div>

                <div className="mt-auto flex items-center gap-1 text-[12px] text-dim group-hover:text-orange transition-colors">
                  Browse <ArrowRight size={11} />
                </div>
              </Link>
            )
          })}
        </div>
      </div>
    </section>
  )
}
