@echo off
:: RemoveFeedbackHub.bat - Uninstalls Windows Feedback Hub
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

powershell -Command "Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage"
echo Done. Feedback Hub has been removed.
pause
