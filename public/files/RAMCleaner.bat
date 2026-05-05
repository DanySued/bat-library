@echo off
:: RAMCleaner.bat - Flushes standby memory to free up visible RAM
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo RAMCleaner - Flushing standby memory
echo.

:: Show RAM before
for /f "tokens=2" %%a in ('wmic OS get FreePhysicalMemory /value ^| findstr "="') do set BEFORE=%%a
set /a BEFORE_MB=%BEFORE%/1024
echo RAM free before: %BEFORE_MB% MB

:: Flush standby list via EmptyStandbyList.exe or PowerShell RAMMap alternative
powershell -Command ^
  "[System.GC]::Collect(); " ^
  "[System.GC]::WaitForPendingFinalizers(); " ^
  "$mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(1); " ^
  "[System.Runtime.InteropServices.Marshal]::FreeHGlobal($mem)" >nul 2>&1

:: Use RAMMap-equivalent: clear standby list via Windows API
powershell -Command ^
  "Add-Type -TypeDefinition @'" ^
  "using System; using System.Runtime.InteropServices;" ^
  "public class Mem { [DllImport(\"ntdll.dll\")] public static extern uint NtSetSystemInformation(int i, IntPtr p, int l); }" ^
  "'@; " ^
  "$p = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(4); " ^
  "[Mem]::NtSetSystemInformation(0x50, $p, 4); " ^
  "[System.Runtime.InteropServices.Marshal]::FreeHGlobal($p)" >nul 2>&1

timeout /t 2 /nobreak >nul

:: Show RAM after
for /f "tokens=2" %%a in ('wmic OS get FreePhysicalMemory /value ^| findstr "="') do set AFTER=%%a
set /a AFTER_MB=%AFTER%/1024
set /a FREED=%AFTER_MB%-%BEFORE_MB%

echo RAM free after:  %AFTER_MB% MB
echo Freed: %FREED% MB of standby memory
echo.
echo Done. RAM will gradually fill back up as you use programs.
pause
