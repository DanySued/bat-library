@echo off
:: FixBluetooth.bat - Re-enables and restarts Bluetooth services
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Fixing Bluetooth...
echo.

echo Setting Bluetooth Support Service to automatic...
sc config "bthserv" start= auto >nul 2>&1

echo Restarting Bluetooth Support Service...
net stop bthserv >nul 2>&1
net start bthserv >nul 2>&1

echo Restarting Bluetooth Audio Gateway...
net stop BTAGService >nul 2>&1
net start BTAGService >nul 2>&1

echo Restarting Bluetooth User Support...
net stop BluetoothUserService >nul 2>&1
net start BluetoothUserService >nul 2>&1

echo Re-enabling Bluetooth adapter via DevCon (if available)...
pnputil /enable-device "BTH\MS_BTHPAN" >nul 2>&1

echo Flushing Bluetooth device cache...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\BthPort\Parameters\Devices" /f >nul 2>&1

echo.
echo Done! Steps to complete:
echo 1. Toggle Bluetooth off then on in Settings
echo 2. Try pairing your device again
echo.
echo If Bluetooth still doesn't appear, check Device Manager for a disabled adapter.
pause
