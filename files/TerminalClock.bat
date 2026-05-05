@echo off
title Terminal Clock
mode con: cols=50 lines=10

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "while (-not [Console]::KeyAvailable) {" ^
  "  [Console]::SetCursorPosition(0, 2);" ^
  "  $t = Get-Date;" ^
  "  $time = $t.ToString('HH:mm:ss');" ^
  "  $date = $t.ToString('dddd, MMMM dd yyyy');" ^
  "  Write-Host ('  ' + $date) -ForegroundColor DarkGray;" ^
  "  Write-Host;" ^
  "  Write-Host ('  ' + $time) -ForegroundColor Cyan;" ^
  "  Start-Sleep -Milliseconds 500" ^
  "};" ^
  "[Console]::CursorVisible = $true"
