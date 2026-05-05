@echo off
:: FindLargeFiles.bat - Scans C: for files over 500MB
set OUT=%UserProfile%\Desktop\LargeFiles.txt
set MINSIZE=524288000

echo Scanning for files over 500 MB. This may take a few minutes...

powershell -Command ^
  "Get-ChildItem -Path 'C:\' -Recurse -ErrorAction SilentlyContinue | " ^
  "Where-Object { !$_.PSIsContainer -and $_.Length -gt %MINSIZE% } | " ^
  "Sort-Object Length -Descending | " ^
  "Select-Object @{N='Size (MB)';E={[math]::Round($_.Length/1MB,1)}}, FullName | " ^
  "Format-Table -AutoSize | Out-File -FilePath '%OUT%'"

echo Done. Results saved to Desktop\LargeFiles.txt
start notepad "%OUT%"
