@echo off
:: BackupDrivers.bat - Exports all installed device drivers to a backup folder
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set DEST=%UserProfile%\Desktop\DriversBackup

echo Exporting drivers to %DEST%...
mkdir "%DEST%" >nul 2>&1
dism /online /export-driver /destination:"%DEST%"

echo.
echo Done. All drivers backed up to Desktop\DriversBackup
echo You can restore them after a clean install using Device Manager.
pause
