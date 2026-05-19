import * as LucideIcons from 'lucide-react'
import type React from 'react'

export type IconProps = { size?: number; className?: string; fill?: string }
export type IconComponent = React.ComponentType<IconProps>

export function getIcon(name: string): IconComponent | null {
  const icon = (LucideIcons as unknown as Record<string, IconComponent>)[name]
  return icon != null ? icon : null
}
