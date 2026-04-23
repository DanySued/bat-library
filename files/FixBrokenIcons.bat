@echo off
:: ============================================================
::  FixBrokenIcons.bat
::  Rebuilds the icon cache — fixes blank, wrong, or
::  missing icons on desktop and in Explorer
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Fixing Broken Icons
echo  =====================================================
echo.

echo [1/4] Stopping Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul

echo [2/4] Deleting icon cache files...
del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1

echo [3/4] Clearing thumbnail database...
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db" >nul 2>&1

echo [4/4] Restarting Explorer...
ie4uinit.exe -show >nul 2>&1
start explorer.exe
timeout /t 3 >nul

echo.
echo  =====================================================
echo   Icon cache rebuilt!
echo   All icons should now display correctly.
echo   If some are still broken, restart your PC.
echo  =====================================================
echo.
pause
