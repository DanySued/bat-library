@echo off
title Backup Start Menu Layout

set DEST=%USERPROFILE%\Desktop\StartLayout_%date:~-4,4%%date:~-10,2%%date:~-7,2%.xml

echo Exporting Start menu layout...
PowerShell -Command "Export-StartLayout -Path '%DEST%'" >nul 2>&1

if exist "%DEST%" (
    echo Start layout exported to %DEST%
) else (
    echo Failed to export. Trying alternative method...
    reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" "%USERPROFILE%\Desktop\TaskbarLayout_%date:~-4,4%%date:~-10,2%%date:~-7,2%.reg" /y >nul 2>&1
    echo Taskbar layout exported to Desktop.
)

echo.
pause
