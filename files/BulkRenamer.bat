@echo off
:: ============================================================
::  BulkRenamer.bat
::  Renames all files in a folder — add prefix, suffix,
::  number them sequentially, or replace text in names
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Bulk File Renamer
echo  =====================================================
echo.

set /p "FOLDER=Enter folder path (e.g. C:\Users\Me\Pictures): "
if "%FOLDER%"=="" ( echo No path entered. & pause & exit /b )
if not exist "%FOLDER%" ( echo Folder not found. & pause & exit /b )

echo.
echo  What would you like to do?
echo.
echo   1. Add a PREFIX to all file names
echo      (e.g. "Vacation_" makes: Vacation_photo1.jpg)
echo.
echo   2. Add a SUFFIX to all file names
echo      (e.g. "_2024" makes: photo1_2024.jpg)
echo.
echo   3. NUMBER all files sequentially
echo      (e.g. File_001.jpg, File_002.jpg...)
echo.
echo   4. REPLACE text in file names
echo      (e.g. replace "IMG_" with "Photo_")
echo.
set /p "CHOICE=Enter choice (1/2/3/4): "

if "%CHOICE%"=="1" goto :PREFIX
if "%CHOICE%"=="2" goto :SUFFIX
if "%CHOICE%"=="3" goto :NUMBER
if "%CHOICE%"=="4" goto :REPLACE
echo  Invalid choice. & pause & exit /b

:PREFIX
set /p "PRE=Enter prefix to add: "
echo.
echo  Renaming files in: %FOLDER%
for %%f in ("%FOLDER%\*.*") do (
    if not "%%~nxf"=="%~nx0" (
        ren "%%f" "%PRE%%%~nxf" >nul 2>&1
        echo  Renamed: %%~nxf  ->  %PRE%%%~nxf
    )
)
goto :DONE

:SUFFIX
set /p "SUF=Enter suffix to add (before extension): "
echo.
echo  Renaming files in: %FOLDER%
for %%f in ("%FOLDER%\*.*") do (
    if not "%%~nxf"=="%~nx0" (
        ren "%%f" "%%~nf%SUF%%%~xf" >nul 2>&1
        echo  Renamed: %%~nxf  ->  %%~nf%SUF%%%~xf
    )
)
goto :DONE

:NUMBER
set /p "BASE=Enter base name (e.g. Photo): "
set /p "EXT=Enter file extension to rename (e.g. jpg or * for all): "
echo.
echo  Renaming files in: %FOLDER%
set COUNT=0
for %%f in ("%FOLDER%\*.%EXT%") do (
    set /a COUNT+=1
    setlocal enabledelayedexpansion
    set "NUM=00!COUNT!"
    set "NUM=!NUM:~-3!"
    ren "%%f" "%BASE%_!NUM!%%~xf" >nul 2>&1
    echo  Renamed: %%~nxf  ->  %BASE%_!NUM!%%~xf
    endlocal
)
goto :DONE

:REPLACE
set /p "OLD=Text to find: "
set /p "NEW=Replace with: "
echo.
echo  Renaming files in: %FOLDER%
for %%f in ("%FOLDER%\*.*") do (
    setlocal enabledelayedexpansion
    set "FNAME=%%~nxf"
    set "NEWNAME=!FNAME:%OLD%=%NEW%!"
    if not "!FNAME!"=="!NEWNAME!" (
        ren "%%f" "!NEWNAME!" >nul 2>&1
        echo  Renamed: !FNAME!  ->  !NEWNAME!
    )
    endlocal
)
goto :DONE

:DONE
echo.
echo  =====================================================
echo   Bulk rename complete!
echo  =====================================================
echo.
pause
