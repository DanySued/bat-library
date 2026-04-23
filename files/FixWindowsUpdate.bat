@echo off
:: ============================================================
::  FixWindowsUpdate.bat
::  Fixes stuck, broken, or endlessly-spinning Windows Update
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Fixing Windows Update
echo  =====================================================
echo.

echo [1/6] Stopping update services...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1
net stop appidsvc >nul 2>&1
net stop trustedinstaller >nul 2>&1

echo [2/6] Clearing update cache...
rd /s /q "%WINDIR%\SoftwareDistribution" >nul 2>&1
rd /s /q "%WINDIR%\System32\catroot2" >nul 2>&1

echo [3/6] Re-registering update DLLs...
regsvr32 /s atl.dll
regsvr32 /s urlmon.dll
regsvr32 /s mshtml.dll
regsvr32 /s shdocvw.dll
regsvr32 /s browseui.dll
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
regsvr32 /s wuapi.dll
regsvr32 /s wuaueng.dll
regsvr32 /s wucltui.dll
regsvr32 /s wups.dll
regsvr32 /s wups2.dll
regsvr32 /s wuweb.dll
regsvr32 /s qmgr.dll
regsvr32 /s wucltux.dll
regsvr32 /s muweb.dll

echo [4/6] Resetting network for update servers...
netsh winsock reset >nul 2>&1
netsh winhttp reset proxy >nul 2>&1

echo [5/6] Restarting update services...
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
net start msiserver >nul 2>&1
net start appidsvc >nul 2>&1

echo [6/6] Running DISM to repair Windows image...
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo  =====================================================
echo   Windows Update fix complete!
echo   Please restart and try Windows Update again.
echo  =====================================================
echo.
pause
