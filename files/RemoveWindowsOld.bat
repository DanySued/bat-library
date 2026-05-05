@echo off
title Remove Windows.old
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo This will permanently remove the Windows.old folder (previous Windows installation).
echo You will NOT be able to roll back to the previous Windows version after this.
echo.
set /p confirm=Type YES to continue:
if /i not "%confirm%"=="YES" (echo Cancelled. & pause & exit /b 0)

echo Configuring Disk Cleanup for Previous Windows Installations...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations" /v "StateFlags0001" /t REG_DWORD /d 2 /f >nul

echo Running Disk Cleanup (this may take a few minutes)...
cleanmgr /sagerun:1

echo.
echo Windows.old folder removed. You cannot roll back to the previous version.
pause
