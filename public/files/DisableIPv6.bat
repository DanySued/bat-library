@echo off
:: DisableIPv6.bat - Disables IPv6 on all network adapters
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 0xff /f >nul

echo Done. IPv6 disabled on all network adapters.
echo Reboot for changes to take full effect.
echo Re-enable by setting DisabledComponents to 0 in the registry.
pause
