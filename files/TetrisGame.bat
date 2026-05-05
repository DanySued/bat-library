@echo off
title Tetris (Simple)
mode con: cols=60 lines=30

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$w = 10; $h = 20;" ^
  "$board = @(foreach ($r in 1..$h) { ,([int[]]@(0)*$w) });" ^
  "$pieces = @(" ^
  "  @(@(0,1,0,0),@(0,1,0,0),@(0,1,0,0),@(0,1,0,0))," ^
  "  @(@(1,1,0,0),@(1,1,0,0),@(0,0,0,0),@(0,0,0,0))," ^
  "  @(@(1,1,0,0),@(0,1,1,0),@(0,0,0,0),@(0,0,0,0))," ^
  "  @(@(0,1,1,0),@(1,1,0,0),@(0,0,0,0),@(0,0,0,0))," ^
  "  @(@(1,0,0,0),@(1,1,0,0),@(0,1,0,0),@(0,0,0,0))" ^
  ");" ^
  "$score = 0; $px = 3; $py = 0; $piece = $pieces | Get-Random;" ^
  "function Can-Place($piece,$x,$y,$board) {" ^
  "  for ($r=0;$r-lt4;$r++) { for ($c=0;$c-lt4;$c++) { if ($piece[$r][$c]) { if ($y+$r -ge $board.Count -or $x+$c -lt 0 -or $x+$c -ge 10 -or ($y+$r -ge 0 -and $board[$y+$r][$x+$c])) { return $false } } } }; return $true" ^
  "};" ^
  "$running=$true; $tick=0;" ^
  "while ($running) {" ^
  "  if ([Console]::KeyAvailable) {" ^
  "    $key=[Console]::ReadKey($true).Key;" ^
  "    if ($key-eq'LeftArrow' -and (Can-Place $piece ($px-1) $py $board)) { $px-- };" ^
  "    if ($key-eq'RightArrow' -and (Can-Place $piece ($px+1) $py $board)) { $px++ };" ^
  "    if ($key-eq'DownArrow' -and (Can-Place $piece $px ($py+1) $board)) { $py++ };" ^
  "    if ($key-eq'Q') { $running=$false; break }" ^
  "  };" ^
  "  $tick++; if ($tick -ge 10) { $tick=0;" ^
  "    if (Can-Place $piece $px ($py+1) $board) { $py++ }" ^
  "    else {" ^
  "      for ($r=0;$r-lt4;$r++) { for ($c=0;$c-lt4;$c++) { if ($piece[$r][$c] -and ($py+$r) -ge 0) { $board[$py+$r][$px+$c]=1 } } };" ^
  "      $full=@(); for ($r=0;$r-lt$h;$r++) { if (($board[$r] | Measure-Object -Sum).Sum -eq $w) { $full+=$r } };" ^
  "      $score+=$full.Count*10;" ^
  "      foreach ($r in $full) { $board.RemoveAt($r); $board.Insert(0,[int[]]@(0)*$w) };" ^
  "      $px=3; $py=0; $piece=$pieces|Get-Random;" ^
  "      if (-not (Can-Place $piece $px $py $board)) { $running=$false }" ^
  "    }" ^
  "  };" ^
  "  for ($r=0;$r-lt$h;$r++) {" ^
  "    [Console]::SetCursorPosition(2,$r+1);" ^
  "    for ($c=0;$c-lt$w;$c++) {" ^
  "      $inPiece=$false;" ^
  "      for ($pr=0;$pr-lt4;$pr++) { for ($pc=0;$pc-lt4;$pc++) { if ($piece[$pr][$pc] -and ($py+$pr)-eq$r -and ($px+$pc)-eq$c) { $inPiece=$true } } };" ^
  "      if ($inPiece) { Write-Host '[]' -NoNewline -ForegroundColor Cyan }" ^
  "      elseif ($board[$r][$c]) { Write-Host '[]' -NoNewline -ForegroundColor DarkGray }" ^
  "      else { Write-Host '  ' -NoNewline }" ^
  "    }" ^
  "  };" ^
  "  [Console]::SetCursorPosition(14,2); Write-Host \"Score: $score\" -ForegroundColor Yellow;" ^
  "  [Console]::SetCursorPosition(14,3); Write-Host 'Arrows=move' -ForegroundColor DarkGray;" ^
  "  [Console]::SetCursorPosition(14,4); Write-Host 'Q=quit' -ForegroundColor DarkGray;" ^
  "  Start-Sleep -Milliseconds 50" ^
  "};" ^
  "[Console]::SetCursorPosition(0,22); Write-Host \"Game over! Score: $score\" -ForegroundColor Green;" ^
  "[Console]::CursorVisible=$true; Start-Sleep -Seconds 2"
