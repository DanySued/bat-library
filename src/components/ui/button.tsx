import * as React from 'react'
import { cn } from '@/lib/utils'

export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'default' | 'secondary' | 'ghost' | 'outline' | 'danger'
  size?: 'sm' | 'md' | 'lg'
  asChild?: boolean
}

const variantClasses: Record<NonNullable<ButtonProps['variant']>, string> = {
  default:   'bg-white text-black font-bold hover:opacity-85',
  secondary: 'bg-bg3 text-body border border-rule hover:bg-bg4 hover:border-dim',
  ghost:     'text-dim hover:text-body hover:bg-bg2',
  outline:   'border border-rule text-dim hover:border-accent hover:text-accent',
  danger:    'bg-danger/10 text-danger border border-danger/30 hover:bg-danger/20',
}

const sizeClasses: Record<NonNullable<ButtonProps['size']>, string> = {
  sm: 'h-7 px-3 text-[12px] rounded-md gap-1',
  md: 'h-9 px-4 text-[13px] rounded-lg gap-1.5',
  lg: 'h-11 px-6 text-[15px] rounded-lg gap-2',
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = 'default', size = 'md', children, ...props }, ref) => {
    return (
      <button
        ref={ref}
        className={cn(
          'inline-flex items-center justify-center font-serif transition-all duration-150 disabled:opacity-50 disabled:cursor-not-allowed',
          variantClasses[variant],
          sizeClasses[size],
          className
        )}
        {...props}
      >
        {children}
      </button>
    )
  }
)
Button.displayName = 'Button'

export { Button }
