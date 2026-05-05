@echo off
:: OldFileArchiver.bat - Moves files older than X days to an archive folder
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

setlocal enabledelayedexpansion

echo OldFileArchiver - Move old files to archive
echo.
set /p FOLDER=Enter folder to clean up:
if not exist "%FOLDER%" (echo Folder not found. && pause && exit /b)

set /p DAYS=Archive files older than how many days?:

for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set TODAY=%%c-%%a-%%b
set ARCHIVE=%FOLDER%\_Archive_%TODAY%

echo.
echo Scanning for files older than %DAYS% days...

set COUNT=0
for /f "delims=" %%f in ('forfiles /p "%FOLDER%" /s /d -%DAYS% /c "cmd /c echo @path" 2^>nul') do (
    echo   %%f
    set /a COUNT+=1
)

if %COUNT%==0 (
    echo No files older than %DAYS% days found.
    pause & exit /b
)

echo.
echo Found %COUNT% file(s) to archive.
set /p CONFIRM=Move to %ARCHIVE%? (Y/N):
if /i not "%CONFIRM%"=="Y" exit /b

if not exist "%ARCHIVE%" mkdir "%ARCHIVE%"

for /f "delims=" %%f in ('forfiles /p "%FOLDER%" /s /d -%DAYS% /c "cmd /c echo @path" 2^>nul') do (
    move "%%f" "%ARCHIVE%\" >nul 2>&1
)

echo.
echo Done. %COUNT% file(s) moved to: %ARCHIVE%
pause
