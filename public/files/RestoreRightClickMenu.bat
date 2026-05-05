@echo off
:: RestoreRightClickMenu.bat - Brings back full classic right-click context menu on Windows 11
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Restoring classic Windows 11 right-click context menu...

reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Classic right-click menu restored!
echo Right-click any file or folder to confirm.
echo.
echo To revert: delete the registry key at
echo HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}
timeout /t 3 /nobreak >nul
