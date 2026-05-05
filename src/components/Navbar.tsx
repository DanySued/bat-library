import { Search } from 'lucide-react'
import { Input } from '@/components/ui/input'
import { cn } from '@/lib/utils'

interface NavbarProps {
  search: string
  onSearch: (v: string) => void
  className?: string
}

export function Navbar({ search, onSearch, className }: NavbarProps) {
  return (
    <nav
      className={cn(
        'sticky top-0 z-50 bg-bg/90 backdrop-blur-md border-b border-rule',
        className
      )}
    >
      <div className="max-w-[1140px] mx-auto px-6 h-14 flex items-center gap-4">
        {/* Logo */}
        <a href="/" className="flex items-center gap-2.5 flex-shrink-0 group">
          <div className="w-7 h-7 bg-accent rounded-md flex items-center justify-center text-[13px] font-black text-bg select-none">
            W
          </div>
          <span className="font-bold text-[15px] text-head tracking-[-0.3px]">
            WinTools
          </span>
        </a>

        {/* Search */}
        <div className="flex items-center gap-2 bg-bg2 border border-rule rounded-lg px-3 py-1.5 flex-[0_1_280px] ml-auto focus-within:border-accent transition-colors duration-150">
          <Search size={13} className="text-dim flex-shrink-0" />
          <Input
            type="text"
            placeholder="Search tools..."
            value={search}
            onChange={e => onSearch(e.target.value)}
          />
          {search && (
            <button
              onClick={() => onSearch('')}
              className="text-dim hover:text-accent transition-colors duration-150 flex-shrink-0 text-[11px]"
            >
              ✕
            </button>
          )}
        </div>
      </div>
    </nav>
  )
}
