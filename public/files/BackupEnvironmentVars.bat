@echo off
:: BackupEnvironmentVars.bat - Exports all environment variables to text file
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set OUT=%UserProfile%\Desktop\EnvironmentVars.txt

echo ======================================= > "%OUT%"
echo  Environment Variables - %DATE% >> "%OUT%"
echo ======================================= >> "%OUT%"
echo. >> "%OUT%"
echo [USER ENVIRONMENT VARIABLES] >> "%OUT%"
reg query "HKCU\Environment" >> "%OUT%"
echo. >> "%OUT%"
echo [SYSTEM ENVIRONMENT VARIABLES] >> "%OUT%"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" >> "%OUT%"

echo Done. Environment variables exported to Desktop\EnvironmentVars.txt
pause
