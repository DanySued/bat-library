import * as React from 'react'
import { cn } from '@/lib/utils'

export interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {}

const Input = React.forwardRef<HTMLInputElement, InputProps>(
  ({ className, ...props }, ref) => (
    <input
      ref={ref}
      className={cn(
        'bg-transparent border-none outline-none text-body text-[13px] w-full font-serif placeholder:text-dim',
        className
      )}
      {...props}
    />
  )
)
Input.displayName = 'Input'

export { Input }
