@echo off
:: FixMicrosoftStore.bat - Resets Microsoft Store when apps won't install or update
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Resetting Microsoft Store...
echo A blank window may open briefly - this is normal.
echo.

echo Stopping Store services...
net stop wuauserv >nul 2>&1
net stop AppXSvc >nul 2>&1
net stop InstallService >nul 2>&1

echo Clearing Store cache...
wsreset.exe

echo Clearing pending download queue...
del /s /q /f "%LocalAppData%\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache\*" >nul 2>&1

echo Re-registering Microsoft Store...
powershell -Command "Get-AppxPackage *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\"}" >nul 2>&1

echo Restarting services...
net start AppXSvc >nul 2>&1
net start InstallService >nul 2>&1
net start wuauserv >nul 2>&1

echo.
echo Microsoft Store reset complete.
echo Open the Store and try your download again.
pause
