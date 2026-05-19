import { createContext, useContext, useEffect, useRef, useState } from 'react'
import { supabase } from '@/lib/supabase'
import { TOOLS } from '@/data/tools'
import type { Tool, Category, Preview } from '@/data/tools'

interface DBRow {
  id: string
  name: string
  cat: string
  desc: string
  require_admin: boolean
  icon: string
  explanation: string
  what_it_does: string[]
  how_to_use: string[] | null
  cautions: string[]
  risk_score: number
  downloads_seed: number
  preview: Preview | null
  bat_content: string | null
  sort_order: number
}

function dbToTool(row: DBRow): Tool {
  return {
    id: row.id,
    name: row.name,
    cat: row.cat as Category,
    desc: row.desc,
    admin: row.require_admin,
    icon: row.icon,
    explanation: row.explanation,
    whatItDoes: row.what_it_does,
    howToUse: row.how_to_use ?? undefined,
    cautions: row.cautions,
    riskScore: row.risk_score as 1 | 2 | 3 | 4 | 5,
    downloads: row.downloads_seed,
    preview: row.preview ?? undefined,
    bat_content: row.bat_content ?? undefined,
  }
}

function toolToDb(tool: Tool, sortOrder: number): Omit<DBRow, 'sort_order'> & { sort_order: number } {
  return {
    id: tool.id,
    name: tool.name,
    cat: tool.cat,
    desc: tool.desc,
    require_admin: tool.admin,
    icon: tool.icon,
    explanation: tool.explanation,
    what_it_does: tool.whatItDoes,
    how_to_use: tool.howToUse ?? null,
    cautions: tool.cautions,
    risk_score: tool.riskScore,
    downloads_seed: tool.downloads,
    preview: tool.preview ?? null,
    bat_content: tool.bat_content ?? null,
    sort_order: sortOrder,
  }
}

interface ToolsContextValue {
  tools: Tool[]
  loading: boolean
  refresh: () => Promise<void>
  createTool: (tool: Tool) => Promise<string | null>
  updateTool: (tool: Tool) => Promise<string | null>
  deleteTool: (id: string) => Promise<string | null>
}

const ToolsContext = createContext<ToolsContextValue | null>(null)

export function ToolsProvider({ children }: { children: React.ReactNode }) {
  const [tools, setTools] = useState<Tool[]>(TOOLS)
  const [loading, setLoading] = useState(true)
  const fromDb = useRef(false)

  async function fetchTools() {
    const { data, error } = await supabase
      .from('tools')
      .select('*')
      .order('sort_order', { ascending: true })
      .order('created_at', { ascending: true })

    if (!error && data && data.length > 0) {
      setTools((data as DBRow[]).map(dbToTool))
      fromDb.current = true
    } else if (!fromDb.current) {
      setTools(TOOLS)
    }
    setLoading(false)
  }

  useEffect(() => { fetchTools() }, [])

  async function createTool(tool: Tool): Promise<string | null> {
    const { error } = await supabase.from('tools').insert(toolToDb(tool, tools.length))
    if (error) return error.message
    await fetchTools()
    return null
  }

  async function updateTool(tool: Tool): Promise<string | null> {
    const idx = tools.findIndex(t => t.id === tool.id)
    const sortOrder = idx >= 0 ? idx : tools.length
    const { error } = await supabase.from('tools').update(toolToDb(tool, sortOrder)).eq('id', tool.id)
    if (error) return error.message
    await fetchTools()
    return null
  }

  async function deleteTool(id: string): Promise<string | null> {
    const { error } = await supabase.from('tools').delete().eq('id', id)
    if (error) return error.message
    await fetchTools()
    return null
  }

  return (
    <ToolsContext.Provider value={{ tools, loading, refresh: fetchTools, createTool, updateTool, deleteTool }}>
      {children}
    </ToolsContext.Provider>
  )
}

export function useTools() {
  const ctx = useContext(ToolsContext)
  if (!ctx) throw new Error('useTools must be used inside ToolsProvider')
  return ctx
}
