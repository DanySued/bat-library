@echo off
:: DisableWindowsDefenderRealtime.bat - Temporarily pauses Defender real-time protection
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo WARNING: Real-time protection will be paused for 15 minutes.
echo Your PC is less protected during this time.
echo.
set /p confirm="Continue? (Y/N): "
if /i not "%confirm%"=="Y" goto :cancel

powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
echo Real-time protection PAUSED.

:: Schedule re-enable after 15 minutes
schtasks /Create /SC ONCE /TN "ReenableDefender" /TR "powershell -Command Set-MpPreference -DisableRealtimeMonitoring $false" /ST %time:~0,2%:%time:~3,2% /F >nul 2>&1
powershell -Command "$trigger = New-ScheduledTaskTrigger -Once -At ((Get-Date).AddMinutes(15)); $action = New-ScheduledTaskAction -Execute 'powershell' -Argument '-Command Set-MpPreference -DisableRealtimeMonitoring $false'; Register-ScheduledTask -TaskName 'ReenableDefender' -Trigger $trigger -Action $action -Force -RunLevel Highest" >nul 2>&1

echo Protection will auto-restore in 15 minutes.
goto :end

:cancel
echo Cancelled.

:end
pause
