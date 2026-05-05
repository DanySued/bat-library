@echo off
:: ClearUSBHistory.bat - Clears USB device history from registry
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo ClearUSBHistory - Remove USB device history from registry
echo.
echo This will remove all records of previously connected USB devices.
echo Currently connected devices are not affected.
echo.
pause

echo Clearing USBSTOR registry entries...
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR" /f >nul 2>&1

echo Clearing USB registry entries...
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\USB" /f >nul 2>&1

echo Clearing MountPoints2 (drive letter assignments)...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2" /f >nul 2>&1

echo Clearing device class registry entries...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\DeviceClasses\{53f56307-b6bf-11d0-94f2-00a0c91efb8b}" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\DeviceClasses\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}" /f >nul 2>&1

echo.
echo USB history cleared. Reconnect USB devices to re-register them.
pause
