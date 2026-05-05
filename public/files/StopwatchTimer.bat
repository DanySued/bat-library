@echo off
:: StopwatchTimer.bat - Live stopwatch with start/stop/reset
powershell -NoExit -Command ^
  "$start=$null;$elapsed=[TimeSpan]::Zero;$running=$false; " ^
  "$Host.UI.RawUI.BackgroundColor='Black';Clear-Host; " ^
  "Write-Host 'STOPWATCH' -ForegroundColor Cyan; " ^
  "Write-Host 'Press SPACE to start/stop, R to reset, Q to quit' -ForegroundColor DarkGray; " ^
  "Write-Host ''; " ^
  "while($true){ " ^
  "  if($running){ " ^
  "    $current=$elapsed+([DateTime]::Now-$start); " ^
  "  }else{$current=$elapsed}; " ^
  "  [Console]::SetCursorPosition(0,3); " ^
  "  Write-Host ('  '+$current.ToString('hh\:mm\:ss\.ff')) -ForegroundColor White; " ^
  "  if($running){Write-Host '  [RUNNING] ' -ForegroundColor Green} " ^
  "  else{Write-Host '  [STOPPED] ' -ForegroundColor DarkGray}; " ^
  "  Start-Sleep -Milliseconds 50; " ^
  "  if([Console]::KeyAvailable){ " ^
  "    $k=[Console]::ReadKey($true).Key; " ^
  "    if($k-eq'Spacebar'){ " ^
  "      if($running){$elapsed+=[DateTime]::Now-$start;$running=$false} " ^
  "      else{$start=[DateTime]::Now;$running=$true} " ^
  "    }elseif($k-eq'R'){$elapsed=[TimeSpan]::Zero;$running=$false} " ^
  "    elseif($k-eq'Q'){break} " ^
  "  } " ^
  "}"
