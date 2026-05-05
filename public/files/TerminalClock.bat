@echo off
:: TerminalClock.bat - Live digital clock in the terminal
powershell -NoExit -Command ^
  "$Host.UI.RawUI.BackgroundColor='Black'; " ^
  "Clear-Host; " ^
  "while($true){ " ^
  "  [Console]::SetCursorPosition(0,0); " ^
  "  $t = Get-Date -Format 'HH:mm:ss'; " ^
  "  $d = Get-Date -Format 'dddd, MMMM dd yyyy'; " ^
  "  Write-Host ''; " ^
  "  Write-Host ('  ' + $d) -ForegroundColor DarkGray; " ^
  "  Write-Host ''; " ^
  "  Write-Host ('  ' + $t) -ForegroundColor Cyan; " ^
  "  Write-Host ''; " ^
  "  Write-Host '  Press any key to exit...' -ForegroundColor DarkGray; " ^
  "  Start-Sleep -Milliseconds 500; " ^
  "  if([Console]::KeyAvailable){$null=[Console]::ReadKey($true);break} " ^
  "}"
