@echo off
:: DarkModeToggle.bat - Toggle Windows dark/light mode

for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme 2^>nul') do set CURRENT=%%a

if "%CURRENT%"=="0x0" (
    echo Switching to Light Mode...
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul
    echo Light Mode enabled.
) else (
    echo Switching to Dark Mode...
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul
    echo Dark Mode enabled.
)

timeout /t 2 /nobreak >nul
