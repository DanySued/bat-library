@echo off
title Show File Extensions

echo Enabling file extensions in File Explorer...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo File extensions are now visible in File Explorer.
pause
