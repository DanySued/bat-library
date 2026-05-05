@echo off
:: DisableStartupPrograms.bat - Opens Task Manager to Startup tab and disables common bloatware
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Disabling common bloatware startup entries...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Skype" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Spotify" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Discord" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Steam" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "AdobeUpdater" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "CCleaner" /f >nul 2>&1

echo Opening Task Manager Startup tab for manual review...
start taskmgr /0 /startup

echo.
echo Startup entries cleared for common apps.
echo Review Task Manager to disable any remaining startup items.
pause
