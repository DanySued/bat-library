@echo off
:: ============================================================
::  FixSound.bat
::  Resets Windows audio service and fixes common sound issues
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Fixing Sound Problems
echo  =====================================================
echo.

echo [1/4] Restarting audio services...
net stop audiosrv >nul 2>&1
net stop AudioEndpointBuilder >nul 2>&1
timeout /t 2 >nul
net start audiosrv >nul 2>&1
net start AudioEndpointBuilder >nul 2>&1

echo [2/4] Re-enabling audio service auto-start...
sc config audiosrv start=auto >nul 2>&1
sc config AudioEndpointBuilder start=auto >nul 2>&1

echo [3/4] Resetting audio device settings...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /f >nul 2>&1

echo [4/4] Running audio troubleshooter automatically...
msdt.exe /id AudioPlaybackDiagnostic >nul 2>&1

echo.
echo  =====================================================
echo   Audio services restarted!
echo   If still no sound: right-click the speaker icon
echo   in your taskbar and choose Troubleshoot Sound.
echo   Or restart your PC.
echo  =====================================================
echo.
pause
