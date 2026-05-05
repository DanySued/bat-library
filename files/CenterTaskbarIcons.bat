@echo off
title Center Taskbar Icons

echo Centering taskbar icons (Windows 11)...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAl" /t REG_DWORD /d 1 /f >nul

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Taskbar icons centered.
echo To move back to left: run this script and change /d to 0
pause
