@echo off
:: ClearAllTempFiles.bat - Deep cleans all temp and cache locations
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Clearing user temp folder (%TEMP%)...
del /s /f /q "%TEMP%\*.*" >nul 2>&1
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" >nul 2>&1

echo Clearing user TMP folder (%TMP%)...
del /s /f /q "%TMP%\*.*" >nul 2>&1
for /d %%i in ("%TMP%\*") do rd /s /q "%%i" >nul 2>&1

echo Clearing system temp (C:\Windows\Temp)...
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" >nul 2>&1

echo Clearing Windows Prefetch...
del /s /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1

echo Clearing Windows Update download cache...
net stop wuauserv >nul 2>&1
del /s /f /q "C:\Windows\SoftwareDistribution\Download\*.*" >nul 2>&1
for /d %%i in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%i" >nul 2>&1
net start wuauserv >nul 2>&1

echo Clearing thumbnail cache...
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

echo Flushing DNS cache...
ipconfig /flushdns >nul 2>&1

echo =====================================
echo  All temp files cleared successfully.
echo =====================================
pause
