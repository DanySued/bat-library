@echo off
:: CleanWindowsUpdateCache.bat - Deletes downloaded Windows Update files
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Stopping Windows Update services...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop cryptsvc >nul 2>&1

echo Deleting update download cache...
del /s /f /q "C:\Windows\SoftwareDistribution\Download\*.*" >nul 2>&1
for /d %%i in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%i" >nul 2>&1

echo Restarting Windows Update services...
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
net start cryptsvc >nul 2>&1

echo Done. Windows Update cache cleared.
echo Windows Update will re-download any needed updates.
pause
