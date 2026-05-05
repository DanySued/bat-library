@echo off
:: EnableNightLight.bat - Turns on Windows Night Light
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default$windows.data.bluelightreduction.bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate" /v "Data" /t REG_BINARY /d 4300000000000000C2FDEA3D6602000000000000 /f >nul 2>&1

powershell -Command "Start-Process ms-settings:nightlight" >nul 2>&1

echo Night Light settings opened. Toggle it on from the Settings page.
echo Or use Quick Settings (Win+A) to toggle Night Light instantly.
