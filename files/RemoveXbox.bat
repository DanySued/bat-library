@echo off
title Remove Xbox App
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Removing Xbox apps...
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Xbox* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage Microsoft.GamingApp | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage Microsoft.XboxGameOverlay | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage -ErrorAction SilentlyContinue"

echo Disabling Xbox services...
sc config XblAuthManager start= disabled >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1
sc stop XblAuthManager >nul 2>&1
sc stop XblGameSave >nul 2>&1

echo Disabling Xbox Game Bar...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul

echo.
echo Xbox app and services removed. Reinstall from Microsoft Store if needed.
pause
