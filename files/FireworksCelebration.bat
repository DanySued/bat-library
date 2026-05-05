@echo off
title Fireworks Celebration
color 0e
mode con: cols=100 lines=35

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$w = [Console]::WindowWidth - 1;" ^
  "$h = [Console]::WindowHeight - 1;" ^
  "$colors = @('Red','Yellow','Green','Cyan','Magenta','White','DarkYellow');" ^
  "function Draw-Firework($cx, $cy) {" ^
  "  $c = $colors | Get-Random;" ^
  "  $patterns = @('^','*','o','x','+');" ^
  "  for ($r = 1; $r -le 5; $r++) {" ^
  "    foreach ($a in 0,45,90,135,180,225,270,315) {" ^
  "      $rad = $a * [Math]::PI / 180;" ^
  "      $x = [int]($cx + $r * 2 * [Math]::Cos($rad));" ^
  "      $y = [int]($cy + $r * [Math]::Sin($rad));" ^
  "      if ($x -ge 0 -and $x -lt $w -and $y -ge 0 -and $y -lt $h) {" ^
  "        [Console]::SetCursorPosition($x, $y);" ^
  "        Write-Host ($patterns | Get-Random) -NoNewline -ForegroundColor $c" ^
  "      }" ^
  "    };" ^
  "    Start-Sleep -Milliseconds 60" ^
  "  }" ^
  "};" ^
  "while (-not [Console]::KeyAvailable) {" ^
  "  $cx = Get-Random -Min 10 -Max ($w - 10);" ^
  "  $cy = Get-Random -Min 3 -Max ($h - 3);" ^
  "  Draw-Firework $cx $cy;" ^
  "  Start-Sleep -Milliseconds 200;" ^
  "  [Console]::Clear()" ^
  "};" ^
  "[Console]::CursorVisible = $true"
