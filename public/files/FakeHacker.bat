@echo off
:: FakeHacker.bat - Fake hacker terminal animation
color 0a
title [SYSTEM] Unauthorized Access Detected

powershell -Command ^
  "$lines = @( " ^
  "  'Initializing payload...', " ^
  "  'Bypassing firewall... [OK]', " ^
  "  'Injecting shellcode 0xDEADBEEF...', " ^
  "  'Cracking AES-256 encryption...', " ^
  "  '[##########] 100%% - Hash cracked: 5f4dcc3b5aa765d61d8327deb882cf99', " ^
  "  'Accessing mainframe...', " ^
  "  'Downloading user database...', " ^
  "  'Exfiltrating files: passwords.db, wallet.dat, private_keys.pem', " ^
  "  'Covering tracks... wiping logs...', " ^
  "  'ACCESS GRANTED - Welcome, hacker.' " ^
  "); " ^
  "foreach ($line in $lines) { " ^
  "  Write-Host $line -ForegroundColor Green; " ^
  "  Start-Sleep -Milliseconds (Get-Random -Min 300 -Max 1200) " ^
  "}; " ^
  "Write-Host ''; " ^
  "Write-Host ' >>> THIS IS JUST A PRANK - No actual hacking occurred <<<' -ForegroundColor Yellow"
pause
