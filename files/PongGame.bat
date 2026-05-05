@echo off
title Pong Game
mode con: cols=80 lines=25

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$w = 78; $h = 22;" ^
  "$bx = 39; $by = 11; $bdx = 1; $bdy = 1;" ^
  "$p1y = 10; $p2y = 10; $ps = 4;" ^
  "$s1 = 0; $s2 = 0; $running = $true;" ^
  "function DrawPaddle($x,$y,$prev) {" ^
  "  for ($i=0;$i-le$ps;$i++) {" ^
  "    [Console]::SetCursorPosition($x,$prev+$i); Write-Host ' ' -NoNewline;" ^
  "    [Console]::SetCursorPosition($x,$y+$i); Write-Host '|' -NoNewline -ForegroundColor Cyan" ^
  "  }" ^
  "};" ^
  "$pp1=$p1y; $pp2=$p2y;" ^
  "while ($running) {" ^
  "  if ([Console]::KeyAvailable) {" ^
  "    $key = [Console]::ReadKey($true).Key;" ^
  "    if ($key -eq 'W' -and $p1y -gt 0) { $pp1=$p1y; $p1y-- };" ^
  "    if ($key -eq 'S' -and ($p1y+$ps) -lt $h) { $pp1=$p1y; $p1y++ };" ^
  "    if ($key -eq 'UpArrow' -and $p2y -gt 0) { $pp2=$p2y; $p2y-- };" ^
  "    if ($key -eq 'DownArrow' -and ($p2y+$ps) -lt $h) { $pp2=$p2y; $p2y++ };" ^
  "    if ($key -eq 'Q') { $running = $false; break }" ^
  "  };" ^
  "  [Console]::SetCursorPosition($bx,$by); Write-Host ' ' -NoNewline;" ^
  "  $bx+=$bdx; $by+=$bdy;" ^
  "  if ($by -le 0 -or $by -ge $h) { $bdy=-$bdy };" ^
  "  if ($bx -le 2 -and $by -ge $p1y -and $by -le ($p1y+$ps)) { $bdx=-$bdx };" ^
  "  if ($bx -ge ($w-2) -and $by -ge $p2y -and $by -le ($p2y+$ps)) { $bdx=-$bdx };" ^
  "  if ($bx -le 0) { $s2++; $bx=39; $by=11 };" ^
  "  if ($bx -ge $w) { $s1++; $bx=39; $by=11 };" ^
  "  DrawPaddle 1 $p1y $pp1; $pp1=$p1y;" ^
  "  DrawPaddle ($w-1) $p2y $pp2; $pp2=$p2y;" ^
  "  [Console]::SetCursorPosition($bx,$by); Write-Host 'o' -NoNewline -ForegroundColor Yellow;" ^
  "  [Console]::SetCursorPosition(0,0); Write-Host \"P1: $s1   P2: $s2   (W/S vs Up/Down, Q=quit)\" -ForegroundColor White;" ^
  "  if ($s1 -ge 7 -or $s2 -ge 7) { $running=$false };" ^
  "  Start-Sleep -Milliseconds 60" ^
  "};" ^
  "[Console]::SetCursorPosition(0,$h+1);" ^
  "if ($s1 -gt $s2) { Write-Host 'Player 1 wins!' -ForegroundColor Green }" ^
  "else { Write-Host 'Player 2 wins!' -ForegroundColor Green };" ^
  "[Console]::CursorVisible = $true;" ^
  "Start-Sleep -Seconds 2"
