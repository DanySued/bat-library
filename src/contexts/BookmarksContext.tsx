import { createContext, useContext, useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'
import { useAuth } from './AuthContext'

const LS_KEY = 'bat-bookmarks'

function lsGet(): string[] {
  try { return JSON.parse(localStorage.getItem(LS_KEY) ?? '[]') } catch { return [] }
}
function lsSet(ids: string[]) {
  localStorage.setItem(LS_KEY, JSON.stringify(ids))
}

interface BookmarksContextValue {
  bookmarks: string[]
  isBookmarked: (id: string) => boolean
  toggle: (id: string) => Promise<void>
}

const BookmarksContext = createContext<BookmarksContextValue | null>(null)

export function BookmarksProvider({ children }: { children: React.ReactNode }) {
  const { user } = useAuth()
  const [bookmarks, setBookmarks] = useState<string[]>(lsGet)

  // When user logs in, load their Supabase saves and merge localStorage ones
  useEffect(() => {
    if (!user) {
      setBookmarks(lsGet())
      return
    }

    async function syncOnLogin() {
      const { data } = await supabase
        .from('saved_tools')
        .select('tool_id')
        .eq('user_id', user!.id)

      const remote = (data ?? []).map((r: { tool_id: string }) => r.tool_id)
      const local = lsGet()

      // Merge local-only saves into Supabase
      const toInsert = local.filter(id => !remote.includes(id))
      if (toInsert.length > 0) {
        await supabase.from('saved_tools').insert(
          toInsert.map(tool_id => ({ user_id: user!.id, tool_id }))
        )
      }

      const merged = Array.from(new Set([...remote, ...local]))
      setBookmarks(merged)
      lsSet(merged)
    }

    syncOnLogin()
  }, [user])

  async function toggle(id: string) {
    const isIn = bookmarks.includes(id)
    const next = isIn ? bookmarks.filter(b => b !== id) : [...bookmarks, id]
    setBookmarks(next)
    lsSet(next)

    if (user) {
      if (isIn) {
        await supabase.from('saved_tools').delete()
          .eq('user_id', user.id).eq('tool_id', id)
      } else {
        await supabase.from('saved_tools').insert({ user_id: user.id, tool_id: id })
      }
    }
  }

  return (
    <BookmarksContext.Provider value={{
      bookmarks,
      isBookmarked: (id) => bookmarks.includes(id),
      toggle,
    }}>
      {children}
    </BookmarksContext.Provider>
  )
}

export function useBookmarks() {
  const ctx = useContext(BookmarksContext)
  if (!ctx) throw new Error('useBookmarks must be used inside BookmarksProvider')
  return ctx
}
