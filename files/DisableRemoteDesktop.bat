@echo off
title Disable Remote Desktop
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Disabling Remote Desktop...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 1 /f >nul

echo Disabling Remote Desktop services...
sc config TermService start= disabled >nul 2>&1
sc stop TermService >nul 2>&1

echo Blocking RDP via firewall...
netsh advfirewall firewall set rule group="Remote Desktop" new enable=no >nul 2>&1

echo.
echo Remote Desktop disabled and firewall rule blocked.
pause
