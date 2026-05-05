@echo off
title Clean Windows Update Cache
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Stopping Windows Update services...
net stop wuauserv >nul 2>&1
net stop cryptsvc >nul 2>&1
net stop bits >nul 2>&1

echo Deleting Windows Update download cache...
rd /s /q "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1
md "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1

echo Restarting Windows Update services...
net start wuauserv >nul 2>&1
net start cryptsvc >nul 2>&1
net start bits >nul 2>&1

echo.
echo Windows Update cache cleared. Disk space recovered. Updates will re-download as needed.
pause
