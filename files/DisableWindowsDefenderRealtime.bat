@echo off
title Disable Defender Real-Time Protection
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo WARNING: Disabling real-time protection reduces your security.
echo Only do this if you have a third-party antivirus installed.
echo.
set /p confirm=Type YES to continue:
if /i not "%confirm%"=="YES" (
    echo Cancelled.
    pause
    exit /b 0
)

echo Disabling Windows Defender real-time protection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul

PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1

echo.
echo Real-time protection disabled.
pause
