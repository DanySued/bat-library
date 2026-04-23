@echo off
:: ============================================================
::  BlockDistractingSites.bat
::  Blocks/unblocks distracting websites via HOSTS file
::  Toggle — run once to block, run again to unblock
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)

:: Check if already blocked
findstr /c:"#DISTRACTION_BLOCK" "%WINDIR%\System32\drivers\etc\hosts" >nul 2>&1
if %ERRORLEVEL% EQU 0 goto :UNBLOCK

:BLOCK
echo.
echo  =====================================================
echo   Blocking Distracting Sites
echo  =====================================================
echo.

echo. >> "%WINDIR%\System32\drivers\etc\hosts"
echo #DISTRACTION_BLOCK_START >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.youtube.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 youtube.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.facebook.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 facebook.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.instagram.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 instagram.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.twitter.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 twitter.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.x.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 x.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.tiktok.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 tiktok.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.reddit.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 reddit.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.twitch.tv >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 twitch.tv >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 www.netflix.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 netflix.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo #DISTRACTION_BLOCK_END >> "%WINDIR%\System32\drivers\etc\hosts"

ipconfig /flushdns >nul 2>&1

echo.
echo  =====================================================
echo   SITES ARE NOW BLOCKED
echo   YouTube, Facebook, Instagram, Twitter/X,
echo   TikTok, Reddit, Twitch, Netflix — all blocked.
echo   Run this file again to unblock them.
echo  =====================================================
echo.
pause
goto :EOF

:UNBLOCK
echo.
echo  =====================================================
echo   Unblocking Distracting Sites
echo  =====================================================
echo.

:: Remove the block section from HOSTS
powershell -Command "
$hosts = Get-Content '%WINDIR%\System32\drivers\etc\hosts'
$inBlock = $false
$newHosts = foreach ($line in $hosts) {
    if ($line -match '#DISTRACTION_BLOCK_START') { $inBlock = $true }
    if (-not $inBlock) { $line }
    if ($line -match '#DISTRACTION_BLOCK_END') { $inBlock = $false }
}
$newHosts | Set-Content '%WINDIR%\System32\drivers\etc\hosts'
" >nul 2>&1

ipconfig /flushdns >nul 2>&1

echo.
echo  =====================================================
echo   SITES ARE NOW UNBLOCKED
echo   All websites are accessible again.
echo   Run this file again to re-block them.
echo  =====================================================
echo.
pause
