@echo off
title Copy as Path — Keyboard Shortcut (Ctrl+Shift+C)
echo Setting up Ctrl+Shift+C to copy file path in Explorer...
echo.

:: Install AutoHotkey if missing
where autohotkey >nul 2>&1
if errorlevel 1 (
    where winget >nul 2>&1
    if errorlevel 1 (
        echo ERROR: winget not found. Install AutoHotkey manually from https://www.autohotkey.com
        pause
        exit /b 1
    )
    echo AutoHotkey not found. Installing via winget...
    winget install --id AutoHotkey.AutoHotkey --accept-source-agreements --accept-package-agreements
    if errorlevel 1 (
        echo Install failed. Please install AutoHotkey manually from https://www.autohotkey.com
        pause
        exit /b 1
    )
)

:: Write the AHK script
set AHK_FILE=%USERPROFILE%\Scripts\CopyAsPath.ahk
if not exist "%USERPROFILE%\Scripts" mkdir "%USERPROFILE%\Scripts"

(
echo #Requires AutoHotkey v2.0
echo #SingleInstance Force
echo.
echo ; Ctrl+Shift+C — copy path of selected file/folder in Explorer
echo ^+^c:: {
echo     for win in ComObject^("Shell.Application"^).Windows {
echo         try {
echo             sel := win.Document.SelectedItems
echo             if sel.Count ^> 0 {
echo                 A_Clipboard := sel.Item^(0^).Path
echo                 return
echo             }
echo         }
echo     }
echo }
) > "%AHK_FILE%"

:: Add to startup so it runs on every login
set STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
copy /y "%AHK_FILE%" "%STARTUP%\CopyAsPath.ahk" >nul

:: Launch it now
start "" "%AHK_FILE%"

echo.
echo Done!
echo   Hotkey : Ctrl+Shift+C
echo   Script : %AHK_FILE%
echo   Startup: %STARTUP%\CopyAsPath.ahk
echo.
echo Click any file or folder in Explorer, then press Ctrl+Shift+C.
echo The full path is now in your clipboard.
echo.
echo To remove: delete CopyAsPath.ahk from your Startup folder.
echo.
pause
