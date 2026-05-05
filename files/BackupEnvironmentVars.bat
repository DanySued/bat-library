@echo off
title Backup Environment Variables

set DEST=%USERPROFILE%\Desktop\EnvVarsBackup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.reg

echo Exporting environment variables...
reg export "HKCU\Environment" "%DEST%" /y >nul
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "%USERPROFILE%\Desktop\SystemEnvVars_%date:~-4,4%%date:~-10,2%%date:~-7,2%.reg" /y >nul

echo.
echo User environment variables backed up to Desktop.
echo System environment variables backed up to Desktop.
echo To restore: double-click the .reg files.
pause
