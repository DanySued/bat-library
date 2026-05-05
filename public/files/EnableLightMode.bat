@echo off
:: EnableLightMode.bat - Switches Windows and all apps to light mode
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 1 /f >nul

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Light mode enabled.
