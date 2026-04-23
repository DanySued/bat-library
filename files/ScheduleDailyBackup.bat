@echo off
:: ============================================================
::  ScheduleDailyBackup.bat
::  Sets up a Windows Task that automatically backs up
::  your Desktop, Documents, Pictures and Downloads
::  every day at a time you choose
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Schedule Daily Automatic Backup
echo  =====================================================
echo.

set /p "DEST=Where to back up? (e.g. D:\DailyBackup): "
if "%DEST%"=="" (
    echo  No path entered. Exiting.
    pause & exit /b
)

set /p "TIME=What time to run daily? (e.g. 23:00 for 11pm): "
if "%TIME%"=="" set "TIME=23:00"

:: Create the backup script in a permanent location
set "SCRIPTPATH=%SYSTEMDRIVE%\DailyBackup_Task.bat"

echo @echo off > "%SCRIPTPATH%"
echo for /f "tokens=2 delims==" %%%%a in ('wmic OS get LocalDateTime /value') do set "dt=%%%%a" >> "%SCRIPTPATH%"
echo set "DATESTR=%%%%dt:~0,4%%%%-%%%%dt:~4,2%%%%-%%%%dt:~6,2%%" >> "%SCRIPTPATH%"
echo set "OUT=%DEST%\%%%%DATESTR%%" >> "%SCRIPTPATH%"
echo md "%%%%OUT%%%%" ^>nul 2^>^&1 >> "%SCRIPTPATH%"
echo robocopy "%%%%USERPROFILE%%%%\Desktop"   "%%%%OUT%%%%\Desktop"   /E /Z /NP /R:1 /W:1 >> "%SCRIPTPATH%"
echo robocopy "%%%%USERPROFILE%%%%\Documents" "%%%%OUT%%%%\Documents" /E /Z /NP /R:1 /W:1 >> "%SCRIPTPATH%"
echo robocopy "%%%%USERPROFILE%%%%\Pictures"  "%%%%OUT%%%%\Pictures"  /E /Z /NP /R:1 /W:1 >> "%SCRIPTPATH%"
echo robocopy "%%%%USERPROFILE%%%%\Downloads" "%%%%OUT%%%%\Downloads" /E /Z /NP /R:1 /W:1 >> "%SCRIPTPATH%"

:: Register as a scheduled task
schtasks /delete /tn "DailyWindowsBackup" /f >nul 2>&1
schtasks /create /tn "DailyWindowsBackup" /tr "%SCRIPTPATH%" /sc daily /st %TIME% /ru SYSTEM /rl HIGHEST /f >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo.
    echo  =====================================================
    echo   Daily backup scheduled successfully!
    echo.
    echo   Backs up: Desktop, Documents, Pictures, Downloads
    echo   Destination: %DEST%
    echo   Time: Every day at %TIME%
    echo.
    echo   Each day creates a new dated folder.
    echo   To cancel: search "Task Scheduler" in Start Menu
    echo   and delete "DailyWindowsBackup"
    echo  =====================================================
) else (
    echo  [ERROR] Could not create scheduled task.
    echo  Try running this script again as Administrator.
)
echo.
pause
