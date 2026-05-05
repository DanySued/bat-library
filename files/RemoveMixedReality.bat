@echo off
title Remove Mixed Reality Portal
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Removing Mixed Reality Portal...
PowerShell -Command "Get-AppxPackage *MixedReality* | Remove-AppxPackage" >nul 2>&1
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*MixedReality*'} | Remove-AppxProvisionedPackage -Online" >nul 2>&1
PowerShell -Command "Get-AppxPackage *HolographicFirstRun* | Remove-AppxPackage" >nul 2>&1

echo Disabling Mixed Reality first-run setup...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Holographic" /v "FirstRunSucceeded" /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo Mixed Reality Portal removed.
pause
