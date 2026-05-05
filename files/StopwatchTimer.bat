@echo off
title Stopwatch
mode con: cols=50 lines=10

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "Write-Host '  STOPWATCH' -ForegroundColor Yellow;" ^
  "Write-Host '  Press any key to stop.' -ForegroundColor DarkGray;" ^
  "Write-Host;" ^
  "$start = Get-Date;" ^
  "while (-not [Console]::KeyAvailable) {" ^
  "  $elapsed = (Get-Date) - $start;" ^
  "  [Console]::SetCursorPosition(0, 3);" ^
  "  Write-Host ('  ' + $elapsed.ToString('hh\:mm\:ss\.ff')) -ForegroundColor Cyan;" ^
  "  Start-Sleep -Milliseconds 50" ^
  "};" ^
  "$null = [Console]::ReadKey($true);" ^
  "$final = (Get-Date) - $start;" ^
  "[Console]::SetCursorPosition(0, 5);" ^
  "Write-Host ('  Final: ' + $final.ToString('hh\:mm\:ss\.ff')) -ForegroundColor Green;" ^
  "Write-Host '  Press any key to exit.';" ^
  "$null = [Console]::ReadKey($true);" ^
  "[Console]::CursorVisible = $true"
