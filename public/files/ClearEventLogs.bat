@echo off
:: ClearEventLogs.bat - Clears all Windows Event Viewer logs
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Clearing all Windows Event logs...
for /f %%x in ('wevtutil el') do (
    wevtutil cl "%%x" >nul 2>&1
)
echo Done. All event logs have been cleared.
pause
