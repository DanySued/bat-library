@echo off
title Find Large Files

set /p FOLDER=Search in folder (or Enter for C:\):
if "%FOLDER%"=="" set FOLDER=C:\

set /p SIZE=Larger than how many MB? (default 500):
if "%SIZE%"=="" set SIZE=500

set DEST=%USERPROFILE%\Desktop\LargeFiles_Report.txt
set /a BYTES=%SIZE%*1048576

echo Searching for files larger than %SIZE% MB in %FOLDER%...
echo This may take a few minutes.

echo Large Files Report - %date% %time% > "%DEST%"
echo Folder: %FOLDER% >> "%DEST%"
echo Min size: %SIZE% MB >> "%DEST%"
echo. >> "%DEST%"

PowerShell -Command "Get-ChildItem -Path '%FOLDER%' -Recurse -ErrorAction SilentlyContinue | Where-Object {$_.Length -gt %BYTES%} | Sort-Object Length -Descending | Select-Object FullName, @{N='SizeMB';E={[math]::Round($_.Length/1MB,2)}} | Format-Table -AutoSize" >> "%DEST%" 2>nul

echo.
echo Report saved to %DEST%
notepad "%DEST%"
pause
