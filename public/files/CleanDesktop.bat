@echo off
:: CleanDesktop.bat - Moves all Desktop files into a timestamped folder

for /f "tokens=2-4 delims=/ " %%a in ('date /t') do set TODAY=%%c-%%a-%%b
set FOLDER=%UserProfile%\Desktop\Desktop_%TODAY%

mkdir "%FOLDER%" >nul 2>&1

echo Moving Desktop files to %FOLDER%...
powershell -Command ^
  "Get-ChildItem -Path '%UserProfile%\Desktop' -File | " ^
  "Where-Object { $_.Name -notmatch '\.lnk$' } | " ^
  "Move-Item -Destination '%FOLDER%'"

echo Done. Desktop cleared. Files are in Desktop\Desktop_%TODAY%
