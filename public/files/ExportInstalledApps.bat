@echo off
:: ExportInstalledApps.bat - Saves a list of all installed programs to a text file
set OUT=%UserProfile%\Desktop\InstalledApps.txt

echo ============================================= > "%OUT%"
echo  Installed Programs - %DATE% %TIME% >> "%OUT%"
echo ============================================= >> "%OUT%"
echo. >> "%OUT%"

echo [Registry - 64-bit Programs] >> "%OUT%"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr "DisplayName" >> "%OUT%"

echo. >> "%OUT%"
echo [Registry - 32-bit Programs] >> "%OUT%"
reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr "DisplayName" >> "%OUT%"

echo. >> "%OUT%"
echo [Winget Packages] >> "%OUT%"
winget list >> "%OUT%" 2>&1

echo Done. Installed apps list saved to Desktop\InstalledApps.txt
pause
