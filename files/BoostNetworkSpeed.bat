@echo off
title Boost Network Speed
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Optimizing network settings...

echo Disabling auto-tuning level (can improve performance on some networks)...
netsh int tcp set global autotuninglevel=normal >nul 2>&1

echo Enabling receive-side scaling...
netsh int tcp set global rss=enabled >nul 2>&1

echo Enabling TCP chimney offload...
netsh int tcp set global chimney=enabled >nul 2>&1

echo Flushing DNS cache...
ipconfig /flushdns >nul 2>&1

echo Resetting Winsock...
netsh winsock reset >nul 2>&1

echo Setting DNS to Cloudflare (1.1.1.1) for faster resolution...
PowerShell -Command "$adapters = Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}; foreach ($a in $adapters) { Set-DnsClientServerAddress -InterfaceIndex $a.InterfaceIndex -ServerAddresses ('1.1.1.1','8.8.8.8') }" >nul 2>&1

echo.
echo Network optimizations applied. A restart may be required.
pause
