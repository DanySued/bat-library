@echo off
title Remove Feedback Hub
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Removing Feedback Hub...
PowerShell -Command "Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*WindowsFeedbackHub*'} | Remove-AppxProvisionedPackage -Online" >nul 2>&1

echo Disabling feedback notifications...
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul

echo.
echo Feedback Hub removed.
pause
