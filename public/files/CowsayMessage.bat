@echo off
:: CowsayMessage.bat - ASCII cow says a message
:: EDIT: Change the message below
set MSG=Moo! Welcome to the bat library.

powershell -Command ^
  "$msg = '%MSG%'; " ^
  "$border = '-' * ($msg.Length + 2); " ^
  "Write-Host (' ' + $border) -ForegroundColor Yellow; " ^
  "Write-Host ('< ' + $msg + ' >') -ForegroundColor Yellow; " ^
  "Write-Host (' ' + $border) -ForegroundColor Yellow; " ^
  "Write-Host '        \   ^__^' -ForegroundColor White; " ^
  "Write-Host '         \  (oo)\_______' -ForegroundColor White; " ^
  "Write-Host '            (__)\       )\/\' -ForegroundColor White; " ^
  "Write-Host '                ||----w |' -ForegroundColor White; " ^
  "Write-Host '                ||     ||' -ForegroundColor White"
pause
