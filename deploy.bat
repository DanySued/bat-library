@echo off
setlocal enabledelayedexpansion
REM Batch file for pushing and deploying to GitHub
REM Repository: https://github.com/DanySued/bat-library.git

echo.
echo ========================================
echo Git Push and Deploy Script
echo ========================================
echo.

REM Change to the script's directory
cd /d "%~dp0"
echo Working directory: %cd%
echo.

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo Error: Git is not installed or not in PATH
    pause
    exit /b 1
)

REM Show current git status
echo Checking git status...
git status
echo.

REM Ask for commit message
set /p commit_message="Enter commit message: "

if "!commit_message!"=="" (
    echo Error: Commit message cannot be empty
    pause
    exit /b 1
)

REM Add all changes
echo.
echo Adding all changes...
git add .
if errorlevel 1 (
    echo Error: Failed to add changes
    pause
    exit /b 1
)

REM Commit changes with proper escaping
echo Committing changes...
echo Commit message: !commit_message!
git commit -m "!commit_message!"
if errorlevel 1 (
    echo Error: Failed to commit. You may have no changes to commit.
    pause
    exit /b 1
)

REM Push to GitHub
echo.
echo Pushing to GitHub...
git push origin HEAD
if errorlevel 1 (
    echo Error: Failed to push to GitHub
    echo Make sure you have push access and your credentials are configured
    pause
    exit /b 1
)

REM Success message
echo.
echo ========================================
echo Successfully pushed to GitHub!
echo ========================================
echo.

REM Show latest commit
echo Latest commit on GitHub:
git log -1 --oneline
echo.
REM Also show the full commit details to verify
git log -1
echo.

pause
