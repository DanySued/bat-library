@echo off
:: RemoveXbox.bat - Removes Xbox app, Game Bar, and related services
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Removing Xbox apps...
powershell -Command "Get-AppxPackage *Xbox* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *XboxApp* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.XboxGameOverlay | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.GamingApp | Remove-AppxPackage" >nul 2>&1

echo Disabling Xbox services...
sc config XblAuthManager start= disabled >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1
sc stop XblAuthManager >nul 2>&1
sc stop XblGameSave >nul 2>&1

echo Disabling Xbox Game Bar via registry...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul

echo Done. Xbox apps and Game Bar have been removed.
pause
