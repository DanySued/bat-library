@echo off
:: AutoBackupDocuments.bat - Creates a scheduled daily backup of Documents
:: EDIT: Set your backup destination below
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set SRC=%UserProfile%\Documents
set DEST=D:\DocumentsBackup

set TASKNAME=DailyDocumentsBackup
set SCRIPT=%~f0

echo Creating scheduled task for daily backup at 2:00 AM...
schtasks /Create /SC DAILY /TN "%TASKNAME%" /TR "robocopy \"%SRC%\" \"%DEST%\" /MIR /R:1 /W:1 /LOG+:\"%UserProfile%\Desktop\BackupLog.txt\"" /ST 02:00 /F

echo.
echo Done. Daily backup scheduled for 2:00 AM.
echo Destination: %DEST%
echo IMPORTANT: Edit DEST in this script to change the backup location.
echo PC must be on at 2 AM for the backup to run.
pause
