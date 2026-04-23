@echo off
:: ============================================================
::  DuplicateFileFinder.bat
::  Scans a folder and saves a report of duplicate files
::  (files with identical names and sizes)
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Duplicate File Finder
echo  =====================================================
echo.

set /p "FOLDER=Enter folder to scan (e.g. C:\Users\Me\Pictures): "
if "%FOLDER%"=="" ( echo No path entered. & pause & exit /b )
if not exist "%FOLDER%" ( echo Folder not found. & pause & exit /b )

set "REPORT=%USERPROFILE%\Desktop\DuplicatesReport.txt"
echo Duplicate File Report > "%REPORT%"
echo Scanned: %FOLDER% >> "%REPORT%"
echo Date: %DATE% %TIME% >> "%REPORT%"
echo ============================================== >> "%REPORT%"
echo. >> "%REPORT%"

echo  Scanning... this may take a while for large folders.
echo.

powershell -Command "
$folder = '%FOLDER%'
$report = '%REPORT%'
$files = Get-ChildItem -Path $folder -Recurse -File -ErrorAction SilentlyContinue
$groups = $files | Group-Object -Property { $_.Name + '|' + $_.Length } | Where-Object { $_.Count -gt 1 }
$total = 0
foreach ($group in $groups) {
    Add-Content $report '--- DUPLICATE GROUP ---'
    foreach ($file in $group.Group) {
        Add-Content $report $file.FullName
        $total++
    }
    Add-Content $report ''
}
Add-Content $report ''
Add-Content $report \"Total duplicate files found: $total\"
Write-Host \"  Found $total duplicate files. Report saved to Desktop.\"
"

echo.
echo  =====================================================
echo   Scan complete!
echo   Report saved to your Desktop:
echo   DuplicatesReport.txt
echo.
echo   Review the report and manually delete the
echo   duplicates you don't need.
echo  =====================================================
echo.
pause
