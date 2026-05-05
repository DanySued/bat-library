@echo off
title Disable Search Indexing
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Disabling Windows Search indexing service...
sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1

echo.
echo Search indexing disabled. Reduces disk activity and CPU usage.
echo Note: Windows search will still work but may be slower for first searches.
pause
