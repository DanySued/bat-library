@echo off
title Disable Superfetch (SysMain)
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Disabling SysMain (Superfetch)...
sc stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1

echo.
echo SysMain (Superfetch) disabled. Recommended for SSDs.
pause
