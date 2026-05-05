@echo off
title Change Accent Color

echo Available accent colors:
echo  1. Blue (default)
echo  2. Purple
echo  3. Pink
echo  4. Red
echo  5. Orange
echo  6. Yellow
echo  7. Green
echo  8. Teal
echo.
set /p CHOICE=Choose color (1-8):

if "%CHOICE%"=="1" set COLOR=0xFFB4901B
if "%CHOICE%"=="2" set COLOR=0xFF744DA9
if "%CHOICE%"=="3" set COLOR=0xFFE3008C
if "%CHOICE%"=="4" set COLOR=0xFFE81224
if "%CHOICE%"=="5" set COLOR=0xFFDA3B01
if "%CHOICE%"=="6" set COLOR=0xFFFFB900
if "%CHOICE%"=="7" set COLOR=0xFF107C10
if "%CHOICE%"=="8" set COLOR=0xFF00B7C3
if "%COLOR%"=="" set COLOR=0xFFB4901B

echo Applying accent color...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "AccentColorMenu" /t REG_DWORD /d %COLOR% /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d %COLOR% /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "AccentColor" /t REG_DWORD /d %COLOR% /f >nul

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Accent color applied.
pause
