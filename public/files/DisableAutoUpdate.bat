@echo off
:: DisableAutoUpdate.bat - Pauses Windows Update for 35 days
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

:: Calculate pause end date (35 days from today)
for /f %%d in ('powershell -Command "(Get-Date).AddDays(35).ToString('yyyy-MM-ddTHH:mm:ssZ')"') do set ENDDATE=%%d

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "%DATE%" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "%ENDDATE%" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d "%DATE%" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "%ENDDATE%" /f >nul

echo Done. Windows Update paused for 35 days.
echo Remember to manually check for updates periodically.
pause
