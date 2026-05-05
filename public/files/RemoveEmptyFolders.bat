@echo off
:: RemoveEmptyFolders.bat - Recursively deletes all empty folders
:: EDIT: Set the target folder below
set TARGET=%UserProfile%\Documents

echo Removing empty folders in %TARGET%...
powershell -Command ^
  "do { " ^
  "  $empty = Get-ChildItem -Path '%TARGET%' -Recurse -Directory | " ^
  "    Where-Object { (Get-ChildItem $_.FullName -Recurse -Force | Measure-Object).Count -eq 0 }; " ^
  "  $empty | Remove-Item -Force; " ^
  "} while ($empty.Count -gt 0)"

echo Done. Empty folders removed.
pause
