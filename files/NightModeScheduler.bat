@echo off
:: ============================================================
::  NightModeScheduler.bat
::  Schedules automatic dark mode at night
::  and light mode in the morning
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Night Mode Scheduler
echo  =====================================================
echo.

set /p "NIGHTTIME=What time to switch to DARK mode? (e.g. 20:00): "
if "%NIGHTTIME%"=="" set "NIGHTTIME=20:00"

set /p "DAYTIME=What time to switch to LIGHT mode? (e.g. 07:00): "
if "%DAYTIME%"=="" set "DAYTIME=07:00"

:: Create dark mode script
set "DARKSCRIPT=%SYSTEMDRIVE%\SetDarkMode.bat"
echo @echo off > "%DARKSCRIPT%"
echo reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f ^>nul >> "%DARKSCRIPT%"
echo reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f ^>nul >> "%DARKSCRIPT%"

:: Create light mode script
set "LIGHTSCRIPT=%SYSTEMDRIVE%\SetLightMode.bat"
echo @echo off > "%LIGHTSCRIPT%"
echo reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f ^>nul >> "%LIGHTSCRIPT%"
echo reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 1 /f ^>nul >> "%LIGHTSCRIPT%"

:: Schedule tasks
schtasks /delete /tn "AutoDarkMode" /f >nul 2>&1
schtasks /delete /tn "AutoLightMode" /f >nul 2>&1

schtasks /create /tn "AutoDarkMode" /tr "%DARKSCRIPT%" /sc daily /st %NIGHTTIME% /ru "%USERNAME%" /f >nul 2>&1
schtasks /create /tn "AutoLightMode" /tr "%LIGHTSCRIPT%" /sc daily /st %DAYTIME% /ru "%USERNAME%" /f >nul 2>&1

echo.
echo  =====================================================
echo   Night Mode Scheduler set!
echo.
echo   Dark mode:  every day at %NIGHTTIME%
echo   Light mode: every day at %DAYTIME%
echo.
echo   To cancel: open Task Scheduler and delete
echo   "AutoDarkMode" and "AutoLightMode"
echo  =====================================================
echo.
pause
