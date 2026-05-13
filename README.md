# BAT Library

**132 Windows batch scripts to clean, optimize, back up, and customize your PC.**

[![Live Site](https://img.shields.io/badge/Live-bat--library.vercel.app-57B5E7?style=flat-square)](https://bat-library.vercel.app) [![Scripts](https://img.shields.io/badge/Scripts-132-57B5E7?style=flat-square)](./files) [![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-blue?style=flat-square)]()

---

## What it is

A library of ready-to-run `.bat` scripts for Windows. Each one does one thing — clean temp files, fix Bluetooth, back up your drivers, restore classic menus. No installs, no dependencies. Download, right-click, run as administrator.

The site shows what each script does, step-by-step instructions, and safety notes before you run anything.

---

## Categories

| Category | Scripts |
|---|---|
| **Strong PC** | Disable startup programs, clear junk, boost performance, fix common Windows problems |
| **Backup** | Back up folders, drivers, WiFi profiles, registry, game saves, browser bookmarks |
| **Organizing** | Rename files in bulk, organize downloads, find duplicates, map network drives |
| **Aesthetic** | Toggle dark mode, restore Photo Viewer, customize taskbar, set wallpaper slideshows |
| **Fun** | Matrix rain, Pong, Snake, Tetris, bouncing ball, fake hacker screen |
| **Claude** | Install Claude Code, set up YOLO mode, push to GitHub, install GitHub CLI |

Full inventory with risk scores: [`SCRIPTS.md`](./SCRIPTS.md)

---

## How to run any script

```
1. Download the .bat file
2. Right-click → Run as administrator  (most scripts require this)
3. Follow any prompts in the terminal window
```

**Never run a .bat file you haven't read first.** All scripts in this library are open source — the code is visible in the `/files` folder and on the detail pages of the site.

---

## Danger levels

- **Safe (read-only):** DriverBackup, DuplicateFileFinder, FolderSizeReport, WiFiPasswords
- **Low risk (reversible):** DarkModeToggle, FixBluetooth, FixSound, NetworkSpeedFix
- **Moderate (registry changes):** RestoreRightClickMenu, RestorePhotoViewer, FixExplorer
- **Run CreateRestorePoint.bat first:** CleanWindows_MASTER, FixSlowRightClick, RegistryBackup
- **Destructive (irreversible):** EmptyFolderCleaner, BulkRenamer, ClearUSBHistory

---

## Tech stack

- React 18 + TypeScript + Vite + Tailwind CSS
- Supabase (download counts, saved scripts)
- Vercel (static hosting, auto-deploy on push)

---

## Made by

Dany Sue — [bat-library.vercel.app](https://bat-library.vercel.app)

Built with Claude Code (Anthropic).
