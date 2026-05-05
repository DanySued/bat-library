@echo off
:: FixSound.bat - Resets Windows audio service and fixes sound issues
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Resetting Windows audio...
echo.

echo Setting audio services to automatic...
sc config audiosrv start= auto >nul 2>&1
sc config AudioEndpointBuilder start= auto >nul 2>&1

echo Stopping audio services...
net stop audiosrv >nul 2>&1
net stop AudioEndpointBuilder >nul 2>&1

timeout /t 2 /nobreak >nul

echo Starting audio services...
net start AudioEndpointBuilder >nul 2>&1
net start audiosrv >nul 2>&1

echo Restarting Windows Audio...
net stop "Windows Audio" >nul 2>&1
net start "Windows Audio" >nul 2>&1

echo.
echo Audio services reset complete.
echo.
echo If sound still doesn't work:
echo   - Check volume mixer (right-click speaker icon)
echo   - Check physical mute buttons on keyboard/speaker
echo   - Try reinstalling audio drivers from device manufacturer
pause
