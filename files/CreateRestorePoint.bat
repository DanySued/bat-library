@echo off
:: ============================================================
::  CreateRestorePoint.bat
::  Creates a Windows System Restore Point instantly
::  Run before installing software, drivers, or making changes
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Creating System Restore Point
echo  =====================================================
echo.

:: Make sure System Restore is enabled on C:
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /t REG_DWORD /d 1 /f >nul 2>&1
vssadmin list shadows >nul 2>&1

:: Enable System Restore on C: drive
powershell -Command "Enable-ComputerRestore -Drive 'C:\'" >nul 2>&1

:: Set restore point frequency to allow multiple per day
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul

:: Create the restore point with today's date and time in the name
for /f "tokens=2 delims==" %%a in ('wmic OS get LocalDateTime /value') do set "dt=%%a"
set "LABEL=ManualBackup_%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%-%dt:~10,2%"

echo  Creating restore point: %LABEL%
powershell -Command "Checkpoint-Computer -Description '%LABEL%' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo.
    echo  =====================================================
    echo   Restore point created successfully!
    echo   Name: %LABEL%
    echo.
    echo   To restore: Search for "Recovery" in Start Menu
    echo   then click "Open System Restore"
    echo  =====================================================
) else (
    echo.
    echo  [WARNING] Restore point may have failed.
    echo  Go to: Control Panel - Recovery - System Restore
    echo  to check or create one manually.
)
echo.
pause
