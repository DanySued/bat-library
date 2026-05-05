@echo off
:: PinFolderToQuickAccess.bat - Pins folders to Explorer Quick Access
:: EDIT: Add or remove folders from the list below

set FOLDERS[0]=%UserProfile%\Documents
set FOLDERS[1]=%UserProfile%\Downloads
set FOLDERS[2]=%UserProfile%\Desktop
set FOLDERS[3]=C:\Dev

powershell -Command ^
  "$folders = @('%UserProfile%\Documents','%UserProfile%\Downloads','%UserProfile%\Desktop','C:\Dev'); " ^
  "$shell = New-Object -ComObject shell.application; " ^
  "foreach ($f in $folders) { " ^
  "  if (Test-Path $f) { $shell.Namespace($f).Self.InvokeVerb('pintohome'); Write-Host 'Pinned: '$f } " ^
  "}"

echo Done. Folders pinned to Quick Access.
pause
