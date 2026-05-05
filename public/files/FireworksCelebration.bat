@echo off
:: FireworksCelebration.bat - ASCII fireworks animation
powershell -Command ^
  "$colors = 'Red','Yellow','Green','Cyan','Magenta','White'; " ^
  "$shapes = @('  *  ','** * **','* *** *','** * **','  *  '); " ^
  "for ($f=0; $f -lt 8; $f++) { " ^
  "  $color = $colors[(Get-Random -Max $colors.Count)]; " ^
  "  Write-Host '`n' -NoNewline; " ^
  "  foreach ($line in $shapes) { " ^
  "    Write-Host ('  ' * (Get-Random -Min 2 -Max 10)) + $line -ForegroundColor $color; " ^
  "    Start-Sleep -Milliseconds 80 " ^
  "  }; " ^
  "  Start-Sleep -Milliseconds 200 " ^
  "}; " ^
  "Write-Host '`n  Celebration complete!' -ForegroundColor Yellow"
pause
