# BAT Library

**36 Windows batch scripts to clean, optimize, back up, and customize your PC.**

[![Live Site](https://img.shields.io/badge/Live-bat--library.vercel.app-cf7b4b?style=flat-square)](https://bat-library.vercel.app) [![Scripts](https://img.shields.io/badge/Scripts-36-4b9fcf?style=flat-square)](./files) [![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-blue?style=flat-square)]()

---

## What it is

A library of ready-to-run `.bat` scripts for Windows. Each one does one thing — clean temp files, fix Bluetooth, back up your drivers, restore classic menus. No installs, no dependencies. Download, right-click, run as administrator.

The site shows what each script does, step-by-step instructions, and safety notes before you run anything.

---

## Scripts

| Script | Category | Admin |
|---|---|---|
| [BackupFolders.bat](./files/BackupFolders.bat) | Backup | ✅ |
| [BlockDistractingSites.bat](./files/BlockDistractingSites.bat) | Fun | ✅ |
| [BulkRenamer.bat](./files/BulkRenamer.bat) | Organizing | ✅ |
| [CleanWindows_MASTER.bat](./files/CleanWindows_MASTER.bat) | Cleaning | ✅ |
| [ClearRecentActivity.bat](./files/ClearRecentActivity.bat) | Cleaning | ✅ |
| [ClearUSBHistory.bat](./files/ClearUSBHistory.bat) | Cleaning | ✅ |
| [CreateRestorePoint.bat](./files/CreateRestorePoint.bat) | Backup | ✅ |
| [DarkModeToggle.bat](./files/DarkModeToggle.bat) | Aesthetic | ❌ |
| [DisableForcedRestarts.bat](./files/DisableForcedRestarts.bat) | Fast Computer | ✅ |
| [DisableLockscreen.reg](./files/DisableLockscreen.reg) | Aesthetic | ✅ |
| [DriverBackup.bat](./files/DriverBackup.bat) | Backup | ✅ |
| [DuplicateFileFinder.bat](./files/DuplicateFileFinder.bat) | Organizing | ✅ |
| [EmptyFolderCleaner.bat](./files/EmptyFolderCleaner.bat) | Cleaning | ✅ |
| [FixBluetooth.bat](./files/FixBluetooth.bat) | Fast Computer | ✅ |
| [FixBrokenIcons.bat](./files/FixBrokenIcons.bat) | Fast Computer | ✅ |
| [FixExplorer.bat](./files/FixExplorer.bat) | Aesthetic | ✅ |
| [FixMicrosoftStore.bat](./files/FixMicrosoftStore.bat) | Fast Computer | ✅ |
| [FixSlowRightClick.bat](./files/FixSlowRightClick.bat) | Fast Computer | ✅ |
| [FixSound.bat](./files/FixSound.bat) | Fast Computer | ✅ |
| [FixWindowsProblems.bat](./files/FixWindowsProblems.bat) | Fast Computer | ✅ |
| [FixWindowsUpdate.bat](./files/FixWindowsUpdate.bat) | Fast Computer | ✅ |
| [FolderSizeReport.bat](./files/FolderSizeReport.bat) | Organizing | ✅ |
| [GameSavesBackup.bat](./files/GameSavesBackup.bat) | Backup | ✅ |
| [GamingModeToggle.bat](./files/GamingModeToggle.bat) | Fun | ✅ |
| [NetworkSpeedFix.bat](./files/NetworkSpeedFix.bat) | Fast Computer | ✅ |
| [NightModeScheduler.bat](./files/NightModeScheduler.bat) | Aesthetic | ✅ |
| [NumlockOnStartup.bat](./files/NumlockOnStartup.bat) | Aesthetic | ✅ |
| [OldFileArchiver.bat](./files/OldFileArchiver.bat) | Organizing | ✅ |
| [PowerButtonConfig.bat](./files/PowerButtonConfig.bat) | Aesthetic | ✅ |
| [RAMCleaner.bat](./files/RAMCleaner.bat) | Fast Computer | ✅ |
| [RegistryBackup.bat](./files/RegistryBackup.bat) | Backup | ✅ |
| [RestorePhotoViewer.bat](./files/RestorePhotoViewer.bat) | Aesthetic | ✅ |
| [RestoreRightClickMenu.bat](./files/RestoreRightClickMenu.bat) | Aesthetic | ✅ |
| [RunAsDevButton.bat](./files/RunAsDevButton.bat) | Organizing | ✅ |
| [ScheduleDailyBackup.bat](./files/ScheduleDailyBackup.bat) | Backup | ✅ |
| [SetEnglishInput.bat](./files/SetEnglishInput.bat) | Organizing | ✅ |
| [SwitchToEnglish.bat](./files/SwitchToEnglish.bat) | Organizing | ✅ |
| [WeeklyClean.bat](./files/WeeklyClean.bat) | Cleaning | ✅ |
| [WiFiPasswords.bat](./files/WiFiPasswords.bat) | Organizing | ✅ |

---

## How to run any script

```
1. Download the .bat file
2. Right-click → Run as administrator  (most scripts require this)
3. Follow any prompts in the terminal window
```

**Never run a .bat file you haven't read first.** All scripts in this library are open source — the code is visible in the `/files` folder and on the detail pages of the site.

---

## Danger level

- **Safe (read-only):** DriverBackup, DuplicateFileFinder, FolderSizeReport, WiFiPasswords
- **Low risk (reversible):** DarkModeToggle, FixBluetooth, FixSound, NetworkSpeedFix
- **Moderate (registry changes):** RestoreRightClickMenu, RestorePhotoViewer, FixExplorer, DisableForcedRestarts
- **Run CreateRestorePoint.bat first:** CleanWindows_MASTER, FixSlowRightClick, RegistryBackup
- **Destructive (irreversible):** EmptyFolderCleaner, BulkRenamer, ClearUSBHistory

---

## Tech stack

- Vanilla HTML + React 18 (CDN, no build step)
- Lucide React icons
- Vercel (static hosting, auto-deploy on push)

---

## Made by

Dany Sue — [bat-library.vercel.app](https://bat-library.vercel.app)

Built with Claude Code (Anthropic).

**Prompts used:**
- *"deploy this project to github and vercel"*
- *"i have all the files in Downloads/.bat files. i want to be able to download the files from the website, but i dont want to make it too heavy"*
- *"i want them to be with no spaces like RunAsDevButton.bat. Also create a readme file for the github containing all of the bat files to download"*
