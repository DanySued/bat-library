@echo off
:: WiFiPasswords.bat - Shows saved passwords for all WiFi networks
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set OUTPUT=%UserProfile%\Desktop\WiFiPasswords.txt

echo WiFiPasswords - Showing saved WiFi passwords
echo.
echo WARNING: This file contains plain-text passwords.
echo Delete WiFiPasswords.txt from Desktop when done!
echo.

echo WiFi Passwords - %date% %time% > "%OUTPUT%"
echo ======================================== >> "%OUTPUT%"
echo. >> "%OUTPUT%"

for /f "skip=1 tokens=*" %%p in ('netsh wlan show profiles') do (
    for /f "tokens=2 delims=:" %%a in ("%%p") do (
        set "PROFILE=%%a"
        setlocal enabledelayedexpansion
        set "PROFILE=!PROFILE:~1!"
        for /f "skip=1 tokens=2 delims=:" %%b in ('netsh wlan show profile "!PROFILE!" key=clear 2^>nul ^| findstr "Key Content"') do (
            echo Network: !PROFILE! >> "%OUTPUT%"
            echo Password: %%b>> "%OUTPUT%"
            echo ──────────────────────────── >> "%OUTPUT%"
            echo Network: !PROFILE!
            echo Password: %%b
            echo.
        )
        endlocal
    )
)

echo.
echo Saved to Desktop\WiFiPasswords.txt
echo IMPORTANT: Delete this file when you are done with it.
pause
