@echo off
title Disable Background Apps

echo Disabling background app access for all apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >nul

echo Disabling background apps via policy...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >nul 2>&1

echo.
echo Background app access disabled. Apps will no longer run in the background.
pause
