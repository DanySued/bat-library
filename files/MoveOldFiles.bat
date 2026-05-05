@echo off
title Move Old Files to Archive

set /p SOURCE=Enter source folder (or Enter for Downloads):
if "%SOURCE%"=="" set SOURCE=%USERPROFILE%\Downloads

set /p DAYS=Move files older than how many days? (default 90):
if "%DAYS%"=="" set DAYS=90

set ARCHIVE=%SOURCE%\Archive_OlderThan%DAYS%Days

if not exist "%ARCHIVE%" mkdir "%ARCHIVE%"

echo Moving files older than %DAYS% days from %SOURCE%...
forfiles /P "%SOURCE%" /D -%DAYS% /C "cmd /c if @isdir==FALSE move @path \"%ARCHIVE%\"" >nul 2>&1

echo.
echo Old files moved to %ARCHIVE%
pause
