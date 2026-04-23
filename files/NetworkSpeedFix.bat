@echo off
:: ============================================================
::  NetworkSpeedFix.bat
::  Resets entire network stack when internet feels slow,
::  drops, or is acting strange
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Network Speed Fix
echo  =====================================================
echo.

echo [1/6] Releasing IP address...
ipconfig /release >nul 2>&1

echo [2/6] Flushing DNS cache...
ipconfig /flushdns >nul 2>&1

echo [3/6] Resetting Winsock...
netsh winsock reset >nul 2>&1

echo [4/6] Resetting TCP/IP stack...
netsh int ip reset >nul 2>&1
netsh int ipv4 reset >nul 2>&1
netsh int tcp reset >nul 2>&1

echo [5/6] Resetting firewall and proxy...
netsh winhttp reset proxy >nul 2>&1
netsh advfirewall reset >nul 2>&1

echo [6/6] Renewing IP address...
ipconfig /renew >nul 2>&1
ipconfig /registerdns >nul 2>&1

echo.
echo  =====================================================
echo   Network reset complete!
echo   Your connection should be faster and stable.
echo   A restart is recommended for full effect.
echo  =====================================================
echo.
pause
