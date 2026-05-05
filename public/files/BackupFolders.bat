@echo off
:: BackupFolders.bat - Backs up Desktop, Documents, Pictures, Downloads
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo BackupFolders - Backup Important Personal Folders
echo.
set /p DEST=Enter backup destination (e.g. D:\Backup or \\NAS\backup):

for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set TODAY=%%c-%%a-%%b
set FOLDER=%DEST%\WindowsBackup_%TODAY%

echo.
echo Creating backup folder: %FOLDER%
if not exist "%FOLDER%" mkdir "%FOLDER%"

echo Backing up Desktop...
robocopy "%UserProfile%\Desktop" "%FOLDER%\Desktop" /MIR /R:1 /W:1 /NP /LOG+:"%FOLDER%\BackupLog.txt" >nul

echo Backing up Documents...
robocopy "%UserProfile%\Documents" "%FOLDER%\Documents" /MIR /R:1 /W:1 /NP /LOG+:"%FOLDER%\BackupLog.txt" >nul

echo Backing up Pictures...
robocopy "%UserProfile%\Pictures" "%FOLDER%\Pictures" /MIR /R:1 /W:1 /NP /LOG+:"%FOLDER%\BackupLog.txt" >nul

echo Backing up Downloads...
robocopy "%UserProfile%\Downloads" "%FOLDER%\Downloads" /MIR /R:1 /W:1 /NP /LOG+:"%FOLDER%\BackupLog.txt" >nul

echo.
echo Backup complete! Saved to: %FOLDER%
echo Log file: %FOLDER%\BackupLog.txt
pause
