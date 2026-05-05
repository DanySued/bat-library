@echo off
title Backup Hosts File

set SRC=%SystemRoot%\System32\drivers\etc\hosts
set DEST=%USERPROFILE%\Desktop\hosts_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Backing up hosts file...
copy "%SRC%" "%DEST%" >nul

echo.
echo Hosts file backed up to %DEST%
pause
