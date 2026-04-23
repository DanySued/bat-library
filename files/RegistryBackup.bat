@echo off
:: ============================================================
::  RegistryBackup.bat
::  Exports your full registry to a file on the Desktop
::  Run this before making any risky system changes
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Registry Backup
echo  =====================================================
echo.

for /f "tokens=2 delims==" %%a in ('wmic OS get LocalDateTime /value') do set "dt=%%a"
set "DATESTR=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%-%dt:~10,2%"
set "OUTFILE=%USERPROFILE%\Desktop\RegistryBackup_%DATESTR%.reg"

echo  This will take a minute or two...
echo  Saving to: %OUTFILE%
echo.

regedit /e "%OUTFILE%"

if exist "%OUTFILE%" (
    echo.
    echo  =====================================================
    echo   Registry backed up successfully!
    echo   File: RegistryBackup_%DATESTR%.reg
    echo   Location: Your Desktop
    echo.
    echo   To restore: double-click the .reg file and
    echo   confirm the import.
    echo  =====================================================
) else (
    echo  [ERROR] Backup may have failed. Try running again.
)
echo.
pause
