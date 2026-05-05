@echo off
:: CreateSystemImage.bat - Opens Windows Backup and Restore for system image creation
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Opening Windows Backup and Restore (Windows 7)...
echo This tool lets you create a full system image backup.
echo You will need an external drive with enough free space.
echo.
start sdclt.exe
