@echo off
:: SwitchToEnglish.bat - Switches Windows display language to English (US)
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo SwitchToEnglish - Set Windows display language to English (United States)
echo Requires internet connection to download the language pack.
echo.

echo Installing English (US) language pack...
powershell -Command "Install-Language en-US" 2>nul

if %errorlevel% neq 0 (
    echo Trying alternative install method...
    lpksetup /i en-US /r /s /p "%SystemRoot%\System32\oobe" >nul 2>&1
)

echo Setting English as display language...
powershell -Command "Set-WinUILanguageOverride -Language en-US" >nul 2>&1
powershell -Command "Set-WinSystemLocale -SystemLocale en-US" >nul 2>&1
powershell -Command "Set-Culture -CultureInfo en-US" >nul 2>&1

echo Setting keyboard to English...
powershell -Command "Set-WinUserLanguageList -LanguageList en-US -Force" >nul 2>&1

echo Setting regional formats to US...
powershell -Command "Set-WinHomeLocation -GeoId 244" >nul 2>&1

echo.
echo Language settings applied.
echo YOU MUST LOG OUT AND LOG BACK IN for the display language to change.
echo.
set /p LOGOUT=Log out now? (Y/N):
if /i "%LOGOUT%"=="Y" logoff
pause
