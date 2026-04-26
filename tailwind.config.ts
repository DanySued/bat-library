import type { Config } from 'tailwindcss'
import animate from 'tailwindcss-animate'

export default {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        bg:  '#1A1714',
        bg2: '#211C18',
        bg3: '#2A2420',
        bg4: '#302A25',
        orange: { DEFAULT: '#CF7B4B', dim: '#8A5230' },
        body: '#D4CCC4',
        dim:  '#8A7F76',
        head: '#EDE8E2',
        rule: '#3D3028',
        'code-bg': '#13110F',
        'code-fg': '#9DC499',
        danger: '#D64949',
      },
      fontFamily: {
        serif: ['Lora', 'Georgia', 'serif'],
        mono:  ['JetBrains Mono', 'Geist Mono', 'monospace'],
      },
    },
  },
  plugins: [animate],
} satisfies Config
