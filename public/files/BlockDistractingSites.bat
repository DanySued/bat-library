@echo off
:: BlockDistractingSites.bat - Toggle blocking of distracting websites via HOSTS file
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

set HOSTS=%SystemRoot%\System32\drivers\etc\hosts

findstr /c:"0.0.0.0 youtube.com" "%HOSTS%" >nul 2>&1
if %errorlevel%==0 goto UNBLOCK

:BLOCK
echo Blocking distracting sites...
echo. >> "%HOSTS%"
echo # BlockDistractingSites >> "%HOSTS%"
echo 0.0.0.0 youtube.com >> "%HOSTS%"
echo 0.0.0.0 www.youtube.com >> "%HOSTS%"
echo 0.0.0.0 facebook.com >> "%HOSTS%"
echo 0.0.0.0 www.facebook.com >> "%HOSTS%"
echo 0.0.0.0 instagram.com >> "%HOSTS%"
echo 0.0.0.0 www.instagram.com >> "%HOSTS%"
echo 0.0.0.0 twitter.com >> "%HOSTS%"
echo 0.0.0.0 www.twitter.com >> "%HOSTS%"
echo 0.0.0.0 x.com >> "%HOSTS%"
echo 0.0.0.0 www.x.com >> "%HOSTS%"
echo 0.0.0.0 tiktok.com >> "%HOSTS%"
echo 0.0.0.0 www.tiktok.com >> "%HOSTS%"
echo 0.0.0.0 reddit.com >> "%HOSTS%"
echo 0.0.0.0 www.reddit.com >> "%HOSTS%"
echo 0.0.0.0 twitch.tv >> "%HOSTS%"
echo 0.0.0.0 www.twitch.tv >> "%HOSTS%"
echo 0.0.0.0 netflix.com >> "%HOSTS%"
echo 0.0.0.0 www.netflix.com >> "%HOSTS%"
ipconfig /flushdns >nul
echo Sites BLOCKED. Run again to unblock.
pause
exit /b

:UNBLOCK
echo Unblocking distracting sites...
powershell -Command "(Get-Content '%HOSTS%') | Where-Object { $_ -notmatch 'BlockDistractingSites|youtube|facebook|instagram|twitter|tiktok|reddit|twitch|netflix' } | Set-Content '%HOSTS%'"
ipconfig /flushdns >nul
echo Sites UNBLOCKED. Run again to block.
pause
