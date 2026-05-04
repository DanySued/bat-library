import { useState, useMemo, useCallback } from 'react'
import { Nav } from '@/components/layout/Nav'
import { Footer } from '@/components/layout/Footer'
import { CategoryFilter } from '@/components/CategoryFilter'
import { ToolCard } from '@/components/ToolCard'
import { ScrollTop } from '@/components/ScrollTop'
import { TOOLS } from '@/data/tools'
import { getBookmarks } from '@/lib/bookmarks'
import type { Category } from '@/data/tools'

type FilterId = 'all' | 'saved' | Category

export function Library() {
  const [cat, setCat] = useState<FilterId>('all')
  const [search, setSearch] = useState('')
  const [bookmarkedIds, setBookmarkedIds] = useState<string[]>(() => getBookmarks())

  const handleBookmarkChange = useCallback(() => {
    setBookmarkedIds(getBookmarks())
  }, [])

  const filtered = useMemo(() => {
    let result = TOOLS
    if (cat === 'saved') result = result.filter(t => bookmarkedIds.includes(t.id))
    else if (cat !== 'all') result = result.filter(t => t.cat === cat)
    if (search) {
      const q = search.toLowerCase()
      result = result.filter(
        t => t.name.toLowerCase().includes(q) || t.desc.toLowerCase().includes(q)
      )
    }
    return result
  }, [cat, search, bookmarkedIds])

  return (
    <div className="min-h-screen flex flex-col">
      <Nav search={search} onSearch={setSearch} />

      {/* Page header */}
      <div className="border-b border-[rgba(255,255,255,0.06)] pt-24 pb-10 px-6">
        <div className="max-w-[1140px] mx-auto">
          <p className="text-[11px] font-semibold tracking-[0.1em] uppercase text-orange mb-3">
            Bat Library
          </p>
          <h1
            className="font-semibold text-head leading-tight mb-2"
            style={{ fontSize: 'clamp(1.75rem, 3vw, 2.5rem)', letterSpacing: '-0.022em' }}
          >
            Windows Batch Scripts
          </h1>
          <p className="text-[15px]" style={{ color: '#8a8f98' }}>
            {TOOLS.length} scripts to clean, optimize, back up, and customize your PC.
          </p>
        </div>
      </div>

      <main id="tools" className="max-w-[1140px] mx-auto w-full px-6 py-10 pb-20 fade-in flex-1">
        <CategoryFilter
          active={cat}
          onChange={(id) => setCat(id as FilterId)}
          savedCount={bookmarkedIds.length}
        />

        {filtered.length === 0 ? (
          <div className="text-center py-24 text-dim">
            <p className="text-[16px] mb-2 text-head">No scripts found</p>
            <p className="text-[14px]">
              {cat === 'saved'
                ? 'Bookmark scripts with the bookmark icon to save them here.'
                : 'Try adjusting your search or category filter.'}
            </p>
          </div>
        ) : (
          <>
            <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
              {filtered.map(tool => (
                <ToolCard
                  key={tool.id}
                  tool={tool}
                  onBookmarkChange={handleBookmarkChange}
                />
              ))}
            </div>

            <p className="mt-10 text-center text-[13px]" style={{ color: '#8a8f98' }}>
              Showing {filtered.length} of {TOOLS.length} scripts
            </p>
          </>
        )}
      </main>

      <Footer />
      <ScrollTop />
    </div>
  )
}
