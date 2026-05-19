import { useState, useMemo, useEffect, useRef } from 'react'
import { useSearchParams } from 'react-router-dom'
import { ChevronDown, ArrowUpDown, SortAsc, ShieldAlert } from 'lucide-react'
import { Nav } from '@/components/layout/Nav'
import { Footer } from '@/components/layout/Footer'
import { ToolCard } from '@/components/ToolCard'
import { ScrollTop } from '@/components/ScrollTop'
import { CATEGORIES } from '@/data/tools'
import { useTools } from '@/contexts/ToolsContext'
import { useBookmarks } from '@/contexts/BookmarksContext'
import { cn } from '@/lib/utils'
import type { Category } from '@/data/tools'

type FilterId = 'all' | 'saved' | Category
type SortId = 'popular' | 'alpha' | 'risk'

const SORT_OPTIONS: { id: SortId; label: string; Icon: typeof ArrowUpDown }[] = [
  { id: 'popular',  label: 'Popular',      Icon: ArrowUpDown },
  { id: 'alpha',    label: 'Alphabetical', Icon: SortAsc },
  { id: 'risk',     label: 'Riskiest',     Icon: ShieldAlert },
]

export function Library() {
  const { tools } = useTools()
  const [searchParams] = useSearchParams()
  const [cat, setCat] = useState<FilterId>(() => (searchParams.get('cat') as FilterId) ?? 'all')
  const activeCategoryLabel = CATEGORIES.find(c => c.id === cat)?.label

  useEffect(() => {
    const c = searchParams.get('cat') as FilterId
    if (c) setCat(c)
    setSearch(searchParams.get('q') ?? '')
  }, [searchParams])
  const [search, setSearch] = useState(() => searchParams.get('q') ?? '')
  const { bookmarks: bookmarkedIds } = useBookmarks()
  const [sort, setSort] = useState<SortId>('popular')
  const [sortOpen, setSortOpen] = useState(false)
  const sortRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    function handleClick(e: MouseEvent) {
      if (sortRef.current && !sortRef.current.contains(e.target as Node)) setSortOpen(false)
    }
    document.addEventListener('mousedown', handleClick)
    return () => document.removeEventListener('mousedown', handleClick)
  }, [])

  const filtered = useMemo(() => {
    let result = tools
    if (cat === 'saved') result = result.filter(t => bookmarkedIds.includes(t.id))
    else if (cat !== 'all') result = result.filter(t => t.cat === cat)
    if (search) {
      const q = search.toLowerCase()
      result = result.filter(
        t => t.name.toLowerCase().includes(q) || t.desc.toLowerCase().includes(q)
      )
    }
    if (sort === 'popular') result = [...result].sort((a, b) => b.downloads - a.downloads)
    else if (sort === 'alpha') result = [...result].sort((a, b) => a.name.localeCompare(b.name))
    else if (sort === 'risk') result = [...result].sort((a, b) => b.riskScore - a.riskScore)
    return result
  }, [cat, search, sort, bookmarkedIds, tools])

  return (
    <div className="min-h-screen flex flex-col">
      <Nav />

      {/* Page header */}
      <div className="border-b border-[rgba(255,255,255,0.06)] pt-24 pb-8 px-4 sm:px-6">
        <div className="max-w-[1140px] mx-auto">
          <h1
            className="font-semibold text-head leading-tight mb-2"
            style={{ fontSize: 'clamp(1.75rem, 3vw, 2.5rem)', letterSpacing: '-0.022em' }}
          >
            {activeCategoryLabel ?? 'All Scripts'}
          </h1>
          <div className="flex items-center justify-between mt-2">
            <p className="text-[15px]" style={{ color: '#8a8f98' }}>
              {filtered.length} {filtered.length === 1 ? 'script' : 'scripts'}
            </p>

            {/* Sort dropdown */}
            <div ref={sortRef} className="relative">
              <button
                onClick={() => setSortOpen(o => !o)}
                className={cn(
                  'inline-flex items-center gap-2 px-3 py-1.5 rounded-lg border text-[13px] font-medium transition-all duration-150',
                  sortOpen
                    ? 'bg-bg3 border-accent/40 text-body'
                    : 'bg-bg2 border-rule text-dim hover:text-body hover:bg-bg3 hover:border-white/10'
                )}
              >
                <ArrowUpDown size={13} />
                Sort: {SORT_OPTIONS.find(o => o.id === sort)?.label}
                <ChevronDown size={12} className={cn('transition-transform duration-150', sortOpen && 'rotate-180')} />
              </button>

              {sortOpen && (
                <div className="dropdown-in absolute right-0 top-full mt-1.5 w-44 bg-bg2 border border-rule rounded-xl shadow-[0_8px_32px_rgba(0,0,0,0.4)] overflow-hidden z-50">
                  {SORT_OPTIONS.map(({ id, label, Icon }) => (
                    <button
                      key={id}
                      onClick={() => { setSort(id); setSortOpen(false) }}
                      className={cn(
                        'w-full flex items-center gap-2.5 px-3.5 py-2.5 text-[13px] transition-colors duration-100',
                        sort === id
                          ? 'text-accent bg-accent/8'
                          : 'text-dim hover:text-body hover:bg-white/4'
                      )}
                    >
                      <Icon size={13} />
                      {label}
                      {sort === id && (
                        <span className="ml-auto w-1.5 h-1.5 rounded-full bg-accent" />
                      )}
                    </button>
                  ))}
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      <main id="tools" className="max-w-[1140px] mx-auto w-full px-4 sm:px-6 py-8 pb-16 md:py-10 md:pb-20 flex-1">
        {filtered.length === 0 ? (
          <div className="text-center py-24 text-dim card-in">
            <p className="text-[16px] mb-2 text-head">No scripts found</p>
            <p className="text-[14px]">
              {cat === 'saved'
                ? 'Bookmark scripts with the bookmark icon to save them here.'
                : 'Try adjusting your search or category filter.'}
            </p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
            {filtered.map((tool, i) => (
              <div
                key={tool.id}
                className="card-in"
                style={{ animationDelay: `${Math.min(Math.floor(i / 3), 5) * 60}ms` }}
              >
                <ToolCard tool={tool} />
              </div>
            ))}
          </div>
        )}
      </main>

      <Footer />
      <ScrollTop />
    </div>
  )
}
