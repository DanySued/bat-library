@echo off
title Backup Documents to USB

echo Looking for USB drives...
set DEST=
for %%D in (E F G H I J K) do (
    if exist %%D:\ (
        set DEST=%%D:\Backup
        goto :found
    )
)
echo No USB drive found. Please insert a USB drive and try again.
pause
exit /b 1

:found
echo Backing up to %DEST%...
if not exist "%DEST%" mkdir "%DEST%"

robocopy "%USERPROFILE%\Documents" "%DEST%\Documents" /MIR /Z /W:0 /R:2 >nul
robocopy "%USERPROFILE%\Desktop" "%DEST%\Desktop" /MIR /Z /W:0 /R:2 >nul
robocopy "%USERPROFILE%\Pictures" "%DEST%\Pictures" /MIR /Z /W:0 /R:2 >nul
robocopy "%USERPROFILE%\Downloads" "%DEST%\Downloads" /MIR /Z /W:0 /R:2 >nul

echo.
echo Backup complete to %DEST%.
pause
