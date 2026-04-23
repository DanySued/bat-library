@echo off
:: ============================================================
::  EmptyFolderCleaner.bat
::  Finds and deletes all empty folders inside a directory
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Empty Folder Cleaner
echo  =====================================================
echo.

set /p "FOLDER=Enter folder to clean (e.g. C:\Users\Me\Documents): "
if "%FOLDER%"=="" ( echo No path entered. & pause & exit /b )
if not exist "%FOLDER%" ( echo Folder not found. & pause & exit /b )

echo.
echo  Scanning for empty folders in:
echo  %FOLDER%
echo.

set COUNT=0
for /f "delims=" %%d in ('dir /s /b /ad "%FOLDER%" 2^>nul') do (
    rd "%%d" >nul 2>&1
    if not exist "%%d" (
        set /a COUNT+=1
        echo  Deleted: %%d
    )
)

:: Run twice to catch nested empty folders
for /f "delims=" %%d in ('dir /s /b /ad "%FOLDER%" 2^>nul') do (
    rd "%%d" >nul 2>&1
    if not exist "%%d" (
        set /a COUNT+=1
        echo  Deleted: %%d
    )
)

echo.
echo  =====================================================
echo   Done! Removed %COUNT% empty folders.
echo  =====================================================
echo.
pause
