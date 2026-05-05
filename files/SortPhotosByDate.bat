@echo off
title Sort Photos by Date

set /p SOURCE=Enter photos folder (or Enter for Pictures):
if "%SOURCE%"=="" set SOURCE=%USERPROFILE%\Pictures

echo Sorting photos by year/month into subfolders...
echo Source: %SOURCE%

PowerShell -Command ^
  "$src = '%SOURCE%'; " ^
  "Get-ChildItem $src -Include *.jpg,*.jpeg,*.png,*.gif,*.bmp,*.heic,*.raw,*.cr2 -Recurse | ForEach-Object { " ^
  "  $d = $_.LastWriteTime; " ^
  "  $dest = Join-Path $src ($d.ToString('yyyy') + '\' + $d.ToString('yyyy-MM')); " ^
  "  if (-not (Test-Path $dest)) { New-Item $dest -ItemType Directory | Out-Null }; " ^
  "  if ($_.DirectoryName -ne $dest) { Move-Item $_.FullName $dest -ErrorAction SilentlyContinue } " ^
  "}"

echo.
echo Photos sorted by year and month.
pause
