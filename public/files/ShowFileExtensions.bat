@echo off
:: ShowFileExtensions.bat - Makes file extensions visible in Explorer
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo File extensions are now visible (e.g. photo.jpg, document.pdf).
