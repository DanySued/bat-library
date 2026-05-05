@echo off
title Set Custom Cursor Scheme

echo Available cursor schemes:
echo  1. Windows Black (high contrast)
echo  2. Windows Inverted
echo  3. Windows Default (reset)
echo.
set /p CHOICE=Choose scheme (1-3):

if "%CHOICE%"=="1" (
    reg add "HKCU\Control Panel\Cursors" /ve /t REG_SZ /d "Windows Black" /f >nul
    reg add "HKCU\Control Panel\Cursors" /v "Arrow" /t REG_EXPAND_SZ /d "%%SystemRoot%%\cursors\aero_arrow.cur" /f >nul
)
if "%CHOICE%"=="2" (
    reg add "HKCU\Control Panel\Cursors" /ve /t REG_SZ /d "Windows Inverted" /f >nul
)
if "%CHOICE%"=="3" (
    reg delete "HKCU\Control Panel\Cursors" /f >nul 2>&1
    reg add "HKCU\Control Panel\Cursors" /ve /t REG_SZ /d "Windows Default" /f >nul
)

echo Applying cursor scheme...
PowerShell -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class CursorRefresh { [DllImport(\"user32.dll\")] public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni); }'; [CursorRefresh]::SystemParametersInfo(0x0057, 0, [IntPtr]::Zero, 0x01)"

echo.
echo Cursor scheme applied. You may need to re-open windows to see the change.
pause
