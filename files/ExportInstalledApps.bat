@echo off
title Export Installed Apps List

set DEST=%USERPROFILE%\Desktop\InstalledApps_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Exporting installed applications list...

echo ===== INSTALLED PROGRAMS ===== > "%DEST%"
echo. >> "%DEST%"
echo --- 64-bit programs --- >> "%DEST%"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /v "DisplayName" 2>nul | findstr "DisplayName" >> "%DEST%"
echo. >> "%DEST%"
echo --- 32-bit programs --- >> "%DEST%"
reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s /v "DisplayName" 2>nul | findstr "DisplayName" >> "%DEST%"
echo. >> "%DEST%"
echo --- Microsoft Store apps --- >> "%DEST%"
PowerShell -Command "Get-AppxPackage | Select-Object Name, Version | Format-Table -AutoSize" >> "%DEST%" 2>nul

echo.
echo Installed apps list saved to %DEST%
pause
