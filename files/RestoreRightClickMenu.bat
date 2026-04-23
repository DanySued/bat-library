@echo off
:: ============================================================
::  RestoreRightClickMenu.bat
::  Brings back the full classic right-click context menu
::  on Windows 11 (removes the simplified "Show more options")
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Restoring Classic Right-Click Menu
echo  =====================================================
echo.

echo [1/2] Applying registry fix...
reg add "HKCU\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul
echo    Done.

echo [2/2] Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo    Done.

echo.
echo  =====================================================
echo   Classic right-click menu restored!
echo   Right-click any file or folder to see it.
echo.
echo   To undo and go back to Windows 11 menu, run:
echo   reg delete "HKCU\SOFTWARE\Classes\CLSID\
echo   {86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
echo  =====================================================
echo.
pause
