@echo off
:: DisableRemoteDesktop.bat - Disables RDP to improve security
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 1 /f >nul
sc config TermService start= disabled >nul 2>&1
sc stop TermService >nul 2>&1

netsh advfirewall firewall set rule name="Remote Desktop" new enable=No >nul 2>&1

echo Done. Remote Desktop Protocol has been disabled.
echo To re-enable: Settings > System > Remote Desktop > On
pause
