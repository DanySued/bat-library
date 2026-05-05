@echo off
:: RemoveMixedReality.bat - Uninstalls Windows Mixed Reality
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Removing Mixed Reality Portal...
powershell -Command "Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.Windows.HolographicFirstRun | Remove-AppxPackage" >nul 2>&1

echo Disabling Mixed Reality via registry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Holographic" /v "EnableMixedRealityPortal" /t REG_DWORD /d 0 /f >nul

echo Done. Windows Mixed Reality removed.
pause
