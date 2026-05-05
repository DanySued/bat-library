@echo off
title Remove Print Spooler Junk
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Stopping Print Spooler...
net stop Spooler >nul 2>&1

echo Clearing print queue and spool files...
del /Q /F /S "%SystemRoot%\System32\spool\PRINTERS\*.*" >nul 2>&1

echo Restarting Print Spooler...
net start Spooler >nul 2>&1

echo.
echo Print spooler queue cleared.
pause
