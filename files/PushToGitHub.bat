@echo off
title Push to GitHub
cd /d "%~dp0"

:: Check git is available
where git >nul 2>&1
if errorlevel 1 (
    echo ERROR: git is not installed or not in PATH.
    echo Download it from https://git-scm.com
    pause
    exit /b 1
)

:: Check we are inside a git repo
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: This folder is not a git repository.
    echo Run this script from inside a git project.
    pause
    exit /b 1
)

echo Current status:
git status --short
echo.

:: Prompt for commit message
set /p MSG=Enter commit message (leave blank to cancel):
if "%MSG%"=="" (
    echo Cancelled.
    pause
    exit /b 0
)

echo.
echo Staging all changes...
git add -A

echo Committing...
git commit -m "%MSG%"
if errorlevel 1 (
    echo Nothing to commit or commit failed.
    pause
    exit /b 1
)

echo Pushing to origin...
git push
if errorlevel 1 (
    echo Push failed. Check your remote and credentials.
    pause
    exit /b 1
)

echo.
echo Done! Changes pushed to GitHub.
echo.
pause
