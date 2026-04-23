@echo off
:: ============================================================
::  ClearRecentActivity.bat
::  Wipes jump lists, recent files, search history,
::  clipboard history and run history
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Clearing All Recent Activity
echo  =====================================================
echo.

echo [1/6] Clearing Recent Documents...
del /s /f /q "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1
del /s /f /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*.*" >nul 2>&1
del /s /f /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*.*" >nul 2>&1

echo [2/6] Clearing Jump Lists...
del /s /f /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
del /s /f /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*" >nul 2>&1

echo [3/6] Clearing Search History...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery" /f >nul 2>&1

echo [4/6] Clearing Run History...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >nul 2>&1

echo [5/6] Clearing Clipboard History...
powershell -Command "Clear-Clipboard" >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d 0 /f >nul

echo [6/6] Clearing Quick Access pinned recents in Explorer...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul

echo  Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo  =====================================================
echo   All recent activity cleared!
echo  =====================================================
echo.
pause
