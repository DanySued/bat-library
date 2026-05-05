@echo off
:: DuplicateFileFinder.bat - Finds duplicate files using MD5 hash comparison
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

setlocal enabledelayedexpansion

echo DuplicateFileFinder - Scan for duplicate files
echo.
set /p FOLDER=Enter folder to scan:
if not exist "%FOLDER%" (echo Folder not found. && pause && exit /b)

set REPORT=%UserProfile%\Desktop\DuplicateReport.txt
set TMPFILE=%TEMP%\dup_hashes.tmp

echo Scanning... This may take several minutes for large folders.
echo Results will be saved to: %REPORT%
echo.

echo DuplicateFileFinder Report > "%REPORT%"
echo Folder: %FOLDER% >> "%REPORT%"
echo Date: %date% %time% >> "%REPORT%"
echo. >> "%REPORT%"

if exist "%TMPFILE%" del "%TMPFILE%"

:: Hash all files
for /r "%FOLDER%" %%f in (*.*) do (
    for /f "skip=1 tokens=* delims=" %%h in ('CertUtil -hashfile "%%f" MD5 2^>nul') do (
        set "HASH=%%h"
        set "HASH=!HASH: =!"
        echo !HASH! "%%f" >> "%TMPFILE%"
        goto :nextfile
    )
    :nextfile
)

:: Find duplicates by sorting and comparing adjacent hashes
set DUPECOUNT=0
set PREVHASH=

powershell -Command ^
  "$lines = Get-Content '%TMPFILE%' | Sort-Object; " ^
  "$groups = $lines | Group-Object { $_.Split(' ')[0] } | Where-Object { $_.Count -gt 1 }; " ^
  "$total = 0; " ^
  "foreach ($g in $groups) { " ^
  "  Add-Content '%REPORT%' 'DUPLICATE GROUP:'; " ^
  "  $g.Group | ForEach-Object { Add-Content '%REPORT%' \"  $_\" }; " ^
  "  $total += $g.Count - 1; " ^
  "  Add-Content '%REPORT%' '' " ^
  "}; " ^
  "Add-Content '%REPORT%' \"Total duplicate files: $total\"; " ^
  "Write-Host \"Found $total duplicate files.\""

del "%TMPFILE%" >nul 2>&1

echo.
echo Report saved to: %REPORT%
echo No files were deleted - review the report manually.
pause
