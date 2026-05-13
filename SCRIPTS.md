# Script Inventory

All scripts in `src/data/tools.ts` and `/files/`. Risk: 1 = safe/read-only → 5 = destructive. Admin = requires "Run as administrator".

| id | Name | Category | Risk | Admin |
|---|---|---|---|---|
| `InstallClaudeCode` | Install Claude Code | claude | 1 | No |
| `CleanWindows_MASTER` | CleanWindows MASTER | strong-pc | 5 | Yes |
| `BackupFolders` | Backup Folders | backup | 1 | Yes |
| `BackupToUSB` | Backup to USB | backup | 1 | No |
| `BackupDrivers` | Backup All Drivers | backup | 1 | Yes |
| `BackupBrowserBookmarks` | Backup Browser Bookmarks | backup | 1 | No |
| `BackupHosts` | Backup Hosts File | backup | 1 | Yes |
| `BackupStartLayout` | Backup Start Menu Layout | backup | 1 | No |
| `BackupWifiProfiles` | Backup WiFi Profiles | backup | 3 | Yes |
| `BackupEnvironmentVars` | Backup Environment Variables | backup | 1 | Yes |
| `AutoBackupDocuments` | Auto Backup Documents | backup | 1 | Yes |
| `CreateRestorePoint` | Create Restore Point | backup | 1 | Yes |
| `CreateSystemImage` | Create System Image | backup | 1 | Yes |
| `DriverBackup` | Driver Backup | backup | 1 | Yes |
| `ExportInstalledApps` | Export Installed Apps List | backup | 1 | No |
| `GameSavesBackup` | Game Saves Backup | backup | 1 | Yes |
| `RegistryBackup` | Registry Backup | backup | 1 | Yes |
| `ScheduleDailyBackup` | Schedule Daily Backup | backup | 1 | Yes |
| `ClearRecentActivity` | Clear Recent Activity | strong-pc | 2 | Yes |
| `ClearUSBHistory` | Clear USB History | strong-pc | 2 | Yes |
| `ClearAllTempFiles` | Clear All Temp Files | strong-pc | 1 | Yes |
| `ClearDNSCache` | Clear DNS Cache | strong-pc | 1 | Yes |
| `ClearEventLogs` | Clear Event Logs | strong-pc | 2 | Yes |
| `ClearPageFile` | Clear Page File on Shutdown | strong-pc | 1 | Yes |
| `CleanBrowserCaches` | Clean Browser Caches | strong-pc | 1 | No |
| `CleanWindowsUpdateCache` | Clean Update Cache | strong-pc | 1 | Yes |
| `DisableAnimations` | Disable Animations | strong-pc | 1 | No |
| `DisableAutoUpdate` | Pause Windows Updates | strong-pc | 3 | Yes |
| `DisableBackgroundApps` | Disable Background Apps | strong-pc | 1 | No |
| `DisableExplorerAds` | Disable Explorer Ads | strong-pc | 1 | No |
| `DisableForcedRestarts` | Disable Forced Restarts | strong-pc | 2 | Yes |
| `DisableIndexing` | Disable Search Indexing | strong-pc | 1 | Yes |
| `DisableIPv6` | Disable IPv6 | strong-pc | 2 | Yes |
| `DisableNotifications` | Disable All Notifications | strong-pc | 2 | No |
| `DisablePrinting` | Disable Print Spooler | strong-pc | 1 | Yes |
| `DisableRemoteDesktop` | Disable Remote Desktop | strong-pc | 1 | Yes |
| `DisableSearchHighlights` | Disable Search Highlights | strong-pc | 1 | No |
| `DisableStartupPrograms` | Disable Startup Programs | strong-pc | 2 | Yes |
| `DisableSuperfetch` | Disable Superfetch / SysMain | strong-pc | 1 | Yes |
| `DisableSuggestedApps` | Disable Suggested Apps | strong-pc | 1 | No |
| `DisableTelemetryTasks` | Disable Telemetry Tasks | strong-pc | 2 | Yes |
| `DisableWindowsDefenderRealtime` | Pause Defender Real-Time | strong-pc | 4 | Yes |
| `DisableWindowsTips` | Disable Windows Tips | strong-pc | 1 | No |
| `EmptyFolderCleaner` | Empty Folder Cleaner | strong-pc | 3 | Yes |
| `EmptyRecycleBinSilent` | Empty Recycle Bin (Silent) | strong-pc | 2 | No |
| `EnableUltimatePerformance` | Ultimate Performance Mode | strong-pc | 2 | Yes |
| `FixBluetooth` | Fix Bluetooth | strong-pc | 1 | Yes |
| `FixBrokenIcons` | Fix Broken Icons | strong-pc | 1 | Yes |
| `FixMicrosoftStore` | Fix Microsoft Store | strong-pc | 1 | Yes |
| `FixSlowRightClick` | Fix Slow Right-Click | strong-pc | 2 | Yes |
| `FixSound` | Fix Sound | strong-pc | 1 | Yes |
| `FixWindowsProblems` | Fix Windows Problems | strong-pc | 2 | Yes |
| `FixWindowsUpdate` | Fix Windows Update | strong-pc | 2 | Yes |
| `HideOneDriveSidebar` | Hide OneDrive Sidebar | strong-pc | 1 | No |
| `NetworkSpeedFix` | Network Speed Fix | strong-pc | 2 | Yes |
| `BoostNetworkSpeed` | Boost Network Speed | strong-pc | 2 | Yes |
| `OptimizeRAMUsage` | Optimize RAM Usage | strong-pc | 2 | Yes |
| `RAMCleaner` | RAM Cleaner | strong-pc | 1 | Yes |
| `RemoveBloatware` | Remove Bloatware | strong-pc | 2 | Yes |
| `RemoveCortana` | Remove Cortana | strong-pc | 2 | Yes |
| `RemoveDesktopIcons` | Remove Desktop Icons | strong-pc | 1 | No |
| `RemoveEdgeCompletely` | Remove Edge (Disable) | strong-pc | 3 | Yes |
| `RemoveFeedbackHub` | Remove Feedback Hub | strong-pc | 1 | Yes |
| `RemoveHibernationFile` | Remove Hibernation File | strong-pc | 2 | Yes |
| `RemoveMixedReality` | Remove Mixed Reality | strong-pc | 2 | Yes |
| `RemoveNewsTaskbar` | Remove News from Taskbar | strong-pc | 1 | No |
| `RemoveOneDrive` | Remove OneDrive | strong-pc | 3 | Yes |
| `RemovePrintSpoolerJunk` | Clean Print Spooler | strong-pc | 1 | Yes |
| `RemoveTeamsAutoStart` | Remove Teams Auto-Start | strong-pc | 1 | No |
| `RemoveWindowsOld` | Remove Windows.old | strong-pc | 2 | Yes |
| `RemoveXbox` | Remove Xbox App | strong-pc | 2 | Yes |
| `SetHighPerformancePower` | High Performance Power Plan | strong-pc | 1 | Yes |
| `SpeedUpShutdown` | Speed Up Shutdown | strong-pc | 2 | Yes |
| `WeeklyClean` | Weekly Clean | strong-pc | 2 | Yes |
| `BulkRenamer` | Bulk Renamer | organizing | 3 | Yes |
| `CleanDesktop` | Clean Desktop | organizing | 1 | No |
| `CreateProjectStructure` | Create Project Folders | organizing | 1 | No |
| `DuplicateFileFinder` | Duplicate File Finder | organizing | 1 | Yes |
| `FindLargeFiles` | Find Large Files | organizing | 1 | No |
| `FolderSizeReport` | Folder Size Report | organizing | 1 | Yes |
| `MapNetworkDrive` | Map Network Drive | organizing | 1 | No |
| `MoveOldFiles` | Move Old Files to Archive | organizing | 2 | No |
| `OldFileArchiver` | Old File Archiver | organizing | 2 | Yes |
| `OrganizeDownloads` | Organize Downloads | organizing | 2 | No |
| `PinFolderToQuickAccess` | Pin Folders to Quick Access | organizing | 1 | No |
| `PushAndDeploy` | Push & Deploy | organizing | 1 | No |
| `RemoveEmptyFolders` | Remove Empty Folders | organizing | 2 | No |
| `RenameFilesDate` | Rename Files by Date | organizing | 2 | No |
| `SetupDevFolders` | Setup Dev Folders | organizing | 1 | No |
| `SortPhotosByDate` | Sort Photos by Date | organizing | 2 | No |
| `SwitchToEnglish` | Switch To English | organizing | 2 | Yes |
| `WiFiPasswords` | WiFi Passwords | organizing | 2 | Yes |
| `ChangeAccentColor` | Change Accent Color | aesthetic | 1 | No |
| `ChangeLoginScreenBackground` | Custom Login Screen | aesthetic | 2 | Yes |
| `CenterTaskbarIcons` | Center Taskbar Icons | aesthetic | 1 | No |
| `CleanTaskbar` | Clean Taskbar | aesthetic | 1 | No |
| `DarkModeToggle` | Dark Mode Toggle | aesthetic | 1 | No |
| `EnableDarkMode` | Enable Dark Mode | aesthetic | 1 | No |
| `EnableLightMode` | Enable Light Mode | aesthetic | 1 | No |
| `EnableNightLight` | Enable Night Light | aesthetic | 1 | No |
| `FixExplorer` | Fix Explorer | aesthetic | 1 | Yes |
| `HideTaskbarClock` | Hide Taskbar Clock | aesthetic | 1 | No |
| `NightModeScheduler` | Night Mode Scheduler | aesthetic | 1 | Yes |
| `NumlockOnStartup` | NumLock on Startup | aesthetic | 1 | Yes |
| `PowerButtonConfig` | Power Button Config | aesthetic | 1 | Yes |
| `RestorePhotoViewer` | Restore Photo Viewer | aesthetic | 1 | Yes |
| `RestoreRightClickMenu` | Restore Right-Click Menu | aesthetic | 1 | Yes |
| `SetCustomCursor` | Set Cursor to Pointer | aesthetic | 1 | No |
| `SetCustomWallpaper` | Set Custom Wallpaper | aesthetic | 1 | No |
| `SetWallpaperSlideshow` | Wallpaper Slideshow | aesthetic | 1 | No |
| `ShowFileExtensions` | Show File Extensions | aesthetic | 1 | No |
| `ShowHiddenFiles` | Show Hidden Files | aesthetic | 1 | No |
| `TransparentTaskbar` | Transparent Taskbar | aesthetic | 1 | No |
| `BlockDistractingSites` | Block Distracting Sites | fun | 2 | Yes |
| `BouncingBall` | Bouncing Ball | fun | 1 | No |
| `CowsayMessage` | Cowsay Message | fun | 1 | No |
| `FakeHacker` | Fake Hacker Screen | fun | 1 | No |
| `FireworksCelebration` | Fireworks Celebration | fun | 1 | No |
| `GamingModeToggle` | Gaming Mode Toggle | fun | 2 | Yes |
| `MatrixRain` | Matrix Rain | fun | 1 | No |
| `PongGame` | Pong Game | fun | 1 | No |
| `RainbowText` | Rainbow Text | fun | 1 | No |
| `SnakeGame` | Snake Game | fun | 1 | No |
| `StopwatchTimer` | Stopwatch Timer | fun | 1 | No |
| `TetrisGame` | Tetris Game | fun | 1 | No |
| `TerminalClock` | Terminal Clock | fun | 1 | No |
| `TypewriterText` | Typewriter Effect | fun | 1 | No |
| `PushToGitHub` | Push to GitHub | claude | 1 | No |
| `InstallGHCLI` | Install GH for Claude | claude | 1 | No |
| `SetupYoloMode` | Setup YOLO Mode | claude | 3 | No |
| `redbull` | Red Bull Mode | strong-pc | 2 | Yes |
