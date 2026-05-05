import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { ArrowRight, Github } from 'lucide-react'
import { TOOLS } from '@/data/tools'
import { TypingTerminal } from '@/components/TypingTerminal'

const ROTATING_WORDS = ['Cleaner', 'Faster', 'Organized', 'Protected']

export function LandingHero() {
  const [wordIndex, setWordIndex] = useState(0)
  const [visible, setVisible] = useState(true)

  useEffect(() => {
    const interval = setInterval(() => {
      setVisible(false)
      setTimeout(() => {
        setWordIndex(i => (i + 1) % ROTATING_WORDS.length)
        setVisible(true)
      }, 300)
    }, 2500)
    return () => clearInterval(interval)
  }, [])

  return (
    <section className="relative min-h-screen flex flex-col items-center justify-center px-4 sm:px-6 pt-20 pb-12 sm:pt-24 sm:pb-20 text-center overflow-hidden">
      {/* Radial glow */}
      <div
        className="absolute inset-x-0 top-0 pointer-events-none"
        style={{
          height: '70vh',
          background: 'radial-gradient(ellipse 80% 60% at 50% -10%, rgba(87,181,231,0.08) 0%, transparent 70%)',
        }}
      />

      <div className="relative z-10 flex flex-col items-center max-w-[800px]">
        {/* Eyebrow */}
        <div className="hero-eyebrow flex items-center gap-2 mb-8">
          <span className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-accent/10 border border-accent/20 text-accent text-[12px] font-medium">
            <span className="w-1.5 h-1.5 rounded-full bg-accent animate-pulse" />
            {TOOLS.length} Free Windows Scripts
          </span>
        </div>

        {/* Headline */}
        <h1
          className="hero-h1 font-semibold text-head leading-[1.05] mb-6"
          style={{ fontSize: 'clamp(2.5rem, 6vw, 4.5rem)', letterSpacing: '-0.022em' }}
        >
          Your Windows,{' '}
          <br className="hidden sm:block" />
          <span
            className="text-accent"
            style={{
              display: 'inline-block',
              opacity: visible ? 1 : 0,
              transform: visible ? 'translateY(0)' : 'translateY(8px)',
              transition: 'opacity 0.3s ease, transform 0.3s ease',
              minWidth: '6ch',
            }}
          >
            {ROTATING_WORDS[wordIndex]}.
          </span>
        </h1>

        {/* Subtitle */}
        <p
          className="hero-p text-[17px] leading-relaxed max-w-[520px] mb-10"
          style={{ color: '#8a8f98' }}
        >
          A curated library of batch scripts to clean, optimize, back up, and customize Windows.
          Source code on every script — copy, download, and run.
        </p>

        {/* CTAs — arrow nudge on hover */}
        <div className="hero-cta flex items-center gap-3 flex-wrap justify-center">
          <Link
            to="/bat"
            className="group inline-flex items-center gap-2 px-6 py-3 bg-white text-black rounded-full font-semibold text-[14px] transition-colors duration-200 hover:bg-white/90 active:scale-[0.98]"
          >
            Browse Bat Library
            <ArrowRight size={15} className="transition-transform duration-200 group-hover:translate-x-1" />
          </Link>
          <a
            href="https://github.com/DanySued/bat-library"
            target="_blank"
            rel="noopener noreferrer"
            className="group inline-flex items-center gap-2 px-6 py-3 border border-[rgba(255,255,255,0.1)] text-body rounded-full text-[14px] transition-colors duration-200 hover:bg-white/5 active:scale-[0.98]"
          >
            <Github size={15} />
            View on GitHub
          </a>
        </div>

        {/* Fine print */}
        <p className="hero-cta mt-6 text-[12px]" style={{ color: '#8a8f98' }}>
          No installation required · Right-click → Run as administrator
        </p>
      </div>

      {/* Typing terminal mockup */}
      <div className="hero-cta relative z-10 mt-10 sm:mt-16 w-full max-w-[760px]">
        <TypingTerminal />
      </div>
    </section>
  )
}
