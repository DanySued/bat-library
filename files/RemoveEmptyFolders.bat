@echo off
title Remove Empty Folders

set /p TARGET=Enter folder to clean (or Enter for Documents):
if "%TARGET%"=="" set TARGET=%USERPROFILE%\Documents

echo Removing empty folders in %TARGET%...

PowerShell -Command ^
  "Get-ChildItem -Path '%TARGET%' -Recurse -Force -Directory | " ^
  "Where-Object { (Get-ChildItem $_.FullName -Force | Measure-Object).Count -eq 0 } | " ^
  "Sort-Object FullName -Descending | " ^
  "ForEach-Object { Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue; Write-Host 'Removed:' $_.FullName }"

echo.
echo Empty folders removed.
pause
