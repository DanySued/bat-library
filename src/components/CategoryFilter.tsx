import { CATEGORIES } from '@/data/tools'
import { getIcon } from '@/lib/icons'
import { cn } from '@/lib/utils'

interface CategoryFilterProps {
  active: string
  onChange: (id: string) => void
  savedCount: number
}

export function CategoryFilter({ active, onChange, savedCount }: CategoryFilterProps) {
  return (
    <div className="flex gap-2 flex-wrap mb-7">
      {CATEGORIES.map(cat => {
        const IconComp = getIcon(cat.icon)
        const isActive = active === cat.id
        return (
          <button
            key={cat.id}
            onClick={() => onChange(cat.id)}
            className={cn(
              'inline-flex items-center gap-1.5 px-4 py-1.5 rounded-full text-[13px] border transition-all duration-150 font-medium',
              isActive
                ? 'bg-white text-black border-accent font-bold'
                : 'bg-bg2 text-dim border-rule hover:text-body hover:bg-bg3'
            )}
          >
            {IconComp && <IconComp size={12} />}
            {cat.label}
            {cat.id === 'saved' && savedCount > 0 && (
              <span className={cn(
                'ml-0.5 text-[10px] px-1.5 py-0 rounded-full tabular-nums',
                isActive ? 'bg-bg/20' : 'bg-accent/15 text-accent'
              )}>
                {savedCount}
              </span>
            )}
          </button>
        )
      })}
    </div>
  )
}
