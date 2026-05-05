@echo off
title Bouncing Ball
mode con: cols=80 lines=25

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$w = [Console]::WindowWidth - 2;" ^
  "$h = [Console]::WindowHeight - 2;" ^
  "$x = 20; $y = 10; $dx = 1; $dy = 1;" ^
  "$prevX = $x; $prevY = $y;" ^
  "while (-not [Console]::KeyAvailable) {" ^
  "  [Console]::SetCursorPosition($prevX, $prevY);" ^
  "  Write-Host ' ' -NoNewline;" ^
  "  $prevX = $x; $prevY = $y;" ^
  "  [Console]::SetCursorPosition($x, $y);" ^
  "  Write-Host 'O' -NoNewline -ForegroundColor Cyan;" ^
  "  $x += $dx; $y += $dy;" ^
  "  if ($x -ge $w -or $x -le 0) { $dx = -$dx };" ^
  "  if ($y -ge $h -or $y -le 0) { $dy = -$dy };" ^
  "  Start-Sleep -Milliseconds 30" ^
  "};" ^
  "[Console]::Clear();" ^
  "[Console]::CursorVisible = $true"
