@echo off
title Matrix Rain
color 0a
mode con: cols=120 lines=40

:loop
set "chars=0123456789ABCDEF"
set /a "col=!random! %% 120"
set /a "char_idx=!random! %% 16"

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$w = [Console]::WindowWidth;" ^
  "$h = [Console]::WindowHeight;" ^
  "while ($true) {" ^
  "  $x = Get-Random -Max $w;" ^
  "  $y = Get-Random -Max $h;" ^
  "  [Console]::SetCursorPosition($x, $y);" ^
  "  $chars = '0123456789ABCDEFabcdefｦｧｨｩｪｫｬｭｮｯｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ';" ^
  "  Write-Host $chars[(Get-Random -Max $chars.Length)] -NoNewline -ForegroundColor Green;" ^
  "  Start-Sleep -Milliseconds 5;" ^
  "  if ([Console]::KeyAvailable) { break }" ^
  "}"
