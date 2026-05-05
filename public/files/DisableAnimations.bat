@echo off
:: DisableAnimations.bat - Turns off Windows UI animations
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9012038010000000 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d 0 /f >nul

powershell -Command "SystemParametersInfo([System.Windows.Forms.SystemParametersInfoAction]::SetMinimize, 0, $false, 'SPIF_UPDATEINIFILE')" >nul 2>&1

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Done. Windows animations have been disabled.
