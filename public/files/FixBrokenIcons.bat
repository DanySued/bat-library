@echo off
:: FixBrokenIcons.bat - Rebuilds Windows icon cache to fix blank or wrong icons
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Rebuilding icon cache...
echo Your taskbar will briefly disappear - this is normal.
echo.

taskkill /f /im explorer.exe >nul 2>&1

del /f /q /a "%LocalAppData%\IconCache.db" >nul 2>&1
del /f /q /a "%LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db" >nul 2>&1
del /f /q /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

ie4uinit.exe -show >nul 2>&1

start explorer.exe

echo.
echo Icon cache rebuilt. Explorer is restarting.
echo Icons will repopulate as you browse folders.
timeout /t 3 /nobreak >nul
