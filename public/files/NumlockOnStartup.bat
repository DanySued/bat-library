@echo off
:: NumlockOnStartup.bat - Forces NumLock to always be ON when Windows starts
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Enabling NumLock on startup...

:: Set for default user (login screen)
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d "2" /f >nul

:: Set for current user
reg add "HKCU\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d "2" /f >nul

echo.
echo Done! NumLock will be ON from the next startup.
echo Restart your PC to apply.
pause
