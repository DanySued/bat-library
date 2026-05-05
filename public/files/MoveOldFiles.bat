@echo off
:: MoveOldFiles.bat - Moves files older than 90 days to Archive subfolder
:: EDIT: Change the TARGET folder below
set TARGET=%UserProfile%\Documents
set DAYS=90
set ARCHIVE=%TARGET%\Archive

mkdir "%ARCHIVE%" >nul 2>&1

echo Moving files older than %DAYS% days to %ARCHIVE%...
powershell -Command ^
  "$cutoff = (Get-Date).AddDays(-%DAYS%); " ^
  "Get-ChildItem -Path '%TARGET%' -File | " ^
  "Where-Object { $_.LastWriteTime -lt $cutoff } | " ^
  "ForEach-Object { Move-Item $_.FullName -Destination '%ARCHIVE%' -Force }"

echo Done. Old files moved to Archive subfolder.
pause
