@echo off
title Disable Automatic Windows Updates
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Disabling Windows Update automatic download and install...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul

echo Disabling Windows Update service...
sc config wuauserv start= disabled >nul 2>&1
sc stop wuauserv >nul 2>&1

echo Disabling Update Orchestrator scheduled tasks...
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable >nul 2>&1

echo.
echo Automatic updates disabled. Run Windows Update manually to install updates.
pause
