@echo off
title Rename Files with Date Prefix

echo This will rename all files in a folder by adding YYYYMMDD_ prefix.
echo.
set /p TARGET=Enter folder path (or press Enter for Desktop):
if "%TARGET%"=="" set TARGET=%USERPROFILE%\Desktop

if not exist "%TARGET%" (
    echo Folder not found: %TARGET%
    pause
    exit /b 1
)

echo Renaming files in %TARGET%...
for %%F in ("%TARGET%\*.*") do (
    set "FNAME=%%~nxF"
    PowerShell -Command "$f='%%F'; $d=(Get-Item $f).LastWriteTime.ToString('yyyyMMdd'); $dir=[System.IO.Path]::GetDirectoryName($f); $name=[System.IO.Path]::GetFileName($f); if (-not $name.StartsWith($d)) { Rename-Item $f (Join-Path $dir ($d + '_' + $name)) -ErrorAction SilentlyContinue }"
)

echo.
echo Files renamed with date prefix.
pause
