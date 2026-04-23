@echo off
:: ============================================================
::  FixMicrosoftStore.bat
::  Resets the Microsoft Store when apps won't install,
::  update, or the Store won't open
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Fixing Microsoft Store
echo  =====================================================
echo.

echo [1/4] Clearing Store cache...
wsreset.exe

echo [2/4] Re-registering Store app...
powershell -Command "Get-AppxPackage -AllUsers *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml' -ErrorAction SilentlyContinue}" >nul 2>&1

echo [3/4] Resetting Store license service...
net stop ClipSVC >nul 2>&1
net start ClipSVC >nul 2>&1
net stop wlidsvc >nul 2>&1
net start wlidsvc >nul 2>&1

echo [4/4] Clearing Store proxy settings...
netsh winhttp reset proxy >nul 2>&1

echo.
echo  =====================================================
echo   Microsoft Store reset complete!
echo   Try opening the Store and installing apps now.
echo   If it still fails, try signing out and back in
echo   to your Microsoft account inside the Store.
echo  =====================================================
echo.
pause
