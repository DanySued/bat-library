@echo off
:: ============================================================
::  FixBluetooth.bat
::  Re-enables Bluetooth services disabled by CleanWindows
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause
    exit /b
)

echo.
echo  =====================================================
echo   Re-enabling Bluetooth Services
echo  =====================================================
echo.

echo [1/2] Restoring Bluetooth services...

sc config bthserv start=auto >nul 2>&1
sc start bthserv >nul 2>&1

sc config BluetoothUserService start=auto >nul 2>&1
sc start BluetoothUserService >nul 2>&1

sc config BthAvctpSvc start=auto >nul 2>&1
sc start BthAvctpSvc >nul 2>&1

sc config BTAGService start=demand >nul 2>&1
sc start BTAGService >nul 2>&1

echo    Done.

echo [2/2] Restarting Bluetooth driver...
powershell -Command "Get-PnpDevice | Where-Object {$_.Class -eq 'Bluetooth'} | Enable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue" >nul 2>&1
echo    Done.

echo.
echo  =====================================================
echo   Bluetooth is back on!
echo   Try connecting your mouse now.
echo   If it still doesn't work, restart your computer.
echo  =====================================================
echo.
pause
