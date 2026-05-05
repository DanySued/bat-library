@echo off
:: BoostNetworkSpeed.bat - Optimizes TCP/IP settings for better performance
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Enabling TCP autotuning...
netsh int tcp set global autotuninglevel=normal >nul 2>&1

echo Disabling Windows network throttling...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 0xffffffff /f >nul

echo Optimizing DNS cache...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d 384 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit" /t REG_DWORD /d 0x1fa400 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxSOACacheEntryTtlLimit" /t REG_DWORD /d 0x12c /f >nul

echo Resetting Winsock...
netsh winsock reset >nul 2>&1

echo Done. Network speed optimizations applied.
echo A reboot is recommended for full effect.
pause
