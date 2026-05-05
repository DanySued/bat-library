import { createContext, useContext, useEffect, useRef, useState } from 'react'
import { supabase } from '@/lib/supabase'

interface DownloadsContextValue {
  getCount: (id: string, baseline: number) => number
  recordDownload: (id: string) => void
  loading: boolean
}

const DownloadsContext = createContext<DownloadsContextValue | null>(null)

export function DownloadsProvider({ children }: { children: React.ReactNode }) {
  const [counts, setCounts] = useState<Record<string, number>>({})
  const [loading, setLoading] = useState(true)
  const optimistic = useRef<Record<string, number>>({})

  useEffect(() => {
    supabase
      .from('downloads')
      .select('tool_id, count')
      .then(({ data, error }) => {
        setLoading(false)
        if (error) {
          console.error('Error fetching downloads:', error)
          return
        }
        if (!data) return
        const map: Record<string, number> = {}
        for (const row of data) map[row.tool_id] = row.count
        setCounts(map)
      })
  }, [])

  function getCount(id: string, baseline: number): number {
    // If we are still loading, we might want to show the baseline or a skeleton
    const db = counts[id] ?? baseline
    return db + (optimistic.current[id] ?? 0)
  }

  async function recordDownload(id: string) {
    // Optimistic update
    optimistic.current[id] = (optimistic.current[id] ?? 0) + 1
    setCounts(c => ({ ...c }))

    const { error } = await supabase.rpc('increment_download', { p_tool_id: id })
    if (error) {
      console.error('Error incrementing download:', error)
      // On error, we could revert the optimistic update if we wanted to be strict
    }
  }

  return (
    <DownloadsContext.Provider value={{ getCount, recordDownload, loading }}>
      {children}
    </DownloadsContext.Provider>
  )
}

export function useDownloads() {
  const ctx = useContext(DownloadsContext)
  if (!ctx) throw new Error('useDownloads must be used inside DownloadsProvider')
  return ctx
}
