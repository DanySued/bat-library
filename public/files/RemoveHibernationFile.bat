@echo off
:: RemoveHibernationFile.bat - Disables hibernation and deletes hiberfil.sys
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Disabling hibernation...
powercfg /h off

echo hiberfil.sys has been deleted by Windows automatically.
echo Sleep mode still works normally.
echo.
echo Freed disk space: approximately 40-75%% of your RAM size.
pause
