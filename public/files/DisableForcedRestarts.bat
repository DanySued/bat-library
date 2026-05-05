@echo off
:: DisableForcedRestarts.bat - Stops Windows from auto-rebooting after updates
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Disabling forced automatic restarts from Windows Update...

:: Set Active Hours (7am to 11pm)
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v ActiveHoursStart /t REG_DWORD /d 7 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v ActiveHoursEnd /t REG_DWORD /d 23 /f >nul

:: No auto-restart with logged on users
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f >nul

:: Always auto-download and notify for install
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 3 /f >nul

:: Scheduled restart notification
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v RestartNotificationsAllowed2 /t REG_DWORD /d 1 /f >nul

:: Disable automatic restart required notifications from suppressing
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v SetAutoRestartNotificationDisable /t REG_DWORD /d 0 /f >nul

echo.
echo Forced restarts disabled. Windows will notify you before restarting.
echo Updates will still download and install in the background.
pause
