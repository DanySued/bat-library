@echo off
:: CountdownTimer.bat - Countdown timer with visual display
:: EDIT: Set your countdown seconds below
set SECONDS=60

powershell -Command ^
  "$total = %SECONDS%; " ^
  "$Host.UI.RawUI.BackgroundColor='Black'; " ^
  "Clear-Host; " ^
  "Write-Host 'COUNTDOWN TIMER' -ForegroundColor Cyan; " ^
  "Write-Host 'Press Q to cancel' -ForegroundColor DarkGray; " ^
  "Write-Host ''; " ^
  "for($i=$total;$i-ge0;$i--){ " ^
  "  [Console]::SetCursorPosition(0,3); " ^
  "  $ts=[TimeSpan]::FromSeconds($i); " ^
  "  $pct=[int](($i/$total)*20); " ^
  "  $bar=('#'*$pct)+(' '*(20-$pct)); " ^
  "  Write-Host ('  Time left: '+$ts.ToString('mm\:ss')+'    ') -ForegroundColor White; " ^
  "  Write-Host ('  ['+$bar+']  ') -ForegroundColor $(if($i-gt$total*0.3){'Green'}elseif($i-gt$total*0.1){'Yellow'}else{'Red'}); " ^
  "  if($i-eq0){break}; " ^
  "  Start-Sleep -Seconds 1; " ^
  "  if([Console]::KeyAvailable){ " ^
  "    $k=[Console]::ReadKey($true).Key; " ^
  "    if($k-eq'Q'){Write-Host '`n  Cancelled.' -ForegroundColor DarkGray;exit} " ^
  "  } " ^
  "}; " ^
  "Write-Host ''; " ^
  "Write-Host '  Time is up!' -ForegroundColor Yellow; " ^
  "[Console]::Beep(880,500)"
pause
