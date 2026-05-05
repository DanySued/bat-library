@echo off
:: NightModeScheduler.bat - Schedules automatic dark mode at night
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo NightModeScheduler - Auto dark/light mode on schedule
echo.
set /p DARK_TIME=Enter time to enable DARK mode (24h, e.g. 20:00):
set /p LIGHT_TIME=Enter time to enable LIGHT mode (24h, e.g. 07:00):

:: Build PowerShell command for dark mode
set DARK_CMD=powershell -WindowStyle Hidden -Command "Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0; Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0"

:: Build PowerShell command for light mode
set LIGHT_CMD=powershell -WindowStyle Hidden -Command "Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1; Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 1"

echo.
echo Creating scheduled tasks...

schtasks /delete /tn "DarkModeOn" /f >nul 2>&1
schtasks /create /tn "DarkModeOn" /tr "%DARK_CMD%" /sc daily /st %DARK_TIME% /ru "%USERNAME%" /f >nul

schtasks /delete /tn "LightModeOn" /f >nul 2>&1
schtasks /create /tn "LightModeOn" /tr "%LIGHT_CMD%" /sc daily /st %LIGHT_TIME% /ru "%USERNAME%" /f >nul

echo.
echo Schedule created:
echo   Dark mode:  %DARK_TIME% daily
echo   Light mode: %LIGHT_TIME% daily
echo.
echo To remove: open Task Scheduler and delete 'DarkModeOn' and 'LightModeOn'.
pause
