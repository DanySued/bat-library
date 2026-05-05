@echo off
:: ClearRecentActivity.bat - Wipes jump lists, recent files, search history, clipboard
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Clearing Windows activity history...
echo.

echo Clearing jump lists...
del /s /q /f "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
del /s /q /f "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*" >nul 2>&1

echo Clearing recent files from Quick Access...
del /s /q /f "%AppData%\Microsoft\Windows\Recent\*" >nul 2>&1

echo Clearing clipboard...
powershell -Command "Set-Clipboard -Value ''" >nul 2>&1

echo Clearing Windows search history...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery" /f >nul 2>&1

echo Clearing thumbnail cache...
taskkill /f /im explorer.exe >nul 2>&1
del /s /q /f "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
start explorer.exe

echo Clearing Edge typed URLs...
reg delete "HKCU\Software\Microsoft\Internet Explorer\TypedURLs" /f >nul 2>&1

echo.
echo Activity history cleared successfully.
pause
