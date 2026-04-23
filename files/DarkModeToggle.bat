@echo off
:: ============================================================
::  DarkModeToggle.bat
::  Toggles Windows dark/light mode with one double-click
::  No admin needed
:: ============================================================
echo.
echo  =====================================================
echo   Dark Mode Toggle
echo  =====================================================
echo.

:: Check current mode
for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" 2^>nul') do set "current=%%a"

if "%current%"=="0x0" (
    echo  Currently: DARK — switching to LIGHT...
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 1 /f >nul
    echo  Switched to LIGHT mode.
) else (
    echo  Currently: LIGHT — switching to DARK...
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f >nul
    echo  Switched to DARK mode.
)

echo.
echo  Done! Changes apply immediately.
echo.
timeout /t 2 >nul
