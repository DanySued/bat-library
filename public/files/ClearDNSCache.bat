@echo off
:: ClearDNSCache.bat - Flushes the Windows DNS resolver cache
ipconfig /flushdns
echo DNS cache flushed successfully.
pause
