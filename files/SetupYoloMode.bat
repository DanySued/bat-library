@echo off
title Setup YOLO Mode for Claude Code
echo Setting up YOLO Mode (bypass permission prompts) for Claude Code...
echo.

:: Check Claude Code is installed
where claude >nul 2>&1
if errorlevel 1 (
    echo ERROR: Claude Code is not installed or not in PATH.
    echo Run InstallClaudeCode.bat first.
    pause
    exit /b 1
)

:: Locate the Claude settings directory
set SETTINGS_DIR=%USERPROFILE%\.claude
set SETTINGS_FILE=%SETTINGS_DIR%\settings.json

if not exist "%SETTINGS_DIR%" (
    mkdir "%SETTINGS_DIR%"
)

:: Write settings.json with dangerouslySkipPermissions enabled
echo Writing Claude Code settings...
(
echo {
echo   "dangerouslySkipPermissions": true
echo }
) > "%SETTINGS_FILE%"

echo.
echo YOLO Mode enabled!
echo Claude Code will no longer ask for permission before running tools.
echo.
echo Settings written to: %SETTINGS_FILE%
echo.
echo To disable YOLO Mode, delete the file above or set:
echo   "dangerouslySkipPermissions": false
echo.
pause
