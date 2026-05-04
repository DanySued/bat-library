import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { ArrowRight, Github } from 'lucide-react'
import { TOOLS } from '@/data/tools'

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
    <section className="relative min-h-screen flex flex-col items-center justify-center px-6 pt-24 pb-20 text-center overflow-hidden">
      {/* Radial glow */}
      <div
        className="absolute inset-x-0 top-0 pointer-events-none"
        style={{
          height: '70vh',
          background: 'radial-gradient(ellipse 80% 60% at 50% -10%, rgba(207,123,75,0.12) 0%, transparent 70%)',
        }}
      />

      <div className="relative z-10 flex flex-col items-center max-w-[800px]">
        {/* Eyebrow */}
        <div className="hero-eyebrow flex items-center gap-2 mb-8">
          <span className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-orange/10 border border-orange/20 text-orange text-[12px] font-medium">
            <span className="w-1.5 h-1.5 rounded-full bg-orange animate-pulse" />
            {TOOLS.length} Free Windows Scripts
          </span>
        </div>

        {/* Headline */}
        <h1
          className="hero-h1 font-semibold text-head leading-[1.05] mb-6"
          style={{
            fontSize: 'clamp(2.5rem, 6vw, 4.5rem)',
            letterSpacing: '-0.022em',
          }}
        >
          Your Windows,{' '}
          <br className="hidden sm:block" />
          <span
            className="text-orange"
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

        {/* CTAs */}
        <div className="hero-cta flex items-center gap-3 flex-wrap justify-center">
          <Link
            to="/bat"
            className="inline-flex items-center gap-2 px-6 py-3 bg-orange text-bg rounded-full font-semibold text-[14px] transition-all duration-200 hover:scale-[1.02] active:scale-[0.98] hover:bg-orange/90"
          >
            Browse Bat Library
            <ArrowRight size={15} />
          </Link>
          <a
            href="https://github.com"
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-2 px-6 py-3 border border-[rgba(255,255,255,0.1)] text-body rounded-full text-[14px] transition-all duration-200 hover:scale-[1.02] active:scale-[0.98] hover:bg-white/5"
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

      {/* App mockup */}
      <div
        className="hero-cta relative z-10 mt-16 w-full max-w-[900px] rounded-2xl border border-[rgba(255,255,255,0.06)] bg-bg2 overflow-hidden"
        style={{ boxShadow: '0 24px 80px rgba(0,0,0,0.6)' }}
      >
        {/* Window chrome */}
        <div className="flex items-center gap-2 px-5 py-3 border-b border-[rgba(255,255,255,0.06)] bg-bg3">
          <span className="w-3 h-3 rounded-full bg-danger/60" />
          <span className="w-3 h-3 rounded-full bg-orange/40" />
          <span className="w-3 h-3 rounded-full bg-code-fg/40" />
          <span className="ml-4 text-[12px] text-dim font-mono">bat-library / CleanWindows_MASTER.bat</span>
        </div>
        {/* Fake code */}
        <div className="p-6 font-mono text-[12px] text-left leading-relaxed overflow-hidden" style={{ maxHeight: 220 }}>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>1</span>
            <span><span className="text-orange">@echo</span> <span className="text-body">off</span></span>
          </div>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>2</span>
            <span><span className="text-orange">title</span> <span className="text-code-fg">CleanWindows MASTER</span></span>
          </div>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>3</span>
            <span className="opacity-30"></span>
          </div>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>4</span>
            <span><span className="text-dim">:: Phase 1 — Remove bloatware</span></span>
          </div>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>5</span>
            <span><span className="text-orange">powershell</span> <span className="text-body">-Command</span> <span className="text-code-fg">"Get-AppxPackage *xbox* | Remove-AppxPackage"</span></span>
          </div>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>6</span>
            <span><span className="text-orange">powershell</span> <span className="text-body">-Command</span> <span className="text-code-fg">"Get-AppxPackage *bing* | Remove-AppxPackage"</span></span>
          </div>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>7</span>
            <span className="opacity-30"></span>
          </div>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>8</span>
            <span><span className="text-dim">:: Phase 2 — Disable telemetry</span></span>
          </div>
          <div className="flex gap-3 text-dim">
            <span className="select-none text-[rgba(255,255,255,0.2)] text-right" style={{ minWidth: 24 }}>9</span>
            <span><span className="text-orange">reg</span> <span className="text-body">add</span> <span className="text-code-fg">"HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"</span> <span className="text-body">/v AllowTelemetry /t REG_DWORD /d 0 /f</span></span>
          </div>
        </div>
        {/* Bottom fade */}
        <div
          className="absolute bottom-0 inset-x-0 h-16 pointer-events-none"
          style={{ background: 'linear-gradient(to bottom, transparent, #0f0f12)' }}
        />
      </div>
    </section>
  )
}
