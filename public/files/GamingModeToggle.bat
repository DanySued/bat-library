@echo off
:: GamingModeToggle.bat - Kills background services for max gaming performance (toggle)
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

:: Check if gaming mode is currently ON (marker file)
if exist "%TEMP%\GamingModeActive.flag" goto RESTORE

:ENABLE
echo Enabling Gaming Mode...
echo (Run this script again when done gaming to restore normal mode)
echo.

echo > "%TEMP%\GamingModeActive.flag"

echo Stopping background services...
net stop WSearch >nul 2>&1
net stop SysMain >nul 2>&1
net stop BITS >nul 2>&1
net stop wuauserv >nul 2>&1
net stop DiagTrack >nul 2>&1

echo Closing background apps...
taskkill /f /im OneDrive.exe >nul 2>&1
taskkill /f /im Teams.exe >nul 2>&1
taskkill /f /im slack.exe >nul 2>&1
taskkill /f /im discord.exe >nul 2>&1
taskkill /f /im DiscordUpdate.exe >nul 2>&1
taskkill /f /im skype.exe >nul 2>&1

echo Switching to High Performance power plan...
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1

echo Disabling Xbox Game Bar and background recording...
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul

echo.
echo GAMING MODE ACTIVE. Background services stopped.
echo Launch your game now!
echo Run this script again when done to restore normal mode.
pause
exit /b

:RESTORE
echo Restoring Normal Mode...
del "%TEMP%\GamingModeActive.flag" >nul 2>&1

echo Restarting services...
net start WSearch >nul 2>&1
net start SysMain >nul 2>&1
net start BITS >nul 2>&1
net start wuauserv >nul 2>&1

echo Switching back to Balanced power plan...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1

echo.
echo Normal mode restored. All services back online.
pause
