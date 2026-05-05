@echo off
:: FixWindowsProblems.bat - Comprehensive Windows repair (SFC, DISM, network reset)
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo ============================================================
echo  FixWindowsProblems - Comprehensive Windows Repair
echo  This takes 15-30 minutes. Do NOT close this window.
echo ============================================================
echo.

echo [1/6] Running System File Checker (SFC)...
sfc /scannow
echo    Done.

echo.
echo [2/6] Running DISM to repair Windows component store...
dism /online /cleanup-image /restorehealth
echo    Done.

echo.
echo [3/6] Resetting Windows Update components...
net stop wuauserv >nul
net stop cryptSvc >nul
net stop bits >nul
net stop msiserver >nul
rd /s /q %SystemRoot%\SoftwareDistribution >nul 2>&1
md %SystemRoot%\SoftwareDistribution >nul 2>&1
net start wuauserv >nul
net start cryptSvc >nul
net start bits >nul
net start msiserver >nul
echo    Done.

echo.
echo [4/6] Resetting network stack...
netsh winsock reset >nul
netsh int ip reset >nul
echo    Done.

echo.
echo [5/6] Flushing DNS and renewing IP...
ipconfig /flushdns >nul
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
echo    Done.

echo.
echo [6/6] Re-registering system DLLs...
for %%f in (atl.dll oleaut32.dll ole32.dll shell32.dll initpki.dll wuapi.dll wuaueng.dll wuaueng1.dll wucltui.dll wups.dll wups2.dll wuweb.dll) do (
    regsvr32 /s %%f >nul 2>&1
)
echo    Done.

echo.
echo ============================================================
echo  All repairs complete! A restart is recommended.
echo ============================================================
set /p RESTART=Restart now? (Y/N):
if /i "%RESTART%"=="Y" shutdown /r /t 10
pause
