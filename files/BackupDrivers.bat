@echo off
title Backup Drivers
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

set DEST=%USERPROFILE%\Desktop\DriversBackup

echo Backing up drivers to %DEST%...
if not exist "%DEST%" mkdir "%DEST%"

DISM /Online /Export-Driver /Destination:"%DEST%" >nul 2>&1

if %errorlevel% equ 0 (
    echo.
    echo Drivers backed up to %DEST%
) else (
    echo DISM failed. Trying pnputil...
    pnputil /export-driver * "%DEST%" >nul 2>&1
    echo Drivers exported to %DEST%
)
pause
