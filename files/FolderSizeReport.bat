@echo off
:: ============================================================
::  FolderSizeReport.bat
::  Shows which folders on your PC are eating the most space
::  Saves a report to your Desktop
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Folder Size Report
echo  =====================================================
echo.

set /p "FOLDER=Enter folder to scan (press Enter for C:\): "
if "%FOLDER%"=="" set "FOLDER=C:\"

set "REPORT=%USERPROFILE%\Desktop\FolderSizeReport.txt"

echo  Scanning %FOLDER% — this may take a few minutes...
echo.

echo Folder Size Report > "%REPORT%"
echo Scanned: %FOLDER% >> "%REPORT%"
echo Date: %DATE% %TIME% >> "%REPORT%"
echo ============================================== >> "%REPORT%"
echo. >> "%REPORT%"

powershell -Command "
$folder = '%FOLDER%'
$report = '%REPORT%'
$dirs = Get-ChildItem -Path $folder -Directory -ErrorAction SilentlyContinue
$results = foreach ($dir in $dirs) {
    $size = (Get-ChildItem -Path $dir.FullName -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    [PSCustomObject]@{ Path = $dir.FullName; SizeBytes = $size }
}
$sorted = $results | Sort-Object SizeBytes -Descending
foreach ($item in $sorted) {
    $gb = [math]::Round($item.SizeBytes / 1GB, 2)
    $mb = [math]::Round($item.SizeBytes / 1MB, 0)
    if ($gb -ge 1) {
        $line = '{0,8} GB  {1}' -f $gb, $item.Path
    } else {
        $line = '{0,8} MB  {1}' -f $mb, $item.Path
    }
    Write-Host $line
    Add-Content $report $line
}
"

echo.
echo  =====================================================
echo   Report saved to your Desktop:
echo   FolderSizeReport.txt
echo  =====================================================
echo.
pause
