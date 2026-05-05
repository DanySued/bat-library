@echo off
title Auto Backup Documents (Daily Task)
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

set SCRIPT=%~f0
set DEST=%USERPROFILE%\BackupAuto

if not exist "%DEST%" mkdir "%DEST%"

echo Creating scheduled daily backup task...
schtasks /Create /TN "AutoBackupDocuments" /TR "robocopy \"%USERPROFILE%\Documents\" \"%DEST%\Documents\" /MIR /Z /W:0 /R:2 /LOG+:\"%DEST%\backup.log\"" /SC DAILY /ST 02:00 /F >nul 2>&1

echo Running first backup now...
robocopy "%USERPROFILE%\Documents" "%DEST%\Documents" /MIR /Z /W:0 /R:2 >nul

echo.
echo Daily backup scheduled at 2:00 AM to %DEST%
echo First backup completed.
pause
