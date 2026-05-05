@echo off
title Enable Night Light

echo Enabling Night Light (blue light filter)...
PowerShell -Command ^
  "$data = [byte[]](0x43,0x42,0x01,0x00,0x0A,0x02,0x01,0x00,0x2A,0x06,0xCF,0xEA,0xD2,0x3F,0x0C,0x00);" ^
  "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default$windows.data.bluelightreduction.bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate' -Name 'Data' -Value $data -Type Binary -Force" >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default$windows.data.bluelightreduction.settings\windows.data.bluelightreduction.settings" /v "Data" /t REG_BINARY /d 43420100 /f >nul 2>&1

echo.
echo Night Light enabled. Go to Settings ^> Display to adjust color temperature.
pause
