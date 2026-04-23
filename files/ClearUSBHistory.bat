@echo off
:: ============================================================
::  ClearUSBHistory.bat
::  Wipes the registry log of every USB device ever
::  plugged into this PC — privacy + clean device manager
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Clearing USB Device History
echo  =====================================================
echo.

echo [1/3] Removing USB device history from registry...
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\USB" /f >nul 2>&1

echo [2/3] Clearing mounted devices list...
reg delete "HKLM\SYSTEM\MountedDevices" /f >nul 2>&1
reg add "HKLM\SYSTEM\MountedDevices" >nul 2>&1

echo [3/3] Clearing setupapi device log...
del /f /q "%WINDIR%\INF\setupapi.dev.log" >nul 2>&1
del /f /q "%WINDIR%\INF\setupapi.app.log" >nul 2>&1

echo.
echo  =====================================================
echo   USB history cleared!
echo   All previously connected USB device records
echo   have been removed from this PC.
echo   Note: your currently connected devices will
echo   re-register automatically and work normally.
echo  =====================================================
echo.
pause
