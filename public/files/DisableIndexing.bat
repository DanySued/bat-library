@echo off
:: DisableIndexing.bat - Turns off Windows Search indexing
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1

echo Done. Windows Search indexing has been disabled.
echo Search still works - just a few seconds slower without the index.
pause
