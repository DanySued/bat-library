@echo off
:: FixWindowsUpdate.bat - Fixes stuck or broken Windows Update
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Fixing Windows Update...
echo.

echo Stopping Windows Update services...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1

echo Clearing Windows Update cache...
rd /s /q "%SystemRoot%\SoftwareDistribution" >nul 2>&1
rd /s /q "%SystemRoot%\System32\catroot2" >nul 2>&1

echo Re-registering Windows Update components...
regsvr32 /s atl.dll >nul
regsvr32 /s urlmon.dll >nul
regsvr32 /s mshtml.dll >nul
regsvr32 /s shdocvw.dll >nul
regsvr32 /s browseui.dll >nul
regsvr32 /s jscript.dll >nul
regsvr32 /s vbscript.dll >nul
regsvr32 /s scrrun.dll >nul
regsvr32 /s msxml.dll >nul
regsvr32 /s msxml3.dll >nul
regsvr32 /s msxml6.dll >nul
regsvr32 /s actxprxy.dll >nul
regsvr32 /s softpub.dll >nul
regsvr32 /s wintrust.dll >nul
regsvr32 /s dssenh.dll >nul
regsvr32 /s rsaenh.dll >nul
regsvr32 /s gpkcsp.dll >nul
regsvr32 /s sccbase.dll >nul
regsvr32 /s slbcsp.dll >nul
regsvr32 /s cryptdlg.dll >nul
regsvr32 /s wuapi.dll >nul
regsvr32 /s wuaueng.dll >nul
regsvr32 /s wuaueng1.dll >nul
regsvr32 /s wucltui.dll >nul
regsvr32 /s wups.dll >nul
regsvr32 /s wups2.dll >nul
regsvr32 /s wuweb.dll >nul

echo Resetting BITS and Winsock...
netsh winsock reset >nul
netsh winhttp reset proxy >nul

echo Restarting services...
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
net start msiserver >nul 2>&1

echo.
echo Windows Update reset complete.
echo Open Settings ^> Windows Update and check for updates.
pause
