@echo off
:: BouncingBall.bat - Bouncing ball ASCII animation
powershell -NoExit -Command ^
  "$w=[Console]::WindowWidth-1; " ^
  "$h=[Console]::WindowHeight-3; " ^
  "$x=10;$y=5;$dx=1;$dy=1; " ^
  "$Host.UI.RawUI.BackgroundColor='Black'; " ^
  "Clear-Host; " ^
  "while($true){ " ^
  "  [Console]::SetCursorPosition($x,$y); " ^
  "  Write-Host 'O' -NoNewline -ForegroundColor Cyan; " ^
  "  Start-Sleep -Milliseconds 40; " ^
  "  [Console]::SetCursorPosition($x,$y); " ^
  "  Write-Host ' ' -NoNewline; " ^
  "  $x+=$dx;$y+=$dy; " ^
  "  if($x-le0-or$x-ge$w){$dx=-$dx}; " ^
  "  if($y-le0-or$y-ge$h){$dy=-$dy}; " ^
  "  if([Console]::KeyAvailable){$null=[Console]::ReadKey($true);break} " ^
  "}; " ^
  "Write-Host '`nStopped.' -ForegroundColor Yellow"
