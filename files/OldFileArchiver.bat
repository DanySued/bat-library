@echo off
:: ============================================================
::  OldFileArchiver.bat
::  Moves files older than X days from a folder
::  to an archive folder automatically
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Old File Archiver
echo  =====================================================
echo.

set /p "SOURCE=Folder to archive from (e.g. C:\Users\Me\Downloads): "
if "%SOURCE%"=="" ( echo No path entered. & pause & exit /b )
if not exist "%SOURCE%" ( echo Folder not found. & pause & exit /b )

set /p "DEST=Archive destination folder (e.g. D:\Archive): "
if "%DEST%"=="" ( echo No path entered. & pause & exit /b )

set /p "DAYS=Move files older than how many days? (e.g. 30): "
if "%DAYS%"=="" set "DAYS=30"

md "%DEST%" >nul 2>&1

echo.
echo  Moving files older than %DAYS% days...
echo  From: %SOURCE%
echo  To:   %DEST%
echo.

set COUNT=0
powershell -Command "
$source = '%SOURCE%'
$dest = '%DEST%'
$days = %DAYS%
$cutoff = (Get-Date).AddDays(-$days)
$files = Get-ChildItem -Path $source -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt $cutoff }
foreach ($file in $files) {
    $destPath = Join-Path $dest $file.Name
    Move-Item -Path $file.FullName -Destination $destPath -Force -ErrorAction SilentlyContinue
    Write-Host ('  Moved: ' + $file.Name)
}
Write-Host ''
Write-Host ('  Total files moved: ' + $files.Count)
"

echo.
echo  =====================================================
echo   Archiving complete!
echo  =====================================================
echo.
pause
