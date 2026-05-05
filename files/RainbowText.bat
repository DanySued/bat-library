@echo off
title Rainbow Text
mode con: cols=80 lines=25

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$colors = @('Red','Yellow','Green','Cyan','Blue','Magenta','White');" ^
  "$text = 'Hello from bat-library! Press any key to exit.';" ^
  "while (-not [Console]::KeyAvailable) {" ^
  "  [Console]::SetCursorPosition(0,0);" ^
  "  $offset = [int]((Get-Date).Millisecond / 100) %% $colors.Length;" ^
  "  for ($i = 0; $i -lt $text.Length; $i++) {" ^
  "    $ci = ($i + $offset) %% $colors.Length;" ^
  "    Write-Host $text[$i] -NoNewline -ForegroundColor $colors[$ci]" ^
  "  };" ^
  "  Start-Sleep -Milliseconds 80" ^
  "};" ^
  "[Console]::CursorVisible = $true"
