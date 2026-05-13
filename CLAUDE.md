# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
npm run dev       # Start dev server (http://localhost:5173)
npm run build     # Type-check + build to /dist
npm run preview   # Preview the production build locally
```

**Deploy:** `git push origin HEAD` — Vercel auto-deploys on every push to the connected branch. On Windows, `deploy.bat` wraps this with a commit message prompt.

## Architecture

**Stack:** React 18 + TypeScript + Vite + Tailwind CSS + Supabase, deployed on Vercel as a static SPA.

### Data flow

All script metadata lives in **`src/data/tools.ts`** as a single `TOOLS: Tool[]` array. There is no CMS or database for script content — adding a new script means:
1. Adding a `Tool` object to the `TOOLS` array in `tools.ts`
2. Dropping the `.bat` file into `/files/`

The `files/` directory is copied into `dist/` at build time by `vite-plugin-static-copy`. In dev, a custom Vite middleware serves `/files/` from the project root. `ToolDetail` fetches the raw `.bat` source at `/files/{id}.bat` to display the code preview.

### Contexts (wrapping the whole app)

| Context | What it manages |
|---|---|
| `AuthContext` | Supabase session, OAuth helpers, auth modal open/close state |
| `BookmarksContext` | Saved scripts — localStorage when anonymous, Supabase `saved_tools` when logged in. Merges local into remote on login. |
| `DownloadsContext` | Fetches global counts from Supabase `downloads` table on mount, calls `increment_download` RPC on download, with optimistic updates. |

### Routes

| Path | Component |
|---|---|
| `/` | `Landing` |
| `/bat` | `Library` — filterable/sortable grid, reads `?cat=` and `?q=` from URL |
| `/bat/:id` | `ToolDetail` — fetches `.bat` source, shows cautions, download button |
| `/saved` | `Saved` |
| `/claude` | `Claude` |
| `/tool/:id` | Redirects to `/bat/:id` (legacy) |

### Styling

Tailwind with custom tokens defined in `tailwind.config.ts`. Key tokens: `bg`, `bg2`, `bg3`, `bg4` (dark backgrounds), `accent` / `accent-dim` (blue `#57B5E7`), `body`, `dim`, `head`, `code-bg`, `code-fg`, `danger`. Font stack: Inter (sans) + JetBrains Mono (mono). Use `cn()` from `src/lib/utils.ts` for conditional class merging.

> Note: `design-system.md` describes an older warm amber palette. The live design uses the **cool dark** palette in `tailwind.config.ts` — ignore the CSS variables in `design-system.md`.

### Adding a new script

Follow the `Tool` interface in `tools.ts`. Required fields: `id` (filename without extension, PascalCase — e.g. `CleanDesktop`, `BackupFolders`), `name`, `cat`, `desc`, `admin`, `icon` (Lucide icon name), `explanation`, `whatItDoes[]`, `cautions[]` (prefix with `⚠️`, `✅`, or `💡`), `riskScore` (1–5), `downloads` (baseline count). Optional: `howToUse[]`, `preview` (either `folder-tree` or `cmd` type). See `BAT_FILE_TEMPLATE.md` for the bat file structure convention.

### Supabase tables

- `downloads` — `tool_id: text, count: int` with `increment_download(p_tool_id)` RPC
- `saved_tools` — `user_id: uuid, tool_id: text`

Full schema (tables, RPC, RLS policies) is in **`supabase-schema.sql`**.

Env vars needed (see `.env.example`): `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`. Set these in Vercel project settings for production.

### Reference files

- **`SCRIPTS.md`** — full inventory of all 132 scripts with category, risk score, and admin requirement. Check here before adding a new script to avoid duplicates.
- **`supabase-schema.sql`** — canonical DB schema with tables, RPC, and RLS policies.
- **`.claude/commands/new-script.md`** — `/new-script` slash command: scaffolds a new `Tool` entry + `.bat` file end-to-end.
- **`.claude/commands/deploy.md`** — `/deploy` slash command: commits and pushes to trigger Vercel auto-deploy.
