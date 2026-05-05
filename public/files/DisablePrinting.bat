@echo off
:: DisablePrinting.bat - Disables Print Spooler for printer-free PCs
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

sc stop Spooler >nul 2>&1
sc config Spooler start= disabled >nul 2>&1

echo Done. Print Spooler disabled.
echo Printing will not work until re-enabled via: sc config Spooler start= auto
pause
