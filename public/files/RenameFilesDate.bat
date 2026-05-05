@echo off
:: RenameFilesDate.bat - Renames files with YYYY-MM-DD prefix
:: EDIT: Set your target folder below
set TARGET=%UserProfile%\Desktop\ToRename

echo Renaming files in %TARGET%...
powershell -Command ^
  "Get-ChildItem -Path '%TARGET%' -File | ForEach-Object { " ^
  "  $date = $_.LastWriteTime.ToString('yyyy-MM-dd'); " ^
  "  if (-not $_.Name.StartsWith($date)) { " ^
  "    Rename-Item $_.FullName -NewName ($date + '_' + $_.Name) " ^
  "  } " ^
  "}"

echo Done. Files renamed with date prefix.
pause
