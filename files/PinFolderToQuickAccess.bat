@echo off
title Pin Folder to Quick Access

set /p FOLDER=Enter full folder path to pin (or Enter for Documents):
if "%FOLDER%"=="" set FOLDER=%USERPROFILE%\Documents

if not exist "%FOLDER%" (
    echo Folder not found: %FOLDER%
    pause
    exit /b 1
)

echo Pinning %FOLDER% to Quick Access...
PowerShell -Command "$shell = New-Object -ComObject Shell.Application; $folder = $shell.Namespace('%FOLDER%'); $folder.Self.InvokeVerb('pintohome')"

echo.
echo Folder pinned to Quick Access in File Explorer.
pause
