@echo off
title Snake Game
mode con: cols=60 lines=25

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$w = 50; $h = 20;" ^
  "$snake = [System.Collections.ArrayList]@(@{X=10;Y=10},@{X=9;Y=10},@{X=8;Y=10});" ^
  "$dir = 'RIGHT'; $food = @{X=(Get-Random -Max $w); Y=(Get-Random -Max $h)};" ^
  "$score = 0; $running = $true;" ^
  "function Draw-Border {" ^
  "  [Console]::SetCursorPosition(0,0);" ^
  "  Write-Host ('+' + '-'*$w + '+') -ForegroundColor DarkGray" ^
  "};" ^
  "while ($running) {" ^
  "  if ([Console]::KeyAvailable) {" ^
  "    $key = [Console]::ReadKey($true).Key;" ^
  "    if ($key -eq 'UpArrow' -and $dir -ne 'DOWN') { $dir = 'UP' };" ^
  "    if ($key -eq 'DownArrow' -and $dir -ne 'UP') { $dir = 'DOWN' };" ^
  "    if ($key -eq 'LeftArrow' -and $dir -ne 'RIGHT') { $dir = 'LEFT' };" ^
  "    if ($key -eq 'RightArrow' -and $dir -ne 'LEFT') { $dir = 'RIGHT' };" ^
  "    if ($key -eq 'Q') { $running = $false; break }" ^
  "  };" ^
  "  $head = $snake[0];" ^
  "  $nx = $head.X; $ny = $head.Y;" ^
  "  if ($dir -eq 'UP') { $ny-- };" ^
  "  if ($dir -eq 'DOWN') { $ny++ };" ^
  "  if ($dir -eq 'LEFT') { $nx-- };" ^
  "  if ($dir -eq 'RIGHT') { $nx++ };" ^
  "  if ($nx -lt 0 -or $nx -ge $w -or $ny -lt 0 -or $ny -ge $h) { $running = $false; break };" ^
  "  foreach ($seg in $snake) { if ($seg.X -eq $nx -and $seg.Y -eq $ny) { $running = $false; break } };" ^
  "  $snake.Insert(0, @{X=$nx;Y=$ny});" ^
  "  if ($nx -eq $food.X -and $ny -eq $food.Y) { $score++; $food = @{X=(Get-Random -Max $w); Y=(Get-Random -Max $h)} }" ^
  "  else { $tail = $snake[-1]; $snake.RemoveAt($snake.Count-1); [Console]::SetCursorPosition($tail.X+1,$tail.Y+1); Write-Host ' ' -NoNewline };" ^
  "  [Console]::SetCursorPosition(0, $h+1);" ^
  "  Write-Host \"Score: $score  (Q to quit)\" -ForegroundColor Yellow;" ^
  "  [Console]::SetCursorPosition($food.X+1, $food.Y+1); Write-Host '*' -NoNewline -ForegroundColor Red;" ^
  "  [Console]::SetCursorPosition($snake[0].X+1, $snake[0].Y+1); Write-Host 'O' -NoNewline -ForegroundColor Green;" ^
  "  Start-Sleep -Milliseconds 120" ^
  "};" ^
  "[Console]::SetCursorPosition(0, $h+2);" ^
  "Write-Host \"Game over! Final score: $score\" -ForegroundColor Cyan;" ^
  "[Console]::CursorVisible = $true;" ^
  "Start-Sleep -Seconds 2"
