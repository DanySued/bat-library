@echo off
:: ============================================================
::  FixSlowRightClick.bat
::  Removes broken shell extensions that cause the
::  right-click menu to lag or freeze for several seconds
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Fixing Slow Right-Click Menu
echo  =====================================================
echo.

echo [1/3] Removing common laggy shell extensions...

:: Remove Send To menu items that slow things down
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "SendTo" /f >nul 2>&1

:: Clear the shell extension cache
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers" /f >nul 2>&1

:: Disable OneDrive shell overlays (major cause of slow right-click)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive1" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive2" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive3" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive4" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive5" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive6" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\OneDrive7" /f >nul 2>&1

:: Disable Dropbox overlays if present
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\DropboxExt1" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\DropboxExt2" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\DropboxExt3" /f >nul 2>&1

echo [2/3] Setting menu show delay to zero...
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul

echo [3/3] Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo  =====================================================
echo   Right-click menu should now be instant!
echo  =====================================================
echo.
pause
