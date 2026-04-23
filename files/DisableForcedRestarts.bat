@echo off
:: ============================================================
::  DisableForcedRestarts.bat
::  Stops Windows from auto-rebooting your PC after updates
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Disabling Windows Update Forced Restarts
echo  =====================================================
echo.

echo [1/3] Disabling auto-restart after updates...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUPowerManagement" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "IsExpedited" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "RestartNotificationsAllowed2" /t REG_DWORD /d 0 /f >nul

echo [2/3] Setting Active Hours to maximum (6am - 2am)...
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursStart" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursEnd" /t REG_DWORD /d 2 /f >nul

echo [3/3] Disabling Windows Update delivery via P2P...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul

echo.
echo  =====================================================
echo   Done! Windows will no longer restart your PC
echo   automatically after installing updates.
echo   Updates still install — just no surprise reboots.
echo  =====================================================
echo.
pause
