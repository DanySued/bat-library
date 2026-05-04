import { Link } from 'react-router-dom'
import { ArrowRight, Github } from 'lucide-react'

export function FinalCTA() {
  return (
    <section className="relative border-t border-[rgba(255,255,255,0.06)] overflow-hidden">
      {/* Orange radial glow from bottom */}
      <div
        className="absolute inset-x-0 bottom-0 pointer-events-none"
        style={{
          height: '60%',
          background: 'radial-gradient(ellipse 60% 50% at 50% 100%, rgba(207,123,75,0.10) 0%, transparent 70%)',
        }}
      />

      <div className="relative z-10 max-w-[1344px] mx-auto px-6 py-32 text-center">
        <h2
          className="font-semibold text-head leading-[1.05] mb-6 mx-auto"
          style={{
            fontSize: 'clamp(2.5rem, 5vw, 4rem)',
            letterSpacing: '-0.022em',
            maxWidth: 700,
          }}
        >
          Start automating your Windows today.
        </h2>
        <p className="text-[17px] mb-10 max-w-[460px] mx-auto" style={{ color: '#8a8f98' }}>
          Free. No install. No accounts. Just download a script and run it.
        </p>

        <div className="flex items-center gap-3 flex-wrap justify-center">
          <Link
            to="/bat"
            className="inline-flex items-center gap-2 px-7 py-3.5 bg-orange text-bg rounded-full font-semibold text-[15px] transition-all duration-200 hover:scale-[1.02] active:scale-[0.98] hover:bg-orange/90"
          >
            Browse Bat Library
            <ArrowRight size={16} />
          </Link>
          <a
            href="https://github.com"
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-2 px-7 py-3.5 border border-[rgba(255,255,255,0.1)] text-body rounded-full text-[15px] transition-all duration-200 hover:scale-[1.02] active:scale-[0.98] hover:bg-white/5"
          >
            <Github size={15} />
            Star on GitHub
          </a>
        </div>

        <p className="mt-8 text-[12px]" style={{ color: '#8a8f98' }}>
          Open source · No registration · Works offline
        </p>
      </div>
    </section>
  )
}
