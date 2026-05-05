@echo off
:: ChangeAccentColor.bat - Sets a custom Windows accent color
:: EDIT: Set your color in ABGR hex format (NOT RGB)
:: Example: Pure blue = 00FF0000, Purple = 00800080, Red = 000000FF
set COLOR=00BD5900

reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AccentColor" /t REG_DWORD /d 0x%COLOR% /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d 0xC4%COLOR% /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d 0xC4%COLOR% /f >nul

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Accent color changed. Edit this script to use your own hex color.
