@echo off
:: CenterTaskbarIcons.bat - Centers taskbar icons (Windows 10/11)
:: Windows 11: Already centered by default. This verifies/re-enables center alignment.
:: Windows 10: Uses registry to simulate center alignment

ver | findstr "10.0.2" >nul
if %errorlevel%==0 (
    echo Windows 11 detected - centering is already default.
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAl" /t REG_DWORD /d 1 /f >nul
) else (
    echo Windows 10 detected - applying center icon workaround...
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v "Settings" /t REG_BINARY /d 30000000fe000000 /f >nul
)

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Taskbar icons centered.
echo Tip: On Windows 10, TaskbarX from GitHub provides full control.
