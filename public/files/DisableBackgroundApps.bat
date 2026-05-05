@echo off
:: DisableBackgroundApps.bat - Prevents Store apps from running in background
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d 0 /f >nul

echo Done. Background app execution disabled for all Store apps.
echo Apps still work normally when you open them.
