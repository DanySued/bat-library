@echo off
title Countdown Timer
mode con: cols=50 lines=10

set /p SECONDS=Enter countdown seconds (e.g. 60):
if "%SECONDS%"=="" set SECONDS=60

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$total = %SECONDS%;" ^
  "for ($s = $total; $s -ge 0; $s--) {" ^
  "  [Console]::SetCursorPosition(0, 1);" ^
  "  $ts = [TimeSpan]::FromSeconds($s);" ^
  "  $color = if ($s -le 10) { 'Red' } elseif ($s -le 30) { 'Yellow' } else { 'Cyan' };" ^
  "  Write-Host ('  ' + $ts.ToString('mm\:ss')) -ForegroundColor $color;" ^
  "  if ($s -gt 0) { Start-Sleep -Seconds 1 };" ^
  "  if ([Console]::KeyAvailable) { break }" ^
  "};" ^
  "[Console]::SetCursorPosition(0, 3);" ^
  "Write-Host '  Time is up!' -ForegroundColor Green;" ^
  "[System.Media.SystemSounds]::Beep.Play();" ^
  "Write-Host '  Press any key to exit.';" ^
  "$null = [Console]::ReadKey($true);" ^
  "[Console]::CursorVisible = $true"
