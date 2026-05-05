@echo off
:: SortPhotosByDate.bat - Organizes photos into YYYY\MM subfolders
:: EDIT: Set source folder below
set SOURCE=%UserProfile%\Pictures

echo Organizing photos in %SOURCE% into Year\Month folders...
powershell -Command ^
  "Get-ChildItem -Path '%SOURCE%' -Recurse -Include *.jpg,*.jpeg,*.png,*.heic | " ^
  "ForEach-Object { " ^
  "  try { $date = $_.LastWriteTime } catch { $date = $_.CreationTime }; " ^
  "  $dest = Join-Path '%SOURCE%' ($date.Year.ToString() + '\' + $date.Month.ToString('00')); " ^
  "  if (-not (Test-Path $dest)) { New-Item $dest -ItemType Directory | Out-Null }; " ^
  "  if ($_.DirectoryName -ne $dest) { Move-Item $_.FullName -Destination $dest -Force } " ^
  "}"

echo Done. Photos organized by date.
pause
