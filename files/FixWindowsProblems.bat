@echo off
:: ============================================================
::  FixWindowsProblems.bat
::  Resets Windows Update, repairs corrupt files, fixes network
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Fix Common Windows Problems
echo  =====================================================
echo.

echo [1/5] Stopping Windows Update services...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1

echo [2/5] Clearing Windows Update cache...
rd /s /q "%WINDIR%\SoftwareDistribution" >nul 2>&1
rd /s /q "%WINDIR%\System32\catroot2" >nul 2>&1

echo [3/5] Restarting Windows Update services...
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
net start msiserver >nul 2>&1

echo [4/5] Repairing Windows system files...
echo    Running SFC...
sfc /scannow
echo    Running DISM...
DISM /Online /Cleanup-Image /RestoreHealth

echo [5/5] Resetting network stack...
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
ipconfig /flushdns >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1

echo.
echo  =====================================================
echo   All fixes applied!
echo   Please restart your computer for full effect.
echo  =====================================================
echo.
pause
