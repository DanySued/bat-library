@echo off
title Enable Transparent Taskbar

echo Enabling taskbar transparency...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 1 /f >nul

rem Set translucency effect
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d 1 /f >nul 2>&1

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Taskbar transparency enabled.
echo For full transparency, consider a tool like TranslucentTB from the Microsoft Store.
pause
