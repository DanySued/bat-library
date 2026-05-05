@echo off
:: PongGame.bat - Single-player Pong (bounce off all walls) in the terminal
powershell -NoExit -Command ^
  "$w=60;$h=20; " ^
  "$bx=30;$by=10;$bdx=1;$bdy=1; " ^
  "$py=[int]($h/2);$ps=3; " ^
  "$score=0; " ^
  "$Host.UI.RawUI.BackgroundColor='Black';Clear-Host; " ^
  "function Draw { " ^
  "  [Console]::SetCursorPosition(0,0); " ^
  "  $out=''; " ^
  "  for($y=0;$y-lt$h;$y++){ " ^
  "    for($x=0;$x-lt$w;$x++){ " ^
  "      if($x-eq[int]$bx-and$y-eq[int]$by){$out+='O'} " ^
  "      elseif($x-eq2-and$y-ge$py-and$y-le($py+$ps)){$out+='|'} " ^
  "      elseif($y-eq0-or$y-eq($h-1)){$out+='-'} " ^
  "      else{$out+=' '} " ^
  "    };$out+=\"`n\" " ^
  "  }; " ^
  "  Write-Host $out -NoNewline -ForegroundColor Cyan; " ^
  "  Write-Host \"Score: $score  | W/S = paddle  Q = quit\" -ForegroundColor White " ^
  "}; " ^
  "while($true){ " ^
  "  Draw; " ^
  "  if([Console]::KeyAvailable){ " ^
  "    $k=[Console]::ReadKey($true).Key; " ^
  "    if($k-eq'W'-and$py-gt0){$py--}; " ^
  "    if($k-eq'S'-and($py+$ps)-lt($h-1)){$py++}; " ^
  "    if($k-eq'Q'){break} " ^
  "  }; " ^
  "  $bx+=$bdx;$by+=$bdy; " ^
  "  if($by-le0-or$by-ge($h-1)){$bdy=-$bdy}; " ^
  "  if($bx-ge($w-1)){$bdx=-$bdx;$score++}; " ^
  "  if($bx-le3){ " ^
  "    if($by-ge$py-and$by-le($py+$ps)){$bdx=-$bdx} " ^
  "    else{Write-Host 'Miss! Game Over. Score: '$score -ForegroundColor Red;break} " ^
  "  }; " ^
  "  Start-Sleep -Milliseconds 50 " ^
  "}"
