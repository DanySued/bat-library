@echo off
:: RainbowText.bat - Prints text in cycling rainbow colors
:: EDIT: Change the message below
set MSG=Hello from the bat library! This text is totally radical.

powershell -Command ^
  "$msg = '%MSG%'; " ^
  "$colors = 'Red','Yellow','Green','Cyan','Blue','Magenta','White'; " ^
  "$i = 0; " ^
  "foreach ($char in $msg.ToCharArray()) { " ^
  "  Write-Host $char -NoNewline -ForegroundColor $colors[$i %% $colors.Count]; " ^
  "  $i++; " ^
  "  Start-Sleep -Milliseconds 40 " ^
  "}; " ^
  "Write-Host ''"
pause
