@echo off
:: RemoveBloatware.bat - Removes common Windows pre-installed bloat apps
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Removing bloatware apps...

powershell -Command "Get-AppxPackage king.com.CandyCrushSaga | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage king.com.CandyCrushFriends | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage king.com.BubbleWitch3Saga | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.Maps | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage SpotifyAB.SpotifyMusic | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage" >nul 2>&1

echo Done. Bloatware apps have been removed.
echo Note: Some may need to be removed from the Microsoft Store separately.
pause
