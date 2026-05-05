@echo off
title "HACKING IN PROGRESS..."
color 0a
mode con: cols=100 lines=35

PowerShell -NoProfile -Command ^
  "[Console]::CursorVisible = $false;" ^
  "$lines = @(" ^
  "  'Initializing connection to mainframe...'," ^
  "  'Bypassing firewall [================] 100%%'," ^
  "  'Injecting payload: exploit_ms17_010.dll'," ^
  "  'Target acquired: 192.168.1.1'," ^
  "  'Decrypting RSA-4096 key... [done]'," ^
  "  'Downloading /etc/passwd...'," ^
  "  'ACCESS GRANTED'," ^
  "  'Root shell obtained. Type freely.'," ^
  "  'Uploading data to darknet nodes...'," ^
  "  'Covering tracks: deleting logs...'," ^
  "  'Mission complete. Disconnecting.'" ^
  ");" ^
  "foreach ($line in $lines) {" ^
  "  foreach ($c in $line.ToCharArray()) {" ^
  "    Write-Host $c -NoNewline -ForegroundColor Green;" ^
  "    Start-Sleep -Milliseconds (Get-Random -Min 10 -Max 60)" ^
  "  };" ^
  "  Write-Host;" ^
  "  Start-Sleep -Milliseconds (Get-Random -Min 100 -Max 600)" ^
  "};" ^
  "Write-Host;" ^
  "Write-Host '> Just kidding. This is fake. Press any key.' -ForegroundColor DarkGreen;" ^
  "[Console]::CursorVisible = $true;" ^
  "$null = [Console]::ReadKey($true)"
