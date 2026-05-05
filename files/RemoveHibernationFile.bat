@echo off
title Remove Hibernation File
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Disabling hibernation and deleting hiberfil.sys...
powercfg /h off

echo.
echo Hibernation disabled. hiberfil.sys deleted automatically by Windows.
echo Disk space equal to ~75%% of your RAM has been freed.
echo Sleep mode (RAM-based) still works normally.
pause
