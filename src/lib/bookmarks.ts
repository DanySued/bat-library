const KEY = 'bat-bookmarks'

export function getBookmarks(): string[] {
  try {
    return JSON.parse(localStorage.getItem(KEY) ?? '[]')
  } catch {
    return []
  }
}

export function toggleBookmark(id: string): string[] {
  const current = getBookmarks()
  const next = current.includes(id)
    ? current.filter(b => b !== id)
    : [...current, id]
  localStorage.setItem(KEY, JSON.stringify(next))
  return next
}
