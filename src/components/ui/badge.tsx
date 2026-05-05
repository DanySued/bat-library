import * as React from 'react'
import { cn } from '@/lib/utils'

export interface BadgeProps extends React.HTMLAttributes<HTMLSpanElement> {
  variant?: 'default' | 'secondary' | 'danger' | 'outline'
}

const variantClasses: Record<NonNullable<BadgeProps['variant']>, string> = {
  default:   'bg-accent/10 text-accent border border-accent/30',
  secondary: 'bg-bg3 text-dim border border-rule',
  danger:    'bg-danger/10 text-danger border border-danger/30',
  outline:   'border border-rule text-dim',
}

export function Badge({ className, variant = 'secondary', children, ...props }: BadgeProps) {
  return (
    <span
      className={cn(
        'inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[11px] font-mono',
        variantClasses[variant],
        className
      )}
      {...props}
    >
      {children}
    </span>
  )
}
