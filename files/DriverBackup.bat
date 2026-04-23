@echo off
:: ============================================================
::  DriverBackup.bat
::  Saves all current hardware drivers to a folder
::  so you can reinstall them after a fresh Windows install
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Driver Backup
echo  =====================================================
echo.

for /f "tokens=2 delims==" %%a in ('wmic OS get LocalDateTime /value') do set "dt=%%a"
set "DATESTR=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%"
set "OUTDIR=%USERPROFILE%\Desktop\DriverBackup_%DATESTR%"

echo  Saving all drivers to:
echo  %OUTDIR%
echo.
echo  This may take a few minutes...

md "%OUTDIR%" >nul 2>&1
dism /online /export-driver /destination:"%OUTDIR%"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo  =====================================================
    echo   Driver backup complete!
    echo   Folder: DriverBackup_%DATESTR% on your Desktop
    echo.
    echo   After a fresh Windows install, go to:
    echo   Device Manager - right-click a device -
    echo   Update Driver - Browse my computer -
    echo   point to this folder.
    echo  =====================================================
) else (
    echo  [ERROR] Backup may have failed. Try running again.
)
echo.
pause
