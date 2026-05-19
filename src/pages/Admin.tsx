import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Plus, Pencil, Trash2, X, Shield, AlertTriangle } from 'lucide-react'
import { Nav } from '@/components/layout/Nav'
import { useAuth, ADMIN_EMAIL } from '@/contexts/AuthContext'
import { useTools } from '@/contexts/ToolsContext'
import { CATEGORIES } from '@/data/tools'
import { cn } from '@/lib/utils'
import type { Category, Tool } from '@/data/tools'

const cats = CATEGORIES.filter(c => c.id !== 'all' && c.id !== 'saved') as { id: Category; label: string; icon: string }[]

type ListKey = 'whatItDoes' | 'cautions' | 'howToUse'

type FormData = {
  id: string
  name: string
  cat: Category
  icon: string
  desc: string
  riskScore: 1 | 2 | 3 | 4 | 5
  requireAdmin: boolean
  explanation: string
  bat_content: string
  whatItDoes: string[]
  cautions: string[]
  howToUse: string[]
  preview: string
}

function emptyForm(): FormData {
  return {
    id: '', name: '', cat: 'strong-pc', icon: 'Terminal', desc: '',
    riskScore: 1, requireAdmin: false, explanation: '', bat_content: '',
    whatItDoes: [''], cautions: [''], howToUse: [], preview: '',
  }
}

function toolToForm(t: Tool): FormData {
  return {
    id: t.id, name: t.name, cat: t.cat, icon: t.icon, desc: t.desc,
    riskScore: t.riskScore, requireAdmin: t.admin, explanation: t.explanation,
    bat_content: t.bat_content ?? '',
    whatItDoes: t.whatItDoes.length ? t.whatItDoes : [''],
    cautions: t.cautions.length ? t.cautions : [''],
    howToUse: t.howToUse ?? [],
    preview: t.preview ? JSON.stringify(t.preview, null, 2) : '',
  }
}

function formToTool(f: FormData): Tool {
  let preview: Tool['preview'] | undefined
  try { preview = f.preview.trim() ? JSON.parse(f.preview) : undefined } catch { preview = undefined }
  const clean = (arr: string[]) => arr.map(s => s.trim()).filter(Boolean)
  const howToUse = clean(f.howToUse)
  return {
    id: f.id.trim(),
    name: f.name.trim(),
    cat: f.cat,
    icon: f.icon.trim() || 'Terminal',
    desc: f.desc.trim(),
    admin: f.requireAdmin,
    riskScore: f.riskScore,
    explanation: f.explanation.trim(),
    bat_content: f.bat_content.trim() || undefined,
    whatItDoes: clean(f.whatItDoes),
    cautions: clean(f.cautions),
    howToUse: howToUse.length ? howToUse : undefined,
    preview,
    downloads: 0,
  }
}

function inputCls(disabled = false): string {
  return cn(
    'w-full h-9 px-3 rounded-lg border border-[rgba(255,255,255,0.08)] bg-bg3 text-[13px] text-body placeholder:text-dim/40',
    'outline-none focus:border-accent/40 focus:bg-accent/5 transition-colors duration-150',
    disabled && 'opacity-50 cursor-not-allowed'
  )
}

function Field({ label, hint, children }: { label: string; hint?: string; children: React.ReactNode }) {
  return (
    <div className="space-y-1.5">
      <div className="flex items-baseline gap-2">
        <label className="text-[12px] font-medium text-dim uppercase tracking-[0.06em]">{label}</label>
        {hint && <span className="text-[11px] text-dim/50">{hint}</span>}
      </div>
      {children}
    </div>
  )
}

function ArrayField({ label, items, placeholder, onAdd, onChange, onRemove }: {
  label: string
  items: string[]
  placeholder: string
  onAdd: () => void
  onChange: (i: number, v: string) => void
  onRemove: (i: number) => void
}) {
  return (
    <div className="space-y-1.5">
      <label className="text-[12px] font-medium text-dim uppercase tracking-[0.06em]">{label}</label>
      <div className="space-y-2">
        {items.map((item, i) => (
          <div key={i} className="flex gap-2">
            <input
              value={item}
              onChange={e => onChange(i, e.target.value)}
              placeholder={placeholder}
              className={cn(inputCls(), 'flex-1')}
            />
            <button
              onClick={() => onRemove(i)}
              disabled={items.length <= 1}
              className="flex-shrink-0 w-9 h-9 flex items-center justify-center text-dim hover:text-danger hover:bg-danger/5 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
            >
              <X size={13} />
            </button>
          </div>
        ))}
        <button
          onClick={onAdd}
          className="text-[12px] text-accent hover:opacity-80 transition-opacity flex items-center gap-1.5"
        >
          <Plus size={12} /> Add item
        </button>
      </div>
    </div>
  )
}

export function Admin() {
  const { user } = useAuth()
  const navigate = useNavigate()
  const { tools, createTool, updateTool, deleteTool } = useTools()

  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<string | null>(null)
  const [form, setForm] = useState<FormData>(emptyForm())
  const [error, setError] = useState('')
  const [saving, setSaving] = useState(false)
  const [deleteId, setDeleteId] = useState<string | null>(null)

  if (!user || user.email !== ADMIN_EMAIL) {
    return (
      <div className="min-h-screen flex flex-col">
        <Nav />
        <div className="flex-1 flex items-center justify-center">
          <div className="text-center">
            <AlertTriangle className="text-danger mx-auto mb-4" size={32} />
            <p className="text-head text-[18px] mb-2">Access Denied</p>
            <p className="text-dim text-[14px] mb-6">Admin access required.</p>
            <button onClick={() => navigate('/')} className="text-accent text-[14px] hover:opacity-80">
              ← Back to home
            </button>
          </div>
        </div>
      </div>
    )
  }

  function openAdd() {
    setEditing(null)
    setForm(emptyForm())
    setError('')
    setFormOpen(true)
  }

  function openEdit(tool: Tool) {
    setEditing(tool.id)
    setForm(toolToForm(tool))
    setError('')
    setFormOpen(true)
  }

  async function handleSave() {
    const tool = formToTool(form)
    if (!tool.id) { setError('ID is required'); return }
    if (!tool.name) { setError('Name is required'); return }
    if (!tool.desc) { setError('Description is required'); return }
    if (!tool.explanation) { setError('Explanation is required'); return }
    if (tool.whatItDoes.length === 0) { setError('At least one "What it does" item is required'); return }
    if (tool.cautions.length === 0) { setError('At least one caution is required'); return }

    setSaving(true)
    setError('')
    const err = editing ? await updateTool(tool) : await createTool(tool)
    setSaving(false)
    if (err) { setError(err); return }
    setFormOpen(false)
  }

  async function handleDelete(id: string) {
    const err = await deleteTool(id)
    if (err) alert(err)
    setDeleteId(null)
  }

  function setField<K extends keyof FormData>(key: K, value: FormData[K]) {
    setForm(f => ({ ...f, [key]: value }))
  }

  function setListItem(key: ListKey, i: number, value: string) {
    setForm(f => {
      const arr = [...f[key]]
      arr[i] = value
      return { ...f, [key]: arr }
    })
  }

  function addListItem(key: ListKey) {
    setForm(f => ({ ...f, [key]: [...f[key], ''] }))
  }

  function removeListItem(key: ListKey, i: number) {
    setForm(f => ({ ...f, [key]: f[key].filter((_, idx) => idx !== i) }))
  }

  return (
    <div className="min-h-screen flex flex-col bg-bg">
      <Nav />

      <main className="max-w-[1140px] mx-auto w-full px-4 sm:px-6 pt-24 pb-16 flex-1">
        {/* Header */}
        <div className="flex items-center justify-between mb-8">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <Shield size={16} className="text-accent" />
              <h1 className="text-head font-semibold text-[22px]" style={{ letterSpacing: '-0.02em' }}>
                Admin Panel
              </h1>
            </div>
            <p className="text-dim text-[13px]">{tools.length} scripts</p>
          </div>
          <button
            onClick={openAdd}
            className="inline-flex items-center gap-2 px-4 py-2 bg-accent text-bg rounded-lg text-[13px] font-semibold hover:bg-accent/90 transition-colors"
          >
            <Plus size={14} />
            Add Script
          </button>
        </div>

        {/* Table */}
        <div className="rounded-xl border border-[rgba(255,255,255,0.07)] overflow-hidden">
          <table className="w-full text-[13px]">
            <thead>
              <tr className="border-b border-[rgba(255,255,255,0.06)] bg-bg2">
                <th className="px-4 py-3 text-left text-dim font-medium">ID</th>
                <th className="px-4 py-3 text-left text-dim font-medium">Name</th>
                <th className="px-4 py-3 text-left text-dim font-medium hidden sm:table-cell">Category</th>
                <th className="px-4 py-3 text-left text-dim font-medium hidden md:table-cell">Risk</th>
                <th className="px-4 py-3 text-right text-dim font-medium">Actions</th>
              </tr>
            </thead>
            <tbody>
              {tools.map((tool, i) => (
                <tr
                  key={tool.id}
                  className={cn(
                    'border-b border-[rgba(255,255,255,0.04)] hover:bg-white/[0.02] transition-colors',
                    i === tools.length - 1 && 'border-b-0'
                  )}
                >
                  <td className="px-4 py-3 text-dim font-mono text-[12px]">{tool.id}</td>
                  <td className="px-4 py-3 text-head">{tool.name}</td>
                  <td className="px-4 py-3 text-dim hidden sm:table-cell capitalize">{tool.cat}</td>
                  <td className="px-4 py-3 hidden md:table-cell">
                    <span className={cn(
                      'inline-flex items-center px-2 py-0.5 rounded text-[11px] font-medium',
                      tool.riskScore === 1 ? 'bg-green-500/10 text-green-400' :
                      tool.riskScore === 2 ? 'bg-lime-500/10 text-lime-400' :
                      tool.riskScore === 3 ? 'bg-yellow-500/10 text-yellow-400' :
                      tool.riskScore === 4 ? 'bg-orange-500/10 text-orange-400' :
                                             'bg-red-500/10 text-red-400'
                    )}>
                      {tool.riskScore}
                    </span>
                  </td>
                  <td className="px-4 py-3 text-right">
                    <div className="inline-flex items-center gap-2">
                      <button
                        onClick={() => openEdit(tool)}
                        className="p-1.5 text-dim hover:text-head hover:bg-white/5 rounded-lg transition-colors"
                        aria-label="Edit"
                      >
                        <Pencil size={13} />
                      </button>
                      {deleteId === tool.id ? (
                        <div className="inline-flex items-center gap-1.5 bg-danger/10 border border-danger/30 rounded-lg px-2 py-1">
                          <span className="text-danger text-[11px]">Sure?</span>
                          <button
                            onClick={() => handleDelete(tool.id)}
                            className="text-danger text-[11px] font-semibold hover:opacity-80"
                          >
                            Yes
                          </button>
                          <button
                            onClick={() => setDeleteId(null)}
                            className="text-dim text-[11px] hover:text-head ml-1"
                          >
                            No
                          </button>
                        </div>
                      ) : (
                        <button
                          onClick={() => setDeleteId(tool.id)}
                          className="p-1.5 text-dim hover:text-danger hover:bg-danger/5 rounded-lg transition-colors"
                          aria-label="Delete"
                        >
                          <Trash2 size={13} />
                        </button>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </main>

      {/* Form Modal */}
      {formOpen && (
        <div
          className="fixed inset-0 z-50 flex items-start justify-center p-4 sm:p-8 bg-black/60 backdrop-blur-sm overflow-y-auto"
          onClick={e => { if (e.target === e.currentTarget) setFormOpen(false) }}
        >
          <div className="relative w-full max-w-2xl bg-bg2 border border-[rgba(255,255,255,0.08)] rounded-2xl shadow-2xl my-8">
            {/* Header */}
            <div className="flex items-center justify-between px-6 pt-6 pb-4 border-b border-[rgba(255,255,255,0.06)]">
              <h2 className="text-head font-semibold text-[17px]">
                {editing ? 'Edit Script' : 'Add Script'}
              </h2>
              <button
                onClick={() => setFormOpen(false)}
                className="text-dim hover:text-head p-1.5 rounded-lg hover:bg-white/5 transition-colors"
              >
                <X size={16} />
              </button>
            </div>

            {/* Body */}
            <div className="px-6 py-5 space-y-5">
              {/* ID + Name */}
              <div className="grid grid-cols-2 gap-4">
                <Field label="ID *" hint="PascalCase, no spaces">
                  <input
                    value={form.id}
                    onChange={e => setField('id', e.target.value)}
                    disabled={!!editing}
                    placeholder="CleanDesktop"
                    className={inputCls(!!editing)}
                  />
                </Field>
                <Field label="Name *">
                  <input
                    value={form.name}
                    onChange={e => setField('name', e.target.value)}
                    placeholder="Clean Desktop"
                    className={inputCls()}
                  />
                </Field>
              </div>

              {/* Cat + Icon + Risk + Admin */}
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
                <Field label="Category *">
                  <select
                    value={form.cat}
                    onChange={e => setField('cat', e.target.value as Category)}
                    className={inputCls()}
                  >
                    {cats.map(c => <option key={c.id} value={c.id}>{c.label}</option>)}
                  </select>
                </Field>
                <Field label="Icon" hint="Lucide name">
                  <input
                    value={form.icon}
                    onChange={e => setField('icon', e.target.value)}
                    placeholder="Terminal"
                    className={inputCls()}
                  />
                </Field>
                <Field label="Risk (1–5)">
                  <select
                    value={form.riskScore}
                    onChange={e => setField('riskScore', Number(e.target.value) as 1 | 2 | 3 | 4 | 5)}
                    className={inputCls()}
                  >
                    <option value={1}>1 — Safe</option>
                    <option value={2}>2 — Low</option>
                    <option value={3}>3 — Moderate</option>
                    <option value={4}>4 — High</option>
                    <option value={5}>5 — Destructive</option>
                  </select>
                </Field>
                <Field label="Needs Admin">
                  <label className="flex items-center gap-2 h-9 cursor-pointer select-none">
                    <input
                      type="checkbox"
                      checked={form.requireAdmin}
                      onChange={e => setField('requireAdmin', e.target.checked)}
                      className="w-4 h-4 accent-accent"
                    />
                    <span className="text-[13px] text-dim">Required</span>
                  </label>
                </Field>
              </div>

              {/* Desc */}
              <Field label="Short Description *">
                <input
                  value={form.desc}
                  onChange={e => setField('desc', e.target.value)}
                  placeholder="One-line description shown on cards"
                  className={inputCls()}
                />
              </Field>

              {/* Explanation */}
              <Field label="Explanation *">
                <textarea
                  value={form.explanation}
                  onChange={e => setField('explanation', e.target.value)}
                  placeholder="Full explanation shown on the detail page"
                  rows={3}
                  className={cn(inputCls(), 'h-auto resize-y min-h-[72px]')}
                />
              </Field>

              {/* What it does */}
              <ArrayField
                label="What It Does *"
                items={form.whatItDoes}
                placeholder="Verifies Node.js is installed"
                onAdd={() => addListItem('whatItDoes')}
                onChange={(i, v) => setListItem('whatItDoes', i, v)}
                onRemove={i => removeListItem('whatItDoes', i)}
              />

              {/* Cautions */}
              <ArrayField
                label="Cautions *"
                items={form.cautions}
                placeholder="⚠️ Requires Node.js 18+"
                onAdd={() => addListItem('cautions')}
                onChange={(i, v) => setListItem('cautions', i, v)}
                onRemove={i => removeListItem('cautions', i)}
              />

              {/* How to use */}
              <ArrayField
                label="How To Use (optional)"
                items={form.howToUse}
                placeholder="Double-click the .bat file"
                onAdd={() => addListItem('howToUse')}
                onChange={(i, v) => setListItem('howToUse', i, v)}
                onRemove={i => removeListItem('howToUse', i)}
              />

              {/* BAT content */}
              <Field label="BAT Content">
                <textarea
                  value={form.bat_content}
                  onChange={e => setField('bat_content', e.target.value)}
                  placeholder={'@echo off\necho Hello World\npause'}
                  rows={8}
                  className={cn(inputCls(), 'h-auto resize-y font-mono text-[12px] min-h-[160px]')}
                />
              </Field>

              {/* Preview JSON */}
              <Field label="Preview JSON (optional)" hint="folder-tree or cmd type">
                <textarea
                  value={form.preview}
                  onChange={e => setField('preview', e.target.value)}
                  placeholder='{"type":"cmd","description":"...","execution":"...","result":"..."}'
                  rows={4}
                  className={cn(inputCls(), 'h-auto resize-y font-mono text-[12px]')}
                />
              </Field>

              {/* Error */}
              {error && (
                <p className="text-danger text-[13px] bg-danger/5 border border-danger/20 rounded-lg px-4 py-3">
                  {error}
                </p>
              )}
            </div>

            {/* Footer */}
            <div className="flex items-center justify-end gap-3 px-6 pb-6 pt-4 border-t border-[rgba(255,255,255,0.06)]">
              <button
                onClick={() => setFormOpen(false)}
                className="px-4 py-2 text-[13px] text-dim hover:text-head hover:bg-white/5 rounded-lg transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleSave}
                disabled={saving}
                className="px-5 py-2 bg-accent text-bg text-[13px] font-semibold rounded-lg hover:bg-accent/90 transition-colors disabled:opacity-50"
              >
                {saving ? 'Saving...' : editing ? 'Save Changes' : 'Add Script'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
