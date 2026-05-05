@echo off
title Remove Cortana
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Uninstalling Cortana app package...
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *Microsoft.549981C3F5F10* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue"

echo Disabling Cortana via registry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul

echo Removing Cortana from taskbar search...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Cortana disabled. Windows Search still works normally.
pause
