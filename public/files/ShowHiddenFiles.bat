@echo off
:: ShowHiddenFiles.bat - Makes hidden files and folders visible in Explorer
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f >nul

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Hidden files and folders are now visible.
