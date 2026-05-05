@echo off
title Remove Desktop Icons

echo Hiding all desktop icons...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideIcons" /t REG_DWORD /d 1 /f >nul

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Desktop icons hidden. To restore: right-click desktop > View > Show desktop icons.
pause
