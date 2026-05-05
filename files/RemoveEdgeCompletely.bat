@echo off
title Remove Edge (Disable)
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Disabling Microsoft Edge startup and background processes...

rem Remove Edge from startup
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1

rem Disable Edge background running
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

rem Disable Edge from opening PDFs
reg add "HKCR\.pdf" /v "" /t REG_SZ /d "Acrobat.Document.DC" /f >nul 2>&1

rem Kill Edge processes
taskkill /f /im msedge.exe >nul 2>&1

echo Removing Edge from startup tasks...
schtasks /Change /TN "MicrosoftEdgeUpdateTaskMachineCore" /Disable >nul 2>&1
schtasks /Change /TN "MicrosoftEdgeUpdateTaskMachineUA" /Disable >nul 2>&1

echo.
echo Edge disabled. Note: full uninstall is blocked by Microsoft on Windows 11.
echo For complete removal, use a third-party tool like Edge Blocker.
pause
