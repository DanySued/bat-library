import { useEffect } from 'react'
import { ArrowDown } from 'lucide-react'
import { TOOLS } from '@/data/tools'

export function Hero() {
  useEffect(() => {
    const bar = document.getElementById('progress-bar')
    if (!bar) return
    const onScroll = () => {
      const scrolled = window.scrollY
      const total = document.documentElement.scrollHeight - window.innerHeight
      bar.style.width = total > 0 ? `${(scrolled / total) * 100}%` : '0%'
    }
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  const catCount = 7
  const toolCount = TOOLS.length

  return (
    <>
      <div id="progress-bar" className="fixed top-0 left-0 h-[2px] bg-accent z-[999] pointer-events-none w-0" />

      <section className="border-b border-rule px-6 py-20 md:py-24">
        <div className="max-w-[1140px] mx-auto">
          {/* Eyebrow */}
          <div className="hero-h1 flex items-center gap-3 mb-6">
            <div className="h-px w-8 bg-accent-dim" />
            <span className="text-accent text-[11px] font-mono uppercase tracking-[2.5px]">
              Windows Batch Scripts
            </span>
          </div>

          {/* Headline */}
          <h1 className="hero-h1 font-serif font-bold text-head leading-[1.05] tracking-[-2px] mb-5 text-[50px] md:text-[62px]">
            Every fix.<br />
            <span className="text-accent">One library.</span>
          </h1>

          {/* Subtitle */}
          <p className="hero-p text-dim text-[17px] max-w-[460px] leading-relaxed mb-8">
            {toolCount} batch scripts to clean, optimize, and customize Windows.
            Source code on every card — copy, download, and run.
          </p>

          {/* CTA row */}
          <div className="hero-cta flex items-center gap-5 flex-wrap">
            <a
              href="#tools"
              className="inline-flex items-center gap-2 px-5 py-2.5 bg-white text-black rounded-lg font-bold text-[14px] hover:opacity-85 transition-opacity duration-150"
            >
              Browse Tools
              <ArrowDown size={14} />
            </a>
            <span className="text-dim text-[13px]">
              No install. Right-click → Run as administrator.
            </span>
          </div>

          {/* Stats */}
          <div className="hero-cta mt-10 flex items-center gap-5 text-[13px]">
            <div className="flex items-center gap-1.5">
              <span className="text-head font-bold tabular-nums">{toolCount}</span>
              <span className="text-dim">scripts</span>
            </div>
            <div className="h-3 w-px bg-rule" />
            <div className="flex items-center gap-1.5">
              <span className="text-head font-bold tabular-nums">{catCount}</span>
              <span className="text-dim">categories</span>
            </div>
            <div className="h-3 w-px bg-rule" />
            <span className="text-dim">Free forever</span>
          </div>
        </div>
      </section>
    </>
  )
}
