@echo off
title Install Claude Code
setlocal enabledelayedexpansion

echo.
echo  ============================================
echo   Claude Code Installer
echo  ============================================
echo.
echo  I'm Dany from the Bat Library
echo.
echo  This script is: "Install Claude Code with automatic
echo  dependency checking and authentication setup"
echo.
echo  The plan is this:
echo.
echo  1. Check if Node.js is installed; if not, offer to download it
echo  2. Check if npm is installed; if missing, prompt to reinstall Node.js
echo  3. Check if Claude Code is already installed; if yes, offer to update
echo  4. If not installed, install Claude Code globally via npm
echo  5. Authenticate with your Anthropic account and complete setup
echo.
echo  ============================================
echo.

:: ─── Check: Node.js ───────────────────────────────────────────────────────────
echo [1/3] Checking Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  ✗ Node.js not found.
    echo.
    echo  Node.js is required to run Claude Code.
    echo  Would you like to open the Node.js download page?
    echo.
    set /p INSTALL_NODE=  Download Node.js now? [Y/N]:
    if /i "!INSTALL_NODE!"=="Y" (
        start https://nodejs.org/en/download
        echo.
        echo  After installing Node.js, re-run this script.
    ) else (
        echo  Skipping. Please install Node.js manually from https://nodejs.org
    )
    echo.
    echo Press any key to close this window...
    pause
    exit /b 1
) else (
    echo  ✓ Node.js found.
)

:: ─── Check: npm ───────────────────────────────────────────────────────────────
echo [2/3] Checking npm...
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  ✗ npm not found. It should ship with Node.js.
    echo  Please reinstall Node.js from https://nodejs.org
    echo.
    echo Press any key to close this window...
    pause
    exit /b 1
) else (
    echo  ✓ npm found.
)

:: ─── Check: existing Claude Code install ──────────────────────────────────────
echo [3/3] Checking for existing Claude Code install...
claude --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%v in ('claude --version 2^>^&1') do set CLAUDE_VER=%%v
    echo  ✓ Claude Code already installed: !CLAUDE_VER!
    echo.
    echo  Would you like to reinstall / update it?
    set /p REINSTALL=  Reinstall? [Y/N]: 
    if /i "!REINSTALL!" neq "Y" (
        echo.
        echo  Skipping install. Running authentication...
        goto :auth
    )
)

:: ─── Install Claude Code globally ─────────────────────────────────────────────
echo.
echo  Installing Claude Code globally via npm...
echo  (This may take a minute)
echo.
npm install -g @anthropic-ai/claude-code
if %errorlevel% neq 0 (
    echo.
    echo  ✗ Installation failed. Common fixes:
    echo    - Run this script as Administrator
    echo    - Check your internet connection
    echo    - Try:  npm install -g @anthropic-ai/claude-code --force
    echo.
    echo Press any key to close this window...
    pause
    exit /b 1
)

echo.
echo  ✓ Claude Code installed globally.

:: ─── Authenticate ─────────────────────────────────────────────────────────────
:auth
echo.
echo  ============================================
echo   Authenticating with Anthropic
echo  ============================================
echo.
echo  This will open your browser to log in with your Anthropic account.
echo  (You need an account at https://claude.ai or https://console.anthropic.com)
echo.
pause

claude auth login
if %errorlevel% neq 0 (
    echo.
    echo  ✗ Authentication failed or was cancelled.
    echo  You can retry any time by running:  claude auth login
    echo.
    echo Press any key to close this window...
    pause
    exit /b 1
)

echo.
echo  ============================================
echo   All done! Claude Code is ready.
echo  ============================================
echo.
echo  To start Claude Code, open any project folder in your terminal and run:
echo.
echo      claude
echo.
echo Press any key to close this window...
pause
