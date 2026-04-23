@echo off
:: ============================================================
::  GamingModeToggle.bat
::  ON  — kills background services, sets high performance,
::         disables notifications and Windows Update
::  OFF — restores everything back to normal
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)

:: Check current state via a flag file
if exist "%TEMP%\gaming_mode_on.flag" goto :TURN_OFF

:TURN_ON
echo.
echo  =====================================================
echo   Gaming Mode — TURNING ON
echo  =====================================================
echo.
echo  Killing background processes...
taskkill /f /im OneDrive.exe >nul 2>&1
taskkill /f /im Teams.exe >nul 2>&1
taskkill /f /im Skype.exe >nul 2>&1
taskkill /f /im SearchApp.exe >nul 2>&1
taskkill /f /im SearchIndexer.exe >nul 2>&1
taskkill /f /im MicrosoftEdge.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im chrome.exe >nul 2>&1

echo  Pausing Windows Update...
net stop wuauserv >nul 2>&1
sc config wuauserv start=disabled >nul 2>&1

echo  Setting Ultimate Performance power plan...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
for /f "tokens=4" %%G in ('powercfg -list ^| findstr /i "Ultimate"') do (
    powercfg -setactive %%G >nul 2>&1
)

echo  Disabling notifications...
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f >nul

echo  Flushing RAM...
rundll32.exe advapi32.dll,ProcessIdleTasks >nul 2>&1

echo  Flushing DNS...
ipconfig /flushdns >nul 2>&1

:: Save flag
echo on > "%TEMP%\gaming_mode_on.flag"

echo.
echo  =====================================================
echo   GAMING MODE IS ON
echo   Background services paused, RAM flushed,
echo   max performance activated. Good luck!
echo   Run this file again after gaming to restore.
echo  =====================================================
echo.
pause
goto :EOF

:TURN_OFF
echo.
echo  =====================================================
echo   Gaming Mode — TURNING OFF
echo  =====================================================
echo.
echo  Restoring Windows Update...
sc config wuauserv start=auto >nul 2>&1
net start wuauserv >nul 2>&1

echo  Restoring notifications...
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /f >nul 2>&1

echo  Restoring balanced power plan...
powercfg -setactive SCHEME_BALANCED >nul 2>&1

:: Remove flag
del "%TEMP%\gaming_mode_on.flag" >nul 2>&1

echo.
echo  =====================================================
echo   GAMING MODE IS OFF — Everything restored.
echo  =====================================================
echo.
pause
