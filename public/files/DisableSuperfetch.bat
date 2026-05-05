@echo off
:: DisableSuperfetch.bat - Disables SysMain (Superfetch) service
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

sc stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1

echo Done. SysMain (Superfetch) has been disabled.
echo Recommended for SSD systems. Re-enable via Services.msc if needed.
pause
