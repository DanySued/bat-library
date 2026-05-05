@echo off
:: EmptyFolderCleaner.bat - Finds and deletes empty folders recursively
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo EmptyFolderCleaner - Remove empty folders
echo.
set /p FOLDER=Enter folder path to clean:
if not exist "%FOLDER%" (echo Folder not found. && pause && exit /b)

echo.
echo Scanning for empty folders in: %FOLDER%
echo.

set COUNT=0
for /f "delims=" %%d in ('dir /s /b /ad "%FOLDER%" 2^>nul') do (
    dir /b "%%d" 2>nul | findstr . >nul || (
        echo Found empty: %%d
        set /a COUNT+=1
    )
)

if %COUNT%==0 (
    echo No empty folders found.
    pause & exit /b
)

echo.
echo Found %COUNT% empty folder(s).
set /p CONFIRM=Delete them all? (Y/N):
if /i not "%CONFIRM%"=="Y" exit /b

:: Run twice to catch nested empty folders
for /f "delims=" %%d in ('dir /s /b /ad "%FOLDER%" 2^>nul') do (
    dir /b "%%d" 2>nul | findstr . >nul || rd "%%d" >nul 2>&1
)
for /f "delims=" %%d in ('dir /s /b /ad "%FOLDER%" 2^>nul') do (
    dir /b "%%d" 2>nul | findstr . >nul || rd "%%d" >nul 2>&1
)

echo.
echo Done. %COUNT% empty folder(s) removed.
pause
