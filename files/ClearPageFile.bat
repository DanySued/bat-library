@echo off
title Clear Page File on Shutdown
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Enabling page file clear on shutdown...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 1 /f >nul

echo.
echo Page file will be cleared on each shutdown.
echo Note: This will add a few seconds to shutdown time.
pause
