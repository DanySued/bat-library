@echo off
:: RemoveEdgeCompletely.bat - Disables Microsoft Edge as much as possible
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Removing Edge from startup...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1

echo Disabling Edge background processes...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul

echo Disabling Edge startup boost...
reg add "HKCU\SOFTWARE\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul

echo Removing Edge scheduled tasks...
schtasks /Change /TN "\Microsoft\EdgeUpdate\MicrosoftEdgeUpdateTaskMachineCore" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\EdgeUpdate\MicrosoftEdgeUpdateTaskMachineUA" /DISABLE >nul 2>&1

echo.
echo NOTE: Full Edge uninstall is blocked by Microsoft on Windows 11.
echo Edge startup boost and background mode have been disabled.
echo Use a tool like 'Bloatbox' for complete removal.
pause
