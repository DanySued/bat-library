@echo off
:: FolderSizeReport.bat - Shows which folders are using the most disk space
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

setlocal enabledelayedexpansion

set REPORT=%UserProfile%\Desktop\FolderSizeReport.txt

echo FolderSizeReport - Disk Space Analysis
echo.
set /p FOLDER=Enter path to scan (e.g. C:\ or C:\Users\YourName):
if not exist "%FOLDER%" (echo Path not found. && pause && exit /b)

echo.
echo Scanning %FOLDER% ... This may take a few minutes.

echo Folder Size Report - %date% > "%REPORT%"
echo Scanned: %FOLDER% >> "%REPORT%"
echo. >> "%REPORT%"
echo Size (MB)   Folder >> "%REPORT%"
echo ─────────────────────────────────────────────── >> "%REPORT%"

powershell -Command ^
  "Get-ChildItem '%FOLDER%' -Directory -ErrorAction SilentlyContinue | " ^
  "ForEach-Object { " ^
  "  $size = (Get-ChildItem $_.FullName -Recurse -File -ErrorAction SilentlyContinue | " ^
  "    Measure-Object -Property Length -Sum).Sum; " ^
  "  [PSCustomObject]@{Size=[math]::Round($size/1MB,1); Path=$_.FullName} " ^
  "} | Sort-Object -Property Size -Descending | " ^
  "Select-Object -First 20 | " ^
  "ForEach-Object { '{0,10} MB   {1}' -f $_.Size, $_.Path } | " ^
  "Tee-Object -FilePath '%REPORT%' -Append"

echo.
echo Report saved to Desktop\FolderSizeReport.txt
pause
