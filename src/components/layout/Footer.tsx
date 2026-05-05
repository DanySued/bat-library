import { Link } from 'react-router-dom'
import { Terminal } from 'lucide-react'

export function Footer() {
  return (
    <footer className="border-t border-[rgba(255,255,255,0.06)] mt-auto">
      <div className="max-w-[1344px] mx-auto px-4 sm:px-6 py-10 md:py-16">
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-8 md:gap-10">
          {/* Brand */}
          <div className="sm:col-span-2">
            <Link to="/" className="flex items-center gap-2.5 mb-4">
              <div className="w-7 h-7 bg-accent rounded-md flex items-center justify-center flex-shrink-0">
                <Terminal size={14} className="text-bg" strokeWidth={2.5} />
              </div>
              <span className="font-semibold text-[15px] text-head">Bat Library</span>
            </Link>
            <p className="text-dim text-[13px] leading-relaxed max-w-[220px]">
              Free Windows batch scripts to clean, optimize, back up, and customize your PC.
            </p>
          </div>

          {/* Library */}
          <div>
            <h4 className="text-head text-[12px] font-semibold tracking-widest uppercase mb-4">Library</h4>
            <ul className="space-y-2.5 text-[13px] text-dim">
              <li><Link to="/bat" className="hover:text-head transition-colors">All Scripts</Link></li>
              <li><Link to="/bat?cat=strong-pc" className="hover:text-head transition-colors">Strong PC</Link></li>
              <li><Link to="/bat?cat=backup" className="hover:text-head transition-colors">Backup</Link></li>
              <li><Link to="/bat?cat=aesthetic" className="hover:text-head transition-colors">Aesthetic</Link></li>
            </ul>
          </div>

          {/* Project */}
          <div>
            <h4 className="text-head text-[12px] font-semibold tracking-widest uppercase mb-4">Project</h4>
            <ul className="space-y-2.5 text-[13px] text-dim">
              <li>
                <a href="https://github.com/DanySued/bat-library" target="_blank" rel="noopener noreferrer" className="hover:text-head transition-colors">
                  GitHub
                </a>
              </li>
              <li><span className="opacity-40 cursor-default">Changelog</span></li>
              <li><span className="opacity-40 cursor-default">Roadmap</span></li>
            </ul>
          </div>

          {/* Legal */}
          <div>
            <h4 className="text-head text-[12px] font-semibold tracking-widest uppercase mb-4">Legal</h4>
            <ul className="space-y-2.5 text-[13px] text-dim">
              <li><span className="opacity-40 cursor-default">Privacy</span></li>
              <li><span className="opacity-40 cursor-default">Terms</span></li>
            </ul>
          </div>
        </div>

        <div className="mt-12 pt-8 border-t border-[rgba(255,255,255,0.05)] flex flex-col sm:flex-row items-center justify-between gap-3">
          <p className="text-dim text-[12px]">
            © {new Date().getFullYear()} Bat Library. Free and open source.
          </p>
          <p className="text-dim text-[12px]">
            No data collected. No tracking. No ads.
          </p>
        </div>
      </div>
    </footer>
  )
}
