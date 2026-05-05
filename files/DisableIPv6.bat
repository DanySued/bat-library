@echo off
title Disable IPv6
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Disabling IPv6 on all network adapters...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 255 /f >nul

PowerShell -Command "Get-NetAdapterBinding -ComponentID ms_tcpip6 | Disable-NetAdapterBinding" >nul 2>&1

echo.
echo IPv6 disabled. A restart is required for changes to take full effect.
pause
