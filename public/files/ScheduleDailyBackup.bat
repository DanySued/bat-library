@echo off
:: ScheduleDailyBackup.bat - Sets up Windows Task for automatic daily backups
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo ScheduleDailyBackup - Set up automatic daily backups
echo Make sure BackupFolders.bat is saved somewhere permanent.
echo.

set /p BAT_PATH=Full path to BackupFolders.bat (e.g. C:\Scripts\BackupFolders.bat):
if not exist "%BAT_PATH%" (echo File not found: %BAT_PATH% && pause && exit /b)

set /p BACKUP_TIME=Time to run daily backup (24h format, e.g. 22:00):
set /p BACKUP_DEST=Backup destination (e.g. D:\Backup):

:: Create a wrapper that passes the destination
set WRAPPER=%TEMP%\RunDailyBackup.bat
echo @echo off > "%WRAPPER%"
echo set DEST=%BACKUP_DEST% >> "%WRAPPER%"
echo call "%BAT_PATH%" >> "%WRAPPER%"

echo.
echo Creating scheduled task 'DailyWindowsBackup'...

schtasks /delete /tn "DailyWindowsBackup" /f >nul 2>&1
schtasks /create ^
    /tn "DailyWindowsBackup" ^
    /tr "\"%WRAPPER%\"" ^
    /sc daily ^
    /st %BACKUP_TIME% ^
    /ru "%USERNAME%" ^
    /rl highest ^
    /f

echo.
echo Daily backup scheduled for %BACKUP_TIME% every day.
echo.
echo To remove: Task Scheduler ^> Task Scheduler Library ^> delete 'DailyWindowsBackup'
echo Tip: Keep the external drive connected at %BACKUP_TIME% or backup will fail.
pause
