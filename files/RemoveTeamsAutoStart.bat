@echo off
title Remove Teams Auto-Start

echo Removing Microsoft Teams from startup registry...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "com.squirrel.Teams.Teams" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /f >nul 2>&1

echo Disabling Teams machine-wide startup task...
schtasks /Change /TN "\Microsoft\Teams\Teams Startup Task" /Disable >nul 2>&1

echo Stopping Teams background process...
taskkill /f /im Teams.exe >nul 2>&1

echo Disabling Teams auto-start in registry...
reg add "HKCU\SOFTWARE\Microsoft\Office\Teams" /v "PreventFirstLaunchAfterInstall" /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo Teams will no longer launch at startup. Open Teams manually when needed.
pause
