@echo off
title Create System Image Backup
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Looking for a backup drive...
set DEST=
for %%D in (D E F G H) do (
    if exist %%D:\ (
        set DEST=%%D:
        goto :found
    )
)
echo No secondary drive found for backup destination.
echo Connect an external drive and try again.
pause
exit /b 1

:found
echo Creating system image backup to %DEST%...
echo This may take 15-60 minutes depending on drive size.
echo.
wbAdmin start backup -backupTarget:%DEST% -include:%SystemDrive% -allCritical -quiet

echo.
echo System image backup complete.
pause
