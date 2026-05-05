@echo off
:: ChangeLoginScreenBackground.bat - Sets a custom login screen background
:: EDIT: Set the path to your image below
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set IMAGE=C:\Users\%USERNAME%\Pictures\lockscreen.jpg

if not exist "%IMAGE%" (
    echo Image not found: %IMAGE%
    echo Edit this script with the path to your image.
    pause
    exit /b
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "LockScreenImage" /t REG_SZ /d "%IMAGE%" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoChangingLockScreen" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f >nul

echo Login screen background set to: %IMAGE%
echo Changes will appear on next lock (Win+L) or logoff.
pause
