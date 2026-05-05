@echo off
:: FixSlowRightClick.bat - Removes broken shell extensions causing right-click lag
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

setlocal enabledelayedexpansion
set LOG=%UserProfile%\Desktop\RightClickFixLog.txt
set COUNT=0

echo Scanning for broken shell extension handlers...
echo Results saved to: %LOG%
echo.

echo FixSlowRightClick - Removed broken shell extensions > "%LOG%"
echo Date: %date% %time% >> "%LOG%"
echo. >> "%LOG%"

for /f "tokens=*" %%k in ('reg query "HKCR\CLSID" /s /f "InprocServer32" /k 2^>nul') do (
    for /f "tokens=3" %%v in ('reg query "%%k\InprocServer32" /ve 2^>nul') do (
        set "DLL=%%v"
        set "DLL=!DLL:%%SystemRoot%%=%SystemRoot%!"
        if not "!DLL!"=="" (
            if not exist "!DLL!" (
                echo Removing broken handler: %%k >> "%LOG%"
                echo   Missing DLL: !DLL! >> "%LOG%"
                reg delete "%%k" /f >nul 2>&1
                set /a COUNT+=1
            )
        )
    )
)

echo Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo Done. Removed %COUNT% broken shell extension(s).
echo Log saved to Desktop\RightClickFixLog.txt
echo.
echo Right-click any file to test - it should appear instantly now.
pause
