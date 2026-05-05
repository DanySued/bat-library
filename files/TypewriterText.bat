@echo off
title Typewriter Text
color 0f

PowerShell -NoProfile -Command ^
  "function Write-Typewriter($text, $delay=50) {" ^
  "  foreach ($c in $text.ToCharArray()) {" ^
  "    Write-Host $c -NoNewline;" ^
  "    Start-Sleep -Milliseconds $delay" ^
  "  };" ^
  "  Write-Host" ^
  "};" ^
  "Write-Typewriter '> Initializing terminal...' 60;" ^
  "Start-Sleep -Milliseconds 500;" ^
  "Write-Typewriter '> Loading bat-library tools...' 50;" ^
  "Start-Sleep -Milliseconds 400;" ^
  "Write-Typewriter '> All systems operational.' 70;" ^
  "Start-Sleep -Milliseconds 300;" ^
  "Write-Typewriter '';" ^
  "Write-Typewriter 'Welcome to bat-library.' 80;" ^
  "Write-Typewriter 'The fastest way to configure Windows.' 60;" ^
  "Write-Typewriter '';" ^
  "Write-Typewriter 'Press any key to exit...' 40;" ^
  "$null = [Console]::ReadKey($true)"
