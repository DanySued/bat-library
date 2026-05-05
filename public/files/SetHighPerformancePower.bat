@echo off
:: SetHighPerformancePower.bat - Switches to High Performance power plan
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo High Performance power plan activated.
echo Note: Higher power usage. Not recommended for laptop battery use.
pause
