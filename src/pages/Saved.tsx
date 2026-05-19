import { Link } from 'react-router-dom'
import { Bookmark, ArrowLeft } from 'lucide-react'
import { Nav } from '@/components/layout/Nav'
import { Footer } from '@/components/layout/Footer'
import { ToolCard } from '@/components/ToolCard'
import { ScrollTop } from '@/components/ScrollTop'
import { useBookmarks } from '@/contexts/BookmarksContext'
import { useTools } from '@/contexts/ToolsContext'

export function Saved() {
  const { tools } = useTools()
  const { bookmarks } = useBookmarks()
  const saved = tools.filter(t => bookmarks.includes(t.id))

  return (
    <div className="min-h-screen flex flex-col">
      <Nav />

      <div className="border-b border-[rgba(255,255,255,0.06)] pt-24 pb-8 px-4 sm:px-6">
        <div className="max-w-[1140px] mx-auto">
          <Link
            to="/bat"
            className="inline-flex items-center gap-1.5 text-[12px] text-dim hover:text-head transition-colors mb-6"
          >
            <ArrowLeft size={12} /> Back to library
          </Link>
          <div className="flex items-center gap-3 mb-2">
            <Bookmark size={20} className="text-accent" fill="currentColor" />
            <h1
              className="font-semibold text-head leading-tight"
              style={{ fontSize: 'clamp(1.75rem, 3vw, 2.5rem)', letterSpacing: '-0.022em' }}
            >
              Saved Scripts
            </h1>
          </div>
          <p className="text-[15px]" style={{ color: '#8a8f98' }}>
            {saved.length} {saved.length === 1 ? 'script' : 'scripts'} bookmarked
          </p>
        </div>
      </div>

      <main className="max-w-[1140px] mx-auto w-full px-4 sm:px-6 py-8 pb-16 md:py-10 md:pb-20 fade-in flex-1">
        {saved.length === 0 ? (
          <div className="text-center py-24">
            <Bookmark size={32} className="text-dim mx-auto mb-4" />
            <p className="text-[16px] mb-2 text-head">Nothing saved yet</p>
            <p className="text-[14px] text-dim mb-6">
              Bookmark scripts from the library to find them here.
            </p>
            <Link
              to="/bat"
              className="inline-flex items-center gap-2 px-4 py-2 bg-white text-black rounded-lg text-[13px] font-medium hover:opacity-85 transition-opacity"
            >
              Browse library
            </Link>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
            {saved.map(tool => (
              <ToolCard
                key={tool.id}
                tool={tool}
              />
            ))}
          </div>
        )}
      </main>

      <Footer />
      <ScrollTop />
    </div>
  )
}
