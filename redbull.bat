@echo off
title Disable Sleep Mode
echo Disabling sleep and hibernation settings...
:: Disable sleep on battery
powercfg /change standby-timeout-dc 0
:: Disable sleep while plugged in
powercfg /change standby-timeout-ac 0
:: Disable monitor timeout on battery
powercfg /change monitor-timeout-dc 0
:: Disable monitor timeout while plugged in
powercfg /change monitor-timeout-ac 0
:: Disable hibernation completely
powercfg /hibernate off
echo.
echo Sleep, monitor timeout, and hibernation have been disabled.
echo.
pause
