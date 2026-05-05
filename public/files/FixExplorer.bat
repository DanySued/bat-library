@echo off
:: FixExplorer.bat - Opens to This PC, shows extensions, hidden files, removes ads
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Configuring File Explorer settings...

:: Open to This PC instead of Quick Access (1=Quick Access, 2=This PC)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 2 /f >nul

:: Show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul

:: Show hidden files and folders
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul

:: Show protected OS files (optional - commented out for safety)
:: reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f >nul

:: Disable Recent Files in Quick Access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f >nul

:: Disable Frequent Folders in Quick Access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f >nul

:: Remove OneDrive ads and sync notifications from Explorer
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul

:: Restart Explorer to apply changes
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Explorer configured. Changes applied:
echo   - Opens to This PC
echo   - File extensions visible
echo   - Hidden files visible
echo   - Recent/frequent files hidden
echo   - OneDrive sync notifications disabled
pause
