@echo off
:: BulkRenamer.bat - Rename files in a folder with prefix, suffix, numbers, or replace
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo BulkRenamer - Rename Files in Bulk
echo.
set /p FOLDER=Enter folder path containing files to rename:
if not exist "%FOLDER%" (echo Folder not found. && pause && exit /b)

echo.
echo Choose rename mode:
echo   1. Add prefix to filenames
echo   2. Add suffix before extension
echo   3. Add sequential numbers (001, 002...)
echo   4. Replace text in filenames
echo.
set /p MODE=Enter mode (1-4):

if "%MODE%"=="1" goto PREFIX
if "%MODE%"=="2" goto SUFFIX
if "%MODE%"=="3" goto NUMBER
if "%MODE%"=="4" goto REPLACE
echo Invalid option. && pause && exit /b

:PREFIX
set /p PRE=Enter prefix text:
echo.
echo Preview:
for %%f in ("%FOLDER%\*.*") do echo   %%~nxf  ->  %PRE%%%~nxf
echo.
set /p CONFIRM=Apply changes? (Y/N):
if /i not "%CONFIRM%"=="Y" exit /b
for %%f in ("%FOLDER%\*.*") do ren "%%f" "%PRE%%%~nxf"
echo Done! Files renamed with prefix "%PRE%".
pause & exit /b

:SUFFIX
set /p SUF=Enter suffix text (added before extension):
echo.
echo Preview:
for %%f in ("%FOLDER%\*.*") do echo   %%~nxf  ->  %%~nf%SUF%%%~xf
echo.
set /p CONFIRM=Apply changes? (Y/N):
if /i not "%CONFIRM%"=="Y" exit /b
for %%f in ("%FOLDER%\*.*") do ren "%%f" "%%~nf%SUF%%%~xf"
echo Done! Files renamed with suffix "%SUF%".
pause & exit /b

:NUMBER
set COUNT=0
echo.
echo Preview (first 5):
set PREV=0
for %%f in ("%FOLDER%\*.*") do (
    set /a PREV+=1
    if !PREV! leq 5 echo   %%~nxf  ->  00!PREV!_%%~nxf
)
echo.
set /p CONFIRM=Apply changes? (Y/N):
if /i not "%CONFIRM%"=="Y" exit /b
setlocal enabledelayedexpansion
set N=0
for %%f in ("%FOLDER%\*.*") do (
    set /a N+=1
    set NUM=00!N!
    set NUM=!NUM:~-3!
    ren "%%f" "!NUM!_%%~nxf"
)
echo Done! Files numbered sequentially.
pause & exit /b

:REPLACE
set /p OLD=Enter text to find:
set /p NEW=Enter replacement text:
echo.
echo Preview:
for %%f in ("%FOLDER%\*.*") do (
    set "NAME=%%~nxf"
    setlocal enabledelayedexpansion
    echo   %%~nxf  ->  !NAME:%OLD%=%NEW%!
    endlocal
)
echo.
set /p CONFIRM=Apply changes? (Y/N):
if /i not "%CONFIRM%"=="Y" exit /b
for %%f in ("%FOLDER%\*.*") do (
    set "NAME=%%~nxf"
    setlocal enabledelayedexpansion
    ren "%%f" "!NAME:%OLD%=%NEW%!"
    endlocal
)
echo Done! Text replaced in all filenames.
pause
