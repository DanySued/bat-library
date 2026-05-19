import { Link } from 'react-router-dom'
import { Bot, ArrowLeft } from 'lucide-react'
import { Nav } from '@/components/layout/Nav'
import { Footer } from '@/components/layout/Footer'
import { ToolCard } from '@/components/ToolCard'
import { ScrollTop } from '@/components/ScrollTop'
import { useTools } from '@/contexts/ToolsContext'

export function Claude() {
  const { tools: allTools } = useTools()
  const tools = allTools.filter(t => t.cat === 'claude')

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
            <Bot size={20} className="text-accent" />
            <h1
              className="font-semibold text-head leading-tight"
              style={{ fontSize: 'clamp(1.75rem, 3vw, 2.5rem)', letterSpacing: '-0.022em' }}
            >
              Claude Scripts
            </h1>
          </div>
          <p className="text-[15px]" style={{ color: '#8a8f98' }}>
            {tools.length} {tools.length === 1 ? 'script' : 'scripts'} for setting up and using Claude
          </p>
        </div>
      </div>

      <main className="max-w-[1140px] mx-auto w-full px-4 sm:px-6 py-8 pb-16 md:py-10 md:pb-20 fade-in flex-1">
        {tools.length === 0 ? (
          <div className="text-center py-24">
            <Bot size={32} className="text-dim mx-auto mb-4" />
            <p className="text-[16px] mb-2 text-head">No Claude scripts yet</p>
            <p className="text-[14px] text-dim">Check back soon.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
            {tools.map(tool => (
              <ToolCard key={tool.id} tool={tool} />
            ))}
          </div>
        )}
      </main>

      <Footer />
      <ScrollTop />
    </div>
  )
}
