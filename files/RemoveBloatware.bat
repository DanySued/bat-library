@echo off
title Remove Bloatware
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Removing common Windows bloatware apps...

powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *king.com* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *CandyCrush* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *BubbleWitch* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.BingSports* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.BingFinance* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.BingTravel* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage -ErrorAction SilentlyContinue"

echo.
echo Bloatware removed. Reinstall any apps you want from the Microsoft Store.
pause
