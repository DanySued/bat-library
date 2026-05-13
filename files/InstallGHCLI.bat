@echo off
title Install GitHub CLI (gh)
echo Installing GitHub CLI for use with Claude Code...
echo.

:: Check if gh is already installed
where gh >nul 2>&1
if not errorlevel 1 (
    echo GitHub CLI is already installed.
    gh --version
    echo.
    echo Authenticating with GitHub...
    gh auth login
    goto done
)

:: Try winget first (Windows 11 / updated Windows 10)
where winget >nul 2>&1
if not errorlevel 1 (
    echo Using winget to install GitHub CLI...
    winget install --id GitHub.cli --accept-source-agreements --accept-package-agreements
    goto auth
)

:: Fallback: try choco
where choco >nul 2>&1
if not errorlevel 1 (
    echo Using Chocolatey to install GitHub CLI...
    choco install gh -y
    goto auth
)

echo ERROR: Neither winget nor Chocolatey found.
echo Please install gh manually from https://cli.github.com
pause
exit /b 1

:auth
echo.
echo Verifying installation...
where gh >nul 2>&1
if errorlevel 1 (
    echo Installation may have failed. Restart your terminal and try again.
    pause
    exit /b 1
)
gh --version
echo.
echo Authenticating with GitHub...
gh auth login

:done
echo.
echo GitHub CLI is ready. Claude Code can now use gh commands.
echo.
pause
