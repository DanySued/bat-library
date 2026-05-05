@echo off
title Hide Taskbar Clock

echo Hiding clock from taskbar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideClock" /t REG_DWORD /d 1 /f >nul

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Taskbar clock hidden.
echo To restore: delete HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\HideClock
pause
