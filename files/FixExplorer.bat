@echo off
:: ============================================================
::  FixExplorer.bat
::  - Opens to This PC instead of Quick Access
::  - Shows file extensions (.jpg, .exe, .pdf etc.)
::  - Shows hidden files and folders
::  - Shows protected OS files
::  - Removes ads in Explorer
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Fixing Windows Explorer Settings
echo  =====================================================
echo.

echo [1/5] Setting Explorer to open at This PC...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul

echo [2/5] Showing file extensions...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul

echo [3/5] Showing hidden files and folders...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >nul

echo [4/5] Showing protected operating system files...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f >nul

echo [5/5] Removing Explorer ads and sync provider notifications...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul

echo  Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo  =====================================================
echo   Explorer is now fixed!
echo   - Opens to This PC
echo   - File extensions visible (.jpg, .exe, .pdf...)
echo   - Hidden files visible
echo   - No more Explorer ads
echo  =====================================================
echo.
pause
