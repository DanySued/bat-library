@echo off
:: ClearPageFile.bat - Clears page file at shutdown for privacy
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 1 /f >nul

echo Done. Page file will be cleared on each shutdown.
echo Note: Shutdown will take 30-60 seconds longer.
pause
