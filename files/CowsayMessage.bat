@echo off
title Cowsay Message

set /p MSG=Enter your message:
if "%MSG%"=="" set MSG=Moo! Welcome to bat-library.

PowerShell -NoProfile -Command ^
  "$msg = '%MSG%';" ^
  "$len = $msg.Length;" ^
  "$border = '-' * ($len + 2);" ^
  "Write-Host (' ' + $border);" ^
  "Write-Host ('< ' + $msg + ' >');" ^
  "Write-Host (' ' + $border);" ^
  "Write-Host '        \   ^__^';" ^
  "Write-Host '         \  (oo)\_______';" ^
  "Write-Host '            (__)\       )\/\';" ^
  "Write-Host '                ||----w |';" ^
  "Write-Host '                ||     ||'"

echo.
pause
