@echo off
:: ============================================================
::  RAMCleaner.bat
::  Flushes standby memory when your PC feels slow
::  No restart needed — takes effect instantly
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   RAM Cleaner — Flushing Standby Memory
echo  =====================================================
echo.

:: Show RAM before
for /f "skip=1 tokens=*" %%a in ('wmic OS get FreePhysicalMemory') do (
    if not defined RAMBEFORE set "RAMBEFORE=%%a"
)
set /a RAMBEFORE_MB=%RAMBEFORE:~0,-3%
echo  RAM free before: %RAMBEFORE_MB% MB

echo  Flushing standby memory...
rundll32.exe advapi32.dll,ProcessIdleTasks

:: Also flush via PowerShell (more aggressive)
powershell -Command "& {
    Add-Type @'
    using System;
    using System.Runtime.InteropServices;
    public class Memory {
        [DllImport(\"kernel32.dll\")] public static extern bool SetSystemFileCacheSize(IntPtr min, IntPtr max, int flags);
        [DllImport(\"psapi.dll\")] public static extern bool EmptyWorkingSet(IntPtr hProcess);
    }
'@
    [Memory]::SetSystemFileCacheSize([IntPtr]::new(1), [IntPtr]::new(1), 0) | Out-Null
}" >nul 2>&1

:: Small wait
timeout /t 3 >nul

:: Show RAM after
for /f "skip=1 tokens=*" %%a in ('wmic OS get FreePhysicalMemory') do (
    if not defined RAMAFTER set "RAMAFTER=%%a"
)
set /a RAMAFTER_MB=%RAMAFTER:~0,-3%
set /a FREED=%RAMAFTER_MB%-%RAMBEFORE_MB%
echo  RAM free after:  %RAMAFTER_MB% MB
echo  Freed approximately: %FREED% MB

echo.
echo  =====================================================
echo   Done! Your PC should feel more responsive.
echo  =====================================================
echo.
pause
