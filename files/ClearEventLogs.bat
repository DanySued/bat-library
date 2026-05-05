@echo off
title Clear Event Logs
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Clearing Windows event logs...
for /F "tokens=*" %%G in ('wevtutil.exe el') do (
    wevtutil.exe cl "%%G" >nul 2>&1
)

echo.
echo All event logs cleared.
pause
