const KEY = 'bat-downloads'

function getAll(): Record<string, number> {
  try {
    return JSON.parse(localStorage.getItem(KEY) ?? '{}')
  } catch {
    return {}
  }
}

export function getDownloadCount(id: string, baseline: number): number {
  return baseline + (getAll()[id] ?? 0)
}

export function recordDownload(id: string): void {
  const all = getAll()
  all[id] = (all[id] ?? 0) + 1
  localStorage.setItem(KEY, JSON.stringify(all))
}
