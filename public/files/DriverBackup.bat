@echo off
:: DriverBackup.bat - Saves all current hardware drivers to a folder
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set DEST=%UserProfile%\Desktop\DriversBackup

echo DriverBackup - Exporting all hardware drivers...
echo Destination: %DEST%
echo.

if not exist "%DEST%" mkdir "%DEST%"

dism /online /export-driver /destination:"%DEST%"

if %errorlevel%==0 (
    echo.
    echo Driver backup complete!
    echo Saved to: %DEST%
    echo.
    echo To restore after Windows reinstall:
    echo   Device Manager ^> Action ^> Add legacy hardware ^> point to %DEST%
) else (
    echo.
    echo Error exporting drivers. Make sure you ran as administrator.
)
pause
