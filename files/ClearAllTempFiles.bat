@echo off
title Clear All Temp Files
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Clearing user temp folder...
del /q /f /s "%TEMP%\*" >nul 2>&1
rd /s /q "%TEMP%" >nul 2>&1
md "%TEMP%" >nul 2>&1

echo Clearing TMP folder...
del /q /f /s "%TMP%\*" >nul 2>&1

echo Clearing Windows system temp...
del /q /f /s "%SystemRoot%\Temp\*" >nul 2>&1

echo Clearing Windows prefetch...
del /q /f /s "%SystemRoot%\Prefetch\*" >nul 2>&1

echo Clearing Windows Update download cache...
net stop wuauserv >nul 2>&1
del /q /f /s "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1

echo Clearing thumbnail cache...
del /q /f /s "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

echo Clearing icon cache...
del /q /f "%LocalAppData%\Microsoft\Windows\Explorer\iconcache*.db" >nul 2>&1

echo Flushing DNS cache...
ipconfig /flushdns >nul

echo.
echo All temp files cleared. Some files in use were skipped — this is normal.
pause
