@echo off
title Map Network Drive

echo Map a Network Drive
echo.
set /p LETTER=Drive letter to use (e.g. Z):
set /p PATH=Network path (e.g. \\server\share):
set /p USER=Username (leave blank for current user):

if "%LETTER%"=="" set LETTER=Z
if "%PATH%"=="" (
    echo No path entered. Exiting.
    pause
    exit /b 1
)

if "%USER%"=="" (
    net use %LETTER%: "%PATH%" /persistent:yes
) else (
    set /p PASS=Password:
    net use %LETTER%: "%PATH%" /user:"%USER%" "%PASS%" /persistent:yes
)

if %errorlevel% equ 0 (
    echo Drive mapped as %LETTER%:
) else (
    echo Failed to map drive. Check path and credentials.
)
pause
