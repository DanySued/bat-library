@echo off
:: RemoveTeamsAutoStart.bat - Prevents Teams from launching at startup

echo Stopping Teams process...
taskkill /f /im Teams.exe >nul 2>&1
taskkill /f /im ms-teams.exe >nul 2>&1

echo Removing Teams from startup registry...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "com.squirrel.Teams.Teams" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /f >nul 2>&1

echo Disabling Teams machine-wide startup...
reg add "HKCU\SOFTWARE\Microsoft\Office\Teams" /v "PreventFirstLaunchAfterInstall" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Office\Teams" /v "disableAutoStart" /t REG_DWORD /d 1 /f >nul

echo Disabling Teams startup via scheduled tasks...
schtasks /Change /TN "\Microsoft\Teams\TeamsTrayUpdater" /DISABLE >nul 2>&1

echo Done. Teams will no longer auto-start on login.
pause
