@echo off
:: RemovePrintSpoolerJunk.bat - Clears stuck print jobs and resets spooler
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Stopping Print Spooler service...
net stop Spooler >nul 2>&1

echo Clearing print queue...
del /f /s /q "C:\Windows\System32\spool\PRINTERS\*.*" >nul 2>&1

echo Restarting Print Spooler service...
net start Spooler >nul 2>&1

echo Done. Print spooler has been reset. All stuck jobs cleared.
pause
