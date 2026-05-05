@echo off
:: EnableUltimatePerformance.bat - Unlocks and enables Ultimate Performance power plan
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Unlocking Ultimate Performance power plan...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

echo Activating Ultimate Performance...
for /f "tokens=4" %%i in ('powercfg /list ^| findstr "Ultimate"') do (
    powercfg /setactive %%i
    echo Activated: %%i
)

echo Done. Ultimate Performance plan is now active.
echo Warning: High power usage and heat. Not for laptops on battery.
pause
