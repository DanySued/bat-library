@echo off
:: WeeklyClean.bat - Silent quick clean: temp files, caches, DNS flush, recycle bin
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo WeeklyClean - Running weekly maintenance...

del /s /q /f "%TEMP%\*.*" >nul 2>&1
rd /s /q "%TEMP%" >nul 2>&1
md "%TEMP%" >nul 2>&1

del /s /q /f "%SystemRoot%\Temp\*.*" >nul 2>&1

del /s /q /f "%SystemRoot%\Prefetch\*.*" >nul 2>&1

rd /s /q "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1
md "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1

powershell -Command "Clear-RecycleBin -Force" >nul 2>&1

ipconfig /flushdns >nul

del /s /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*" >nul 2>&1
del /s /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache\js\*" >nul 2>&1
del /s /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
del /s /q /f "%AppData%\Mozilla\Firefox\Profiles\*.default*\cache2\entries\*" >nul 2>&1

echo Done. Weekly maintenance complete.
pause
