@echo off
:: RemoveDesktopIcons.bat - Hides all desktop icons
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideIcons" /t REG_DWORD /d 1 /f >nul
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo Desktop icons hidden. Right-click Desktop > View > Show desktop icons to restore.
