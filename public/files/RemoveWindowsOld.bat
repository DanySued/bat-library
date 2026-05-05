@echo off
:: RemoveWindowsOld.bat - Removes the Windows.old folder after OS upgrades
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo This will delete C:\Windows.old and reclaim disk space.
echo After removal, you CANNOT roll back to your previous Windows version.
echo.
set /p confirm="Are you sure? (Y/N): "
if /i not "%confirm%"=="Y" goto :cancel

echo Running Disk Cleanup to remove previous Windows installations...
cleanmgr /sageset:65535 & cleanmgr /sagerun:65535 >nul 2>&1

:: Alternative direct approach
takeown /F "C:\Windows.old" /R /A /D Y >nul 2>&1
icacls "C:\Windows.old" /grant Administrators:F /T /C /Q >nul 2>&1
rd /s /q "C:\Windows.old" >nul 2>&1

echo Done. Windows.old has been removed.
goto :end

:cancel
echo Cancelled.

:end
pause
