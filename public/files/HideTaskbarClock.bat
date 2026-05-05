@echo off
:: HideTaskbarClock.bat - Hides the clock from the system tray
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideClock" /t REG_DWORD /d 1 /f >nul

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Clock hidden from taskbar. Restore via Settings > Taskbar > Notification area.
