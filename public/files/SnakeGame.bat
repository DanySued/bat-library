@echo off
:: SnakeGame.bat - Play classic Snake in the terminal
powershell -NoExit -Command ^
  "$w=40;$h=20;$snake=New-Object System.Collections.Generic.List[object]; " ^
  "$snake.Add([PSCustomObject]@{x=20;y=10}); " ^
  "$dx=1;$dy=0;$score=0; " ^
  "$food=[PSCustomObject]@{x=(Get-Random -Min 2 -Max ($w-2));y=(Get-Random -Min 2 -Max ($h-2))}; " ^
  "$Host.UI.RawUI.BackgroundColor='Black';Clear-Host; " ^
  "function Draw { " ^
  "  $b=''; " ^
  "  for($y=0;$y-le$h;$y++){ " ^
  "    for($x=0;$x-le$w;$x++){ " ^
  "      if($y-eq0-or$y-eq$h-or$x-eq0-or$x-eq$w){$b+='#'} " ^
  "      elseif($x-eq$food.x-and$y-eq$food.y){$b+='O'} " ^
  "      elseif($snake|Where{$_.x-eq$x-and$_.y-eq$y}){$b+='*'} " ^
  "      else{$b+=' '} " ^
  "    };$b+=\"`n\" " ^
  "  }; " ^
  "  [System.Console]::SetCursorPosition(0,0); " ^
  "  Write-Host $b -NoNewline; " ^
  "  Write-Host 'Score: '$score ' | WASD to move, Q to quit' " ^
  "}; " ^
  "while($true){ " ^
  "  Draw; " ^
  "  if([System.Console]::KeyAvailable){ " ^
  "    $k=[System.Console]::ReadKey($true).Key; " ^
  "    if($k-eq'W'-and$dy-ne1){$dx=0;$dy=-1} " ^
  "    elseif($k-eq'S'-and$dy-ne-1){$dx=0;$dy=1} " ^
  "    elseif($k-eq'A'-and$dx-ne1){$dx=-1;$dy=0} " ^
  "    elseif($k-eq'D'-and$dx-ne-1){$dx=1;$dy=0} " ^
  "    elseif($k-eq'Q'){break} " ^
  "  }; " ^
  "  $head=[PSCustomObject]@{x=$snake[0].x+$dx;y=$snake[0].y+$dy}; " ^
  "  if($head.x-le0-or$head.x-ge$w-or$head.y-le0-or$head.y-ge$h){Write-Host 'Game Over! Score: '$score;break}; " ^
  "  $snake.Insert(0,$head); " ^
  "  if($head.x-eq$food.x-and$head.y-eq$food.y){ " ^
  "    $score++;$food=[PSCustomObject]@{x=(Get-Random -Min 1 -Max ($w-1));y=(Get-Random -Min 1 -Max ($h-1))} " ^
  "  }else{$snake.RemoveAt($snake.Count-1)}; " ^
  "  Start-Sleep -Milliseconds 120 " ^
  "}"
