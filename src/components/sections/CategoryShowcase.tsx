import { Link } from 'react-router-dom'
import { ArrowRight } from 'lucide-react'
import { getIcon } from '@/lib/icons'
import { CATEGORIES } from '@/data/tools'
import { useTools } from '@/contexts/ToolsContext'

export function CategoryShowcase() {
  const { tools } = useTools()
  const cats = CATEGORIES.filter(c => c.id !== 'all' && c.id !== 'saved')

  return (
    <section className="border-t border-[rgba(255,255,255,0.06)]">
      <div className="max-w-[1344px] mx-auto px-4 sm:px-6 py-14 md:py-24">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-8 md:mb-12">
          <div>
            <p className="text-[11px] font-semibold tracking-[0.1em] uppercase text-accent mb-4">
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
            className="group inline-flex items-center gap-2 text-[13px] text-accent hover:opacity-80 transition-opacity flex-shrink-0"
          >
            View all scripts <ArrowRight size={13} className="transition-transform duration-200 group-hover:translate-x-1" />
          </Link>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {cats.map(cat => {
            const IconComp = getIcon(cat.icon)
            const catTools = tools.filter(t => t.cat === cat.id)
            const count = catTools.length
            const featured = catTools.slice(0, 4)

            return (
              <Link
                key={cat.id}
                to={`/bat?cat=${cat.id}`}
                className="group relative flex flex-col gap-5 p-6 rounded-xl border border-[rgba(255,255,255,0.07)] bg-bg2 hover:border-accent/30 hover:-translate-y-1 hover:shadow-[0_8px_32px_rgba(87,181,231,0.1)] transition-all duration-200"
              >
                {/* Header */}
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div
                      className="p-1.5 rounded-lg text-accent transition-all duration-200 group-hover:scale-110"
                      style={{ background: 'rgba(87,181,231,0.08)' }}
                    >
                      {IconComp && <IconComp size={14} />}
                    </div>
                    <h3 className="text-head text-[15px] font-semibold">{cat.label}</h3>
                  </div>
                  <span className="text-[11px] font-medium tabular-nums px-2 py-0.5 rounded-full bg-[rgba(255,255,255,0.05)] text-dim">
                    {count}
                  </span>
                </div>

                {/* Divider */}
                <div className="h-px bg-[rgba(255,255,255,0.05)]" />

                {/* Script list */}
                <ul className="grid grid-cols-2 gap-x-4 gap-y-1.5">
                  {featured.map(t => (
                    <li key={t.id} className="flex items-center gap-1.5 min-w-0">
                      <span className="w-1 h-1 rounded-full bg-accent/40 flex-shrink-0" />
                      <span className="text-[12px] text-dim truncate">{t.name}</span>
                    </li>
                  ))}
                  {count > 4 && (
                    <li className="flex items-center gap-1.5">
                      <span className="w-1 h-1 rounded-full bg-accent/20 flex-shrink-0" />
                      <span className="text-[12px] text-accent/50">+{count - 4} more</span>
                    </li>
                  )}
                </ul>

                {/* Footer CTA */}
                <div className="mt-auto flex items-center gap-1.5 text-[12px] font-medium text-dim group-hover:text-accent transition-colors duration-200">
                  Browse category <ArrowRight size={11} className="transition-transform duration-200 group-hover:translate-x-0.5" />
                </div>
              </Link>
            )
          })}
        </div>
      </div>
    </section>
  )
}
