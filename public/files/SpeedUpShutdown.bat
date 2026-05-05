@echo off
:: SpeedUpShutdown.bat - Reduces Windows shutdown time
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "FastShutdown" /t REG_DWORD /d 1 /f >nul

echo Done. Shutdown and restart should now be significantly faster.
echo Save all work before shutting down - apps are killed quickly.
pause
