@echo off
:: BackupHosts.bat - Creates a backup copy of the Windows hosts file
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set SRC=C:\Windows\System32\drivers\etc\hosts
set DEST=%UserProfile%\Desktop\hosts.backup

copy "%SRC%" "%DEST%" >nul
echo Hosts file backed up to Desktop\hosts.backup
pause
