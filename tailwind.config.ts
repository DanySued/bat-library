import type { Config } from 'tailwindcss'
import animate from 'tailwindcss-animate'

export default {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        bg:  '#07070a',
        bg2: '#0f0f12',
        bg3: '#141417',
        bg4: '#1c1c20',
        orange: { DEFAULT: '#CF7B4B', dim: '#8A5230' },
        body: '#d0d6e0',
        dim:  '#8a8f98',
        head: '#f7f8f8',
        rule: 'rgba(255,255,255,0.06)',
        'code-bg': '#0c0c10',
        'code-fg': '#9DC499',
        danger: '#D64949',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'sans-serif'],
        mono: ['JetBrains Mono', 'ui-monospace', 'monospace'],
      },
    },
  },
  plugins: [animate],
} satisfies Config
