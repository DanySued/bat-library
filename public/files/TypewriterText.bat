@echo off
:: TypewriterText.bat - Types out a message with typewriter animation
:: EDIT: Change the message below
set MSG=Hello, World! Welcome to the bat library.

powershell -Command ^
  "$msg = '%MSG%'; " ^
  "foreach ($char in $msg.ToCharArray()) { " ^
  "  Write-Host $char -NoNewline; " ^
  "  Start-Sleep -Milliseconds 60 " ^
  "}; " ^
  "Write-Host ''"
pause
