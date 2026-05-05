@echo off
:: TransparentTaskbar.bat - Makes the taskbar transparent
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLEDTaskbarTransparency" /t REG_DWORD /d 1 /f >nul

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Taskbar transparency enabled.
echo Tip: Use TranslucentTB from the Store for full control.
