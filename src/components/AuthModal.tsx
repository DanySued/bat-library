import { useState } from 'react'
import { X, Mail, Lock, Github, Loader2 } from 'lucide-react'
import { useAuth } from '@/contexts/AuthContext'
import { cn } from '@/lib/utils'

function GoogleIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
      <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
      <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
      <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05"/>
      <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
    </svg>
  )
}

type Tab = 'signin' | 'signup'

export function AuthModal() {
  const { authModalOpen, closeAuthModal, signInWithEmail, signUpWithEmail, signInWithGoogle, signInWithGitHub } = useAuth()
  const [tab, setTab] = useState<Tab>('signin')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)
  const [success, setSuccess] = useState(false)

  if (!authModalOpen) return null

  function reset() {
    setError(null)
    setSuccess(false)
    setEmail('')
    setPassword('')
  }

  function switchTab(t: Tab) {
    setTab(t)
    setError(null)
    setSuccess(false)
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError(null)
    setLoading(true)
    try {
      if (tab === 'signin') {
        const err = await signInWithEmail(email, password)
        if (err) { setError(err); return }
        closeAuthModal()
        reset()
      } else {
        const err = await signUpWithEmail(email, password)
        if (err) { setError(err); return }
        setSuccess(true)
      }
    } finally {
      setLoading(false)
    }
  }

  return (
    <div
      className="fixed inset-0 z-[100] flex items-center justify-center p-4"
      onClick={e => { if (e.target === e.currentTarget) { closeAuthModal(); reset() } }}
    >
      {/* Backdrop */}
      <div className="absolute inset-0 bg-black/60 backdrop-blur-sm" />

      {/* Modal */}
      <div className="relative w-full max-w-[380px] bg-bg2 border border-[rgba(255,255,255,0.08)] rounded-2xl shadow-[0_24px_80px_rgba(0,0,0,0.6)] p-6">
        {/* Close */}
        <button
          onClick={() => { closeAuthModal(); reset() }}
          className="absolute top-4 right-4 text-dim hover:text-head transition-colors p-1 rounded-lg hover:bg-white/5"
        >
          <X size={16} />
        </button>

        {/* Header */}
        <div className="mb-6">
          <h2 className="font-semibold text-head text-[18px] tracking-[-0.022em] mb-1">
            {tab === 'signin' ? 'Welcome back' : 'Create account'}
          </h2>
          <p className="text-[13px] text-dim">
            {tab === 'signin'
              ? 'Sign in to sync your saved scripts.'
              : 'Save scripts and sync across devices.'}
          </p>
        </div>

        {/* Tabs */}
        <div className="flex bg-bg3 rounded-lg p-0.5 mb-5">
          {(['signin', 'signup'] as Tab[]).map(t => (
            <button
              key={t}
              onClick={() => switchTab(t)}
              className={cn(
                'flex-1 py-1.5 rounded-md text-[13px] font-medium transition-all duration-150',
                tab === t ? 'bg-bg2 text-head shadow-sm' : 'text-dim hover:text-body'
              )}
            >
              {t === 'signin' ? 'Sign in' : 'Sign up'}
            </button>
          ))}
        </div>

        {success ? (
          <div className="text-center py-6">
            <div className="w-10 h-10 rounded-full bg-accent/10 flex items-center justify-center mx-auto mb-3">
              <span className="text-accent text-lg">✓</span>
            </div>
            <p className="text-head font-medium mb-1">Check your email</p>
            <p className="text-[13px] text-dim">
              We sent a confirmation link to <span className="text-body">{email}</span>
            </p>
          </div>
        ) : (
          <>
            {/* OAuth buttons */}
            <div className="flex gap-2 mb-4">
              <button
                onClick={() => signInWithGoogle()}
                className="flex-1 flex items-center justify-center gap-2 h-9 rounded-lg border border-[rgba(255,255,255,0.08)] bg-white/[0.03] hover:bg-white/[0.07] text-[13px] text-body transition-colors duration-150"
              >
                <GoogleIcon />
                Google
              </button>
              <button
                onClick={() => signInWithGitHub()}
                className="flex-1 flex items-center justify-center gap-2 h-9 rounded-lg border border-[rgba(255,255,255,0.08)] bg-white/[0.03] hover:bg-white/[0.07] text-[13px] text-body transition-colors duration-150"
              >
                <Github size={15} />
                GitHub
              </button>
            </div>

            {/* Divider */}
            <div className="flex items-center gap-3 mb-4">
              <div className="flex-1 h-px bg-[rgba(255,255,255,0.06)]" />
              <span className="text-[11px] text-dim/60 uppercase tracking-wider">or</span>
              <div className="flex-1 h-px bg-[rgba(255,255,255,0.06)]" />
            </div>

            {/* Email form */}
            <form onSubmit={handleSubmit} className="space-y-3">
              <div className="relative">
                <Mail size={14} className="absolute left-3 top-1/2 -translate-y-1/2 text-dim pointer-events-none" />
                <input
                  type="email"
                  placeholder="Email"
                  value={email}
                  onChange={e => setEmail(e.target.value)}
                  required
                  className="w-full h-9 pl-9 pr-3 rounded-lg border border-[rgba(255,255,255,0.08)] bg-bg3 text-[13px] text-body placeholder:text-dim/50 outline-none focus:border-accent/40 focus:bg-accent/5 transition-colors duration-150"
                />
              </div>
              <div className="relative">
                <Lock size={14} className="absolute left-3 top-1/2 -translate-y-1/2 text-dim pointer-events-none" />
                <input
                  type="password"
                  placeholder="Password"
                  value={password}
                  onChange={e => setPassword(e.target.value)}
                  required
                  minLength={6}
                  className="w-full h-9 pl-9 pr-3 rounded-lg border border-[rgba(255,255,255,0.08)] bg-bg3 text-[13px] text-body placeholder:text-dim/50 outline-none focus:border-accent/40 focus:bg-accent/5 transition-colors duration-150"
                />
              </div>

              {error && (
                <p className="text-[12px] text-danger/90 bg-danger/[0.06] border border-danger/20 rounded-lg px-3 py-2">
                  {error}
                </p>
              )}

              <button
                type="submit"
                disabled={loading}
                className="w-full h-9 rounded-lg bg-accent text-bg font-semibold text-[13px] hover:bg-accent/90 disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-150 flex items-center justify-center gap-2"
              >
                {loading && <Loader2 size={13} className="animate-spin" />}
                {tab === 'signin' ? 'Sign in' : 'Create account'}
              </button>
            </form>
          </>
        )}
      </div>
    </div>
  )
}
