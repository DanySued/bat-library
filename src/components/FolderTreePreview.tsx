import { getIcon } from '@/lib/icons'
import type { TreeNode } from '@/data/tools'

type Props = {
  root: string
  tree: TreeNode[]
}

type Row = {
  prefix: string
  name: string
  hasChildren: boolean
}

function flatten(nodes: TreeNode[], ancestorContinues: boolean[], rows: Row[]) {
  nodes.forEach((node, i) => {
    const isLast = i === nodes.length - 1
    let prefix = ''
    for (const continues of ancestorContinues) {
      prefix += continues ? '│   ' : '    '
    }
    prefix += isLast ? '└── ' : '├── '
    rows.push({ prefix, name: node.name, hasChildren: !!node.children?.length })
    if (node.children?.length) {
      flatten(node.children, [...ancestorContinues, !isLast], rows)
    }
  })
}

export function FolderTreePreview({ root, tree }: Props) {
  const rows: Row[] = []
  flatten(tree, [], rows)

  const Folder = getIcon('Folder')
  const FolderOpen = getIcon('FolderOpen')

  return (
    <div className="font-mono text-[13px] leading-7 select-none">
      {/* Root */}
      <div className="flex items-center gap-2">
        {FolderOpen && <FolderOpen size={14} className="text-accent flex-shrink-0" />}
        <span className="text-head">{root}</span>
      </div>

      {/* Children */}
      {rows.map((row, i) => {
        const Icon = row.hasChildren ? FolderOpen : Folder
        return (
          <div key={i} className="flex items-center gap-2">
            <span
              className="whitespace-pre"
              style={{ color: 'rgba(255,255,255,0.18)' }}
              aria-hidden
            >
              {row.prefix}
            </span>
            {Icon && <Icon size={14} className="text-accent/70 flex-shrink-0" />}
            <span className="text-body">{row.name}</span>
          </div>
        )
      })}
    </div>
  )
}
