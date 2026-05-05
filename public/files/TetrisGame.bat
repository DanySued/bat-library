@echo off
:: TetrisGame.bat - Tetris-style block stacking game in the terminal
powershell -NoExit -Command ^
  "$w=12;$h=20;$board=@(); " ^
  "for($i=0;$i-lt$h;$i++){$row=@();for($j=0;$j-lt$w;$j++){$row+=' '};$board+=[ref]$row}; " ^
  "$pieces=@(@(@(1,1,1,1)),@(@(1,1),@(1,1)),@(@(1,1,1),@(0,1,0)),@(@(1,1,1),@(1,0,0)),@(@(1,1,1),@(0,0,1)),@(@(1,1,0),@(0,1,1)),@(@(0,1,1),@(1,1,0))); " ^
  "$colors=@('Cyan','Yellow','Magenta','Blue','Red','Green','DarkYellow'); " ^
  "$board=New-Object 'int[,]' $h,$w; " ^
  "$score=0;$level=1;$gameOver=$false; " ^
  "function NewPiece { " ^
  "  $script:pi=Get-Random -Max 7; " ^
  "  $script:px=[int](($w-2)/2); " ^
  "  $script:py=0; " ^
  "  $script:shape=$pieces[$script:pi] " ^
  "}; " ^
  "function DrawBoard { " ^
  "  [Console]::SetCursorPosition(0,0); " ^
  "  Write-Host ('+' + ('-'*$w) + '+') -ForegroundColor White; " ^
  "  for($y=0;$y-lt$h;$y++){ " ^
  "    Write-Host '|' -NoNewline -ForegroundColor White; " ^
  "    for($x=0;$x-lt$w;$x++){ " ^
  "      if($board[$y,$x]-gt0){Write-Host '#' -NoNewline -ForegroundColor Cyan} " ^
  "      else{Write-Host ' ' -NoNewline} " ^
  "    }; " ^
  "    Write-Host '|' -ForegroundColor White " ^
  "  }; " ^
  "  Write-Host ('+' + ('-'*$w) + '+') -ForegroundColor White; " ^
  "  Write-Host \"Score: $score  Level: $level  | WASD=move Q=quit\" " ^
  "}; " ^
  "function PlacePiece { " ^
  "  foreach($row in $script:shape){ " ^
  "    for($x=0;$x-lt$row.Count;$x++){ " ^
  "      if($row[$x]-eq1){$board[$script:py,$script:px+$x]=1} " ^
  "    }; " ^
  "    $script:py++ " ^
  "  } " ^
  "}; " ^
  "$Host.UI.RawUI.BackgroundColor='Black';Clear-Host; " ^
  "NewPiece; " ^
  "$tick=0; " ^
  "while(-not$gameOver){ " ^
  "  DrawBoard; " ^
  "  Start-Sleep -Milliseconds 100; " ^
  "  $tick++; " ^
  "  if([Console]::KeyAvailable){ " ^
  "    $k=[Console]::ReadKey($true).Key; " ^
  "    if($k-eq'Q'){$gameOver=$true} " ^
  "  }; " ^
  "  if($tick%8-eq0){ " ^
  "    $script:py++; " ^
  "    if($script:py+$script:shape.Count-ge$h){ " ^
  "      PlacePiece; " ^
  "      $score+=10; " ^
  "      NewPiece; " ^
  "      if($script:py-le0){$gameOver=$true} " ^
  "    } " ^
  "  } " ^
  "}; " ^
  "Write-Host \"`nGame Over! Final Score: $score\" -ForegroundColor Yellow"
