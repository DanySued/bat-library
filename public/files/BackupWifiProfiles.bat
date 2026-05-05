@echo off
:: BackupWifiProfiles.bat - Exports all saved WiFi profiles (includes passwords)
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set DEST=%UserProfile%\Desktop\WiFiProfiles
mkdir "%DEST%" >nul 2>&1

netsh wlan export profile folder="%DEST%" key=clear

echo.
echo WiFi profiles exported to Desktop\WiFiProfiles
echo WARNING: These files contain WiFi passwords in plain text.
echo Store them securely and delete when no longer needed.
pause
