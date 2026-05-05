@echo off
:: CreateRestorePoint.bat - Creates a Windows System Restore Point
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Creating System Restore Point...

:: Enable System Restore if disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableConfig" /t REG_DWORD /d 0 /f >nul 2>&1

:: Enable System Restore on C: drive
vssadmin resize shadowstorage /for=C: /on=C: /maxsize=10% >nul 2>&1

powershell -Command "Enable-ComputerRestore -Drive 'C:\'" >nul 2>&1

for /f "tokens=1-4 delims=/ " %%a in ("%date%") do set TODAY=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ("%time%") do set NOW=%TODAY%_%%a%%b

powershell -Command "Checkpoint-Computer -Description 'Manual Backup %NOW%' -RestorePointType 'MODIFY_SETTINGS'"

if %errorlevel%==0 (
    echo.
    echo Restore point created successfully: Manual Backup %NOW%
    echo To restore: Control Panel ^> Recovery ^> Open System Restore
) else (
    echo.
    echo Failed to create restore point. System Restore may be disabled on this PC.
    echo Enable it via: Control Panel ^> System ^> System Protection
)
pause
