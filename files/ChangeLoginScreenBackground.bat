@echo off
title Change Login Screen Background
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

set /p IMGPATH=Enter full path to image file (JPG, max ~256KB recommended):

if not exist "%IMGPATH%" (
    echo File not found: %IMGPATH%
    pause
    exit /b 1
)

echo Enabling custom login background...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "LockScreenImage" /t REG_SZ /d "%IMGPATH%" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 0 /f >nul

rem Copy to system OEM background location
if not exist "%SystemRoot%\System32\oobe\info\backgrounds" mkdir "%SystemRoot%\System32\oobe\info\backgrounds"
copy "%IMGPATH%" "%SystemRoot%\System32\oobe\info\backgrounds\backgroundDefault.jpg" >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background" /v "OEMBackground" /t REG_DWORD /d 1 /f >nul

echo.
echo Login screen background set. Changes take effect at next lock/login.
pause
