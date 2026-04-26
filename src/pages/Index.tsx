import { useState, useMemo, useCallback } from 'react'
import { Navbar } from '@/components/Navbar'
import { Hero } from '@/components/Hero'
import { CategoryFilter } from '@/components/CategoryFilter'
import { ToolCard } from '@/components/ToolCard'
import { ScrollTop } from '@/components/ScrollTop'
import { TOOLS } from '@/data/tools'
import { getBookmarks } from '@/lib/bookmarks'
import type { Category } from '@/data/tools'

type FilterId = 'all' | 'saved' | Category

export function Index() {
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
    <div className="min-h-screen">
      <Navbar search={search} onSearch={setSearch} />
      <Hero />

      <main id="tools" className="max-w-[1140px] mx-auto px-6 py-12 pb-20 fade-in">
        <CategoryFilter
          active={cat}
          onChange={(id) => setCat(id as FilterId)}
          savedCount={bookmarkedIds.length}
        />

        {filtered.length === 0 ? (
          <div className="text-center py-16 text-dim">
            <p className="text-[16px] mb-2">No tools found</p>
            <p className="text-[13px]">
              {cat === 'saved'
                ? 'Bookmark tools with the bookmark icon to see them here.'
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

            <p className="mt-10 text-center text-dim text-[13px]">
              Showing {filtered.length} of {TOOLS.length} tools
            </p>
          </>
        )}
      </main>

      <ScrollTop />
    </div>
  )
}
