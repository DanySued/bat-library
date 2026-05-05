@echo off
title Backup WiFi Profiles
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

set DEST=%USERPROFILE%\Desktop\WifiProfiles

if not exist "%DEST%" mkdir "%DEST%"

echo Exporting all saved WiFi profiles...
for /F "tokens=2 delims=:" %%G in ('netsh wlan show profiles ^| findstr "All User"') do (
    set PROFILE=%%G
    set PROFILE=!PROFILE:~1!
    netsh wlan export profile name="!PROFILE!" folder="%DEST%" key=clear >nul 2>&1
)

setlocal enabledelayedexpansion
for /F "tokens=2 delims=:" %%G in ('netsh wlan show profiles ^| findstr "All User"') do (
    set PROFILE=%%G
    set PROFILE=!PROFILE:~1!
    netsh wlan export profile name="!PROFILE!" folder="%DEST%" key=clear >nul 2>&1
)

echo.
echo WiFi profiles exported to %DEST%
echo To restore: netsh wlan add profile filename="profile.xml"
pause
