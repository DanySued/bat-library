@echo off
:: RemoveCortana.bat - Disables and removes Cortana
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Removing Cortana app package...
powershell -Command "Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.Cortana* | Remove-AppxPackage" >nul 2>&1

echo Disabling Cortana via registry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f >nul

echo Disabling Cortana from taskbar...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Done. Cortana has been disabled.
pause
