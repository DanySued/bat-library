@echo off
:: RegistryBackup.bat - Exports full registry to a file on Desktop
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set TODAY=%%c-%%a-%%b
set DEST=%UserProfile%\Desktop

echo RegistryBackup - Exporting Windows Registry
echo Destination: %DEST%
echo.
echo This will take 1-3 minutes. File size: ~200-500 MB.
echo.

echo Exporting HKEY_LOCAL_MACHINE...
reg export HKLM "%DEST%\RegistryBackup_%TODAY%_HKLM.reg" /y

echo Exporting HKEY_CURRENT_USER...
reg export HKCU "%DEST%\RegistryBackup_%TODAY%_HKCU.reg" /y

echo.
echo Registry backup complete!
echo Files saved to Desktop:
echo   RegistryBackup_%TODAY%_HKLM.reg
echo   RegistryBackup_%TODAY%_HKCU.reg
echo.
echo To restore: double-click the .reg file and confirm the merge.
echo WARNING: Restoring reverts ALL registry changes since this backup.
pause
