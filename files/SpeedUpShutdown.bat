@echo off
title Speed Up Shutdown
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Reducing shutdown wait times...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "ActiveDumpCount" /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo Shutdown speed optimized. Services and apps will be terminated faster.
pause
