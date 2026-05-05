@echo off
:: NetworkSpeedFix.bat - Resets network stack when internet feels slow
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo NetworkSpeedFix - Resetting Windows network stack
echo You will briefly lose internet connection during this reset.
echo.

echo Flushing DNS cache...
ipconfig /flushdns >nul

echo Resetting Winsock catalog...
netsh winsock reset >nul

echo Resetting TCP/IP stack...
netsh int ip reset >nul
netsh int ipv4 reset >nul
netsh int ipv6 reset >nul

echo Clearing ARP cache...
arp -d * >nul 2>&1

echo Releasing IP address...
ipconfig /release >nul 2>&1

echo Renewing IP address...
ipconfig /renew >nul 2>&1

echo Flushing DNS again after renewal...
ipconfig /flushdns >nul

echo.
echo Network stack reset complete.
echo If connection doesn't restore in 60 seconds, restart your PC.
echo.
echo Tip: If still slow, the issue may be with your router or ISP.
pause
