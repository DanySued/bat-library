@echo off
:: ============================================================
::  NumlockOnStartup.bat
::  Forces NumLock to always be ON when Windows starts
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Enabling NumLock on Startup
echo  =====================================================
echo.

echo [1/2] Setting NumLock on for current user...
reg add "HKCU\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f >nul

echo [2/2] Setting NumLock on for login screen and all users...
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "Numlock" /t REG_DWORD /d 1 /f >nul

echo.
echo  =====================================================
echo   Done! NumLock will now be ON every time
echo   Windows starts, including the login screen.
echo  =====================================================
echo.
pause
