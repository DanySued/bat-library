import { useState, useEffect, useRef } from 'react'
import { Link, useSearchParams, useNavigate } from 'react-router-dom'
import { Terminal, Github, Bookmark, Search, X, LogIn, LogOut, Shield } from 'lucide-react'
import { cn } from '@/lib/utils'
import { CATEGORIES } from '@/data/tools'
import { getIcon } from '@/lib/icons'
import { useAuth } from '@/contexts/AuthContext'

const cats = CATEGORIES.filter(c => c.id !== 'all' && c.id !== 'saved')

export function Nav() {
  const { user, isAdmin, signOut, openAuthModal } = useAuth()
  const [scrolled, setScrolled] = useState(false)
  const [menuOpen, setMenuOpen] = useState(false)
  const [searchParams] = useSearchParams()
  const activeCat = searchParams.get('cat')
  const navigate = useNavigate()
  const searchRef = useRef<HTMLInputElement>(null)
  const mobileSearchRef = useRef<HTMLInputElement>(null)

  const [query, setQuery] = useState(() => searchParams.get('q') ?? '')

  useEffect(() => {
    setQuery(searchParams.get('q') ?? '')
  }, [searchParams])

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
        e.preventDefault()
        if (menuOpen) mobileSearchRef.current?.focus()
        else searchRef.current?.focus()
      }
      if (e.key === 'Escape') searchRef.current?.blur()
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [menuOpen])

  function handleSearch(value: string) {
    setQuery(value)
    const params = new URLSearchParams()
    if (activeCat) params.set('cat', activeCat)
    if (value) params.set('q', value)
    navigate(`/bat${params.toString() ? `?${params.toString()}` : ''}`)
  }

  function clearSearch() {
    handleSearch('')
    searchRef.current?.focus()
  }

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 16)
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
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
      <div className="max-w-[1344px] mx-auto px-6 h-full flex items-center gap-8">

        {/* Logo */}
        <Link to="/" className="flex items-center gap-2.5 flex-shrink-0">
          <div className="w-7 h-7 bg-accent rounded-md flex items-center justify-center flex-shrink-0">
            <Terminal size={14} className="text-bg" strokeWidth={2.5} />
          </div>
          <span className="font-semibold text-[15px] text-head tracking-[-0.3px]">
            Bat Library
          </span>
        </Link>

        {/* Category links — desktop */}
        <div className="hidden md:flex items-center gap-1 flex-1">
          {cats.map(cat => {
            const IconComp = getIcon(cat.icon)
            const isActive = activeCat === cat.id
            return (
              <Link
                key={cat.id}
                to={`/bat?cat=${cat.id}`}
                className={cn(
                  'flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-[13px] transition-colors duration-150',
                  isActive
                    ? 'text-accent bg-accent/10'
                    : 'text-dim hover:text-head hover:bg-white/5'
                )}
              >
                {IconComp && <IconComp size={13} />}
                {cat.label}
              </Link>
            )
          })}
        </div>

        {/* Search — desktop */}
        <div className="hidden md:flex items-center relative group flex-shrink-0">
          <Search size={13} className="absolute left-3 text-dim pointer-events-none transition-colors duration-150 group-focus-within:text-accent" />
          <input
            ref={searchRef}
            type="text"
            value={query}
            onChange={e => handleSearch(e.target.value)}
            placeholder="Search scripts..."
            className={cn(
              'h-8 pl-8 pr-8 rounded-lg border text-[13px] bg-bg2 text-body placeholder:text-dim/50',
              'outline-none transition-all duration-200',
              'w-44 focus:w-56',
              query
                ? 'border-accent/40 bg-accent/5'
                : 'border-rule hover:border-white/12 focus:border-accent/40 focus:bg-accent/5'
            )}
          />
          {query ? (
            <button
              onClick={clearSearch}
              className="absolute right-2.5 text-dim hover:text-head transition-colors"
              aria-label="Clear search"
            >
              <X size={12} />
            </button>
          ) : (
            <span className="absolute right-2.5 text-[10px] font-medium text-dim/40 pointer-events-none select-none leading-none bg-white/5 px-1.5 py-1 rounded">
              ⌘K
            </span>
          )}
        </div>

        {/* Saved — desktop */}
        <Link
          to="/saved"
          className="hidden md:flex items-center justify-center w-8 h-8 rounded-lg text-dim hover:text-head hover:bg-white/5 transition-colors duration-150 flex-shrink-0"
          aria-label="Saved scripts"
        >
          <Bookmark size={15} />
        </Link>

        {/* Auth — desktop */}
        {user ? (
          <div className="hidden md:flex items-center gap-2 flex-shrink-0">
            {isAdmin && (
              <Link
                to="/admin"
                className="flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg text-[13px] text-accent hover:bg-accent/10 transition-colors duration-150"
                aria-label="Admin panel"
              >
                <Shield size={13} />
              </Link>
            )}
            <span
              className="w-7 h-7 rounded-full bg-accent/20 flex items-center justify-center text-accent text-[11px] font-semibold flex-shrink-0 select-none"
              title={user.email ?? ''}
            >
              {(user.email ?? 'U')[0].toUpperCase()}
            </span>
            <button
              onClick={() => signOut()}
              className="flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg text-[13px] text-dim hover:text-head hover:bg-white/5 transition-colors duration-150"
              aria-label="Sign out"
            >
              <LogOut size={13} />
            </button>
          </div>
        ) : (
          <button
            onClick={openAuthModal}
            className="hidden md:flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-[13px] text-dim hover:text-head hover:bg-white/5 transition-colors duration-150 flex-shrink-0"
          >
            <LogIn size={14} />
            Log in
          </button>
        )}

        {/* GitHub — desktop */}
        <a
          href="https://github.com/DanySued/bat-library"
          target="_blank"
          rel="noopener noreferrer"
          className="hidden md:flex items-center gap-2 px-3 py-1.5 rounded-lg text-[13px] text-dim hover:text-head hover:bg-white/5 transition-colors duration-150 flex-shrink-0"
        >
          <Github size={15} />
          GitHub
        </a>

        {/* Mobile hamburger */}
        <button
          onClick={() => setMenuOpen(v => !v)}
          className="md:hidden ml-auto text-dim hover:text-head p-3 -mr-3 transition-colors"
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
      <div
        className="md:hidden overflow-hidden"
        style={{
          maxHeight: menuOpen ? 640 : 0,
          opacity: menuOpen ? 1 : 0,
          transition: 'max-height 0.3s cubic-bezier(0.22,1,0.36,1), opacity 0.2s ease',
        }}
      >
        <div className="bg-bg2/95 backdrop-blur-lg border-b border-[rgba(255,255,255,0.06)] px-6 py-4 space-y-1">
          {/* Mobile search */}
          <div className="relative mb-3">
            <Search size={14} className="absolute left-3 top-1/2 -translate-y-1/2 text-dim pointer-events-none" />
            <input
              ref={mobileSearchRef}
              type="text"
              value={query}
              onChange={e => { handleSearch(e.target.value); }}
              placeholder="Search scripts..."
              className="w-full h-9 pl-9 pr-9 rounded-lg border border-rule bg-bg3 text-[14px] text-body placeholder:text-dim/50 outline-none focus:border-accent/40 focus:bg-accent/5 transition-colors duration-150"
            />
            {query && (
              <button
                onClick={() => { clearSearch(); mobileSearchRef.current?.focus() }}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-dim hover:text-head transition-colors"
              >
                <X size={13} />
              </button>
            )}
          </div>

          {cats.map(cat => {
            const IconComp = getIcon(cat.icon)
            return (
              <Link
                key={cat.id}
                to={`/bat?cat=${cat.id}`}
                onClick={() => setMenuOpen(false)}
                className="flex items-center gap-2.5 px-3 py-2.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors"
              >
                {IconComp && <IconComp size={14} />}
                {cat.label}
              </Link>
            )
          })}
          <Link
            to="/saved"
            onClick={() => setMenuOpen(false)}
            className="flex items-center gap-2.5 px-3 py-2.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors border-t border-[rgba(255,255,255,0.05)] mt-2 pt-4"
          >
            <Bookmark size={14} />
            Saved
          </Link>
          <a
            href="https://github.com/DanySued/bat-library"
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center gap-2.5 px-3 py-2.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors"
          >
            <Github size={14} />
            GitHub
          </a>
          {user ? (
            <>
              {isAdmin && (
                <Link
                  to="/admin"
                  onClick={() => setMenuOpen(false)}
                  className="flex items-center gap-2.5 px-3 py-2.5 text-[14px] text-accent hover:bg-accent/10 rounded-lg transition-colors"
                >
                  <Shield size={14} />
                  Admin Panel
                </Link>
              )}
              <button
                onClick={() => { signOut(); setMenuOpen(false) }}
                className="flex items-center gap-2.5 px-3 py-2.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors w-full text-left"
              >
                <LogOut size={14} />
                Sign out
              </button>
            </>
          ) : (
            <button
              onClick={() => { openAuthModal(); setMenuOpen(false) }}
              className="flex items-center gap-2.5 px-3 py-2.5 text-[14px] text-dim hover:text-head rounded-lg hover:bg-white/5 transition-colors w-full text-left"
            >
              <LogIn size={14} />
              Log in
            </button>
          )}
        </div>
      </div>
    </nav>
  )
}
