@echo off
:: ============================================================
::  WiFiPasswords.bat
::  Shows saved passwords for all WiFi networks on this PC
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   WiFi Saved Passwords
echo  =====================================================
echo.

:: Save to a text file on Desktop too
set "OUTPUT=%USERPROFILE%\Desktop\WiFiPasswords.txt"
echo WiFi Saved Passwords — %DATE% %TIME% > "%OUTPUT%"
echo ============================================== >> "%OUTPUT%"
echo. >> "%OUTPUT%"

for /f "skip=1 tokens=2 delims=:" %%a in ('netsh wlan show profiles') do (
    set "PROFILE=%%a"
    setlocal enabledelayedexpansion
    set "PROFILE=!PROFILE:~1!"
    for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="!PROFILE!" key^=clear 2^>nul ^| findstr /i "key content"') do (
        set "PASS=%%b"
        set "PASS=!PASS:~1!"
        echo  Network:  !PROFILE!
        echo  Password: !PASS!
        echo  ----------------------------------------
        echo Network:  !PROFILE! >> "%OUTPUT%"
        echo Password: !PASS! >> "%OUTPUT%"
        echo. >> "%OUTPUT%"
    )
    endlocal
)

echo.
echo  =====================================================
echo   Done! Results also saved to your Desktop:
echo   WiFiPasswords.txt
echo  =====================================================
echo.
pause
