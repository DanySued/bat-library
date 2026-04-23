@echo off
:: ============================================================
::  BackupFolders.bat
::  Backs up Desktop, Documents, Pictures, Downloads
::  to a folder of your choice (external drive recommended)
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Backup Important Folders
echo  =====================================================
echo.

:: Get date for folder name
for /f "tokens=2 delims==" %%a in ('wmic OS get LocalDateTime /value') do set "dt=%%a"
set "DATESTR=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%"

:: Ask for destination
echo  Where do you want to save the backup?
echo  Example: D:\Backup  or  E:\MyBackup
echo.
set /p "DEST=Enter destination path: "

if "%DEST%"=="" (
    echo  No path entered. Exiting.
    pause & exit /b
)

set "BACKUPDIR=%DEST%\WindowsBackup_%DATESTR%"

echo.
echo  Backup will be saved to:
echo  %BACKUPDIR%
echo.
echo  Press any key to start...
pause >nul

:: Create destination
md "%BACKUPDIR%" >nul 2>&1

echo.
echo  [1/4] Backing up Desktop...
robocopy "%USERPROFILE%\Desktop" "%BACKUPDIR%\Desktop" /E /Z /NP /R:1 /W:1

echo  [2/4] Backing up Documents...
robocopy "%USERPROFILE%\Documents" "%BACKUPDIR%\Documents" /E /Z /NP /R:1 /W:1

echo  [3/4] Backing up Pictures...
robocopy "%USERPROFILE%\Pictures" "%BACKUPDIR%\Pictures" /E /Z /NP /R:1 /W:1

echo  [4/4] Backing up Downloads...
robocopy "%USERPROFILE%\Downloads" "%BACKUPDIR%\Downloads" /E /Z /NP /R:1 /W:1

echo.
echo  =====================================================
echo   Backup complete!
echo   Location: %BACKUPDIR%
echo  =====================================================
echo.
pause
