@echo off
setlocal enabledelayedexpansion

:: PushAndDeploy.bat - Automates Git push to trigger Vercel deployment
:: Inspired by the BAT Library aesthetic

echo.
echo  =========================================
echo       BAT LIBRARY - PUSH ^& DEPLOY
echo  =========================================
echo.

:: Check if git is installed
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in PATH.
    pause
    exit /b
)

:: Get current branch name
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD') do set BRANCH=%%i

echo [STATUS] Current branch: !BRANCH!
echo [STATUS] Checking for changes...
echo.

:: Show status
git status -s

:: Ask user for commit message
echo.
set /p COMMIT_MSG="Enter commit message (or press Enter for 'Updates'): "
if "!COMMIT_MSG!"=="" set COMMIT_MSG=Updates

echo.
echo [PROCESS] Adding changes...
git add .

echo [PROCESS] Committing changes...
git commit -m "!COMMIT_MSG!"

echo [PROCESS] Pushing to GitHub (!BRANCH!)...
git push origin !BRANCH!

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Push failed. Check your internet connection or git permissions.
    pause
    exit /b
)

echo.
echo  =========================================
echo       SUCCESS: CHANGES PUSHED
echo  =========================================
echo.
echo  Your site is now being built by Vercel.
echo  Live site: https://bat-library.vercel.app
echo.
echo  Press any key to exit.
pause >nul
