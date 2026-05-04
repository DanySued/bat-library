import { useState, useEffect, useRef } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Terminal, ChevronDown, ExternalLink } from 'lucide-react'
import { cn } from '@/lib/utils'

interface NavProps {
  /** If provided, shows an inline search input in the nav */
  search?: string
  onSearch?: (v: string) => void
}

export function Nav({ search, onSearch }: NavProps) {
  const [scrolled, setScrolled] = useState(false)
  const [menuOpen, setMenuOpen] = useState(false)
  const [libOpen, setLibOpen] = useState(false)
  const libRef = useRef<HTMLDivElement>(null)
  const navigate = useNavigate()

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 16)
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  useEffect(() => {
    const handler = (e: MouseEvent) => {
      if (libRef.current && !libRef.current.contains(e.target as Node)) {
        setLibOpen(false)
      }
    }
    document.addEventListener('mousedown', handler)
    return () => document.removeEventListener('mousedown', handler)
  }, [])

  return (
    <nav
      className={cn(
        'fixed top-0 inset-x-0 z-50 transition-all duration-300',
        scrolled
          ? 'bg-bg/80 backdrop-blur-[20px] border-b border-[rgba(255,255,255,0.06)]'
          : 'bg-transparent'
      )}
      style={{ height: 64 }}
    >
      <div className="max-w-[1344px] mx-auto px-6 h-full flex items-center gap-6">
        {/* Logo */}
        <Link to="/" className="flex items-center gap-2.5 flex-shrink-0 group">
          <div className="w-7 h-7 bg-orange rounded-md flex items-center justify-center flex-shrink-0">
            <Terminal size={14} className="text-bg" strokeWidth={2.5} />
          </div>
          <span className="font-semibold text-[15px] text-head tracking-[-0.3px]">
            Bat Library
          </span>
        </Link>

        {/* Desktop links */}
        <div className="hidden md:flex items-center gap-1 ml-2">
          {/* Libraries dropdown */}
          <div className="relative" ref={libRef}>
            <button
              onClick={() => setLibOpen(v => !v)}
              className="flex items-center gap-1 px-3 py-1.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors duration-150"
            >
              Libraries
              <ChevronDown size={13} className={cn('transition-transform duration-200', libOpen && 'rotate-180')} />
            </button>
            {libOpen && (
              <div className="absolute top-full left-0 mt-1.5 w-52 bg-bg2 border border-[rgba(255,255,255,0.08)] rounded-xl shadow-[0_8px_32px_rgba(0,0,0,0.5)] overflow-hidden">
                <button
                  onClick={() => { navigate('/bat'); setLibOpen(false) }}
                  className="w-full flex items-center gap-3 px-4 py-3 text-[13px] hover:bg-bg3 transition-colors text-left"
                >
                  <div className="w-6 h-6 bg-orange/10 rounded-md flex items-center justify-center flex-shrink-0">
                    <Terminal size={11} className="text-orange" />
                  </div>
                  <div>
                    <div className="text-head font-medium leading-none mb-0.5">Bat Library</div>
                    <div className="text-dim text-[11px]">Windows batch scripts</div>
                  </div>
                </button>
                <div className="px-4 py-2.5 border-t border-[rgba(255,255,255,0.05)]">
                  <p className="text-[11px] text-dim flex items-center gap-1.5">
                    <span className="w-1.5 h-1.5 rounded-full bg-orange/40 inline-block" />
                    More libraries coming soon
                  </p>
                </div>
              </div>
            )}
          </div>

          <a
            href="https://github.com"
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center gap-1 px-3 py-1.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors duration-150"
          >
            GitHub
          </a>
        </div>

        {/* Search (library page only) */}
        {onSearch && (
          <div className="hidden md:flex items-center gap-2 bg-white/5 border border-[rgba(255,255,255,0.08)] rounded-lg px-3 py-1.5 flex-[0_1_240px] ml-auto focus-within:border-orange/50 transition-colors duration-150">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="text-dim flex-shrink-0">
              <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
            </svg>
            <input
              type="text"
              placeholder="Search tools..."
              value={search}
              onChange={e => onSearch(e.target.value)}
              className="bg-transparent text-[13px] text-body placeholder:text-dim outline-none w-full"
            />
            {search && (
              <button onClick={() => onSearch('')} className="text-dim hover:text-orange text-[11px] flex-shrink-0 transition-colors">✕</button>
            )}
          </div>
        )}

        {/* CTA */}
        <Link
          to="/bat"
          className={cn(
            'ml-auto hidden md:inline-flex items-center gap-1.5 px-4 py-1.5 rounded-full border text-[13px] font-medium transition-all duration-150 hover:scale-[1.02] active:scale-[0.98]',
            'bg-orange text-bg border-orange hover:bg-orange/90',
            onSearch && 'ml-3'
          )}
        >
          Browse Library
        </Link>

        {/* Mobile hamburger */}
        <button
          onClick={() => setMenuOpen(v => !v)}
          className="md:hidden ml-auto text-dim hover:text-head p-2 -mr-2 transition-colors"
          aria-label="Menu"
        >
          <div className="space-y-1.5">
            <span className={cn('block w-5 h-px bg-current transition-all duration-200', menuOpen && 'rotate-45 translate-y-2')} />
            <span className={cn('block w-5 h-px bg-current transition-opacity duration-200', menuOpen && 'opacity-0')} />
            <span className={cn('block w-5 h-px bg-current transition-all duration-200', menuOpen && '-rotate-45 -translate-y-2')} />
          </div>
        </button>
      </div>

      {/* Mobile menu */}
      {menuOpen && (
        <div className="md:hidden bg-bg2/95 backdrop-blur-lg border-b border-[rgba(255,255,255,0.06)] px-6 py-4 space-y-1">
          <button
            onClick={() => { navigate('/bat'); setMenuOpen(false) }}
            className="block w-full text-left px-3 py-2.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors"
          >
            Bat Library
          </button>
          <a
            href="https://github.com"
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center gap-2 px-3 py-2.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors"
          >
            GitHub <ExternalLink size={12} />
          </a>
          {onSearch && (
            <div className="flex items-center gap-2 bg-white/5 border border-[rgba(255,255,255,0.08)] rounded-lg px-3 py-2 mt-2">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="text-dim">
                <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
              </svg>
              <input
                type="text"
                placeholder="Search tools..."
                value={search}
                onChange={e => onSearch(e.target.value)}
                className="bg-transparent text-[13px] text-body placeholder:text-dim outline-none w-full"
              />
            </div>
          )}
        </div>
      )}
    </nav>
  )
}
