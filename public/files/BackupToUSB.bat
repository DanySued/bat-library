@echo off
:: BackupToUSB.bat - Copies Documents, Desktop, and Pictures to a USB drive
:: EDIT: Change E:\ to your USB drive letter below
set DEST=E:\Backup

echo Backing up to %DEST%...
echo.

if not exist "%DEST%" mkdir "%DEST%"

echo Backing up Documents...
robocopy "%UserProfile%\Documents" "%DEST%\Documents" /MIR /R:1 /W:1 /LOG+:"%USERPROFILE%\Desktop\BackupLog.txt" >nul

echo Backing up Desktop...
robocopy "%UserProfile%\Desktop" "%DEST%\Desktop" /MIR /R:1 /W:1 /LOG+:"%USERPROFILE%\Desktop\BackupLog.txt" >nul

echo Backing up Pictures...
robocopy "%UserProfile%\Pictures" "%DEST%\Pictures" /MIR /R:1 /W:1 /LOG+:"%USERPROFILE%\Desktop\BackupLog.txt" >nul

echo.
echo Backup complete. Log saved to Desktop\BackupLog.txt
pause
