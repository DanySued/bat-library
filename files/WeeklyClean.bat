@echo off
:: ============================================================
::  WeeklyClean.bat
::  Silent quick clean — temp files, caches, DNS flush
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Weekly Auto-Clean — Running...
echo  =====================================================
echo.

echo  Clearing Windows Temp...
del /s /f /q "%WINDIR%\Temp\*.*" >nul 2>&1
rd /s /q "%WINDIR%\Temp" >nul 2>&1 & md "%WINDIR%\Temp" >nul 2>&1

echo  Clearing User Temp...
del /s /f /q "%TEMP%\*.*" >nul 2>&1
rd /s /q "%TEMP%" >nul 2>&1 & md "%TEMP%" >nul 2>&1

echo  Clearing Prefetch...
del /s /f /q "%WINDIR%\Prefetch\*.*" >nul 2>&1

echo  Clearing browser caches...
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im firefox.exe >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.default*\cache2\*.*" >nul 2>&1

echo  Clearing Recent Documents...
del /s /f /q "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1

echo  Clearing Thumbnail cache...
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

echo  Clearing Windows Update download cache...
net stop wuauserv >nul 2>&1
del /s /f /q "%WINDIR%\SoftwareDistribution\Download\*.*" >nul 2>&1
net start wuauserv >nul 2>&1

echo  Clearing clipboard...
powershell -Command "Clear-Clipboard" >nul 2>&1

echo  Flushing DNS...
ipconfig /flushdns >nul 2>&1

echo  Running Disk Cleanup...
cleanmgr /sagerun:1 >nul 2>&1

echo  Flushing standby RAM...
rundll32.exe advapi32.dll,ProcessIdleTasks >nul 2>&1

echo.
echo  =====================================================
echo   Clean complete! Your PC is fresh.
echo  =====================================================
echo.
pause
