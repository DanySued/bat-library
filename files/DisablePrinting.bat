@echo off
title Disable Print Spooler Service
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Disabling Print Spooler service...
sc stop Spooler >nul 2>&1
sc config Spooler start= disabled >nul 2>&1

echo.
echo Print Spooler disabled. No printing will be available.
echo To re-enable: sc config Spooler start= auto ^&^& sc start Spooler
pause
