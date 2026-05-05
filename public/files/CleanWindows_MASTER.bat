@echo off
:: CleanWindows_MASTER.bat - Complete Windows debloat, optimization & privacy (10 phases)
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo ============================================================
echo  CleanWindows MASTER - Complete Windows Debloat Tool
echo  WARNING: This will modify system settings. Back up first!
echo ============================================================
echo.
pause

:: PHASE 1 - Remove bloatware apps
echo [1/10] Removing bloatware apps...
powershell -Command "Get-AppxPackage *xbox* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *xboxapp* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.GamingApp* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *bingweather* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *bingnews* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *bingfinance* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *bingsports* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *cortana* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *mixedreality* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *zunemusic* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *zunevideo* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *getstarted* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *skypeapp* | Remove-AppxPackage" >nul 2>&1
echo    Done.

:: PHASE 2 - Disable unnecessary services
echo [2/10] Disabling unnecessary services...
sc config "DiagTrack" start= disabled >nul 2>&1
sc stop "DiagTrack" >nul 2>&1
sc config "dmwappushservice" start= disabled >nul 2>&1
sc stop "dmwappushservice" >nul 2>&1
sc config "WSearch" start= disabled >nul 2>&1
sc stop "WSearch" >nul 2>&1
sc config "Spooler" start= disabled >nul 2>&1
sc stop "Spooler" >nul 2>&1
sc config "Fax" start= disabled >nul 2>&1
sc config "RemoteRegistry" start= disabled >nul 2>&1
sc config "MapsBroker" start= disabled >nul 2>&1
sc config "lfsvc" start= disabled >nul 2>&1
sc config "XblAuthManager" start= disabled >nul 2>&1
sc config "XblGameSave" start= disabled >nul 2>&1
sc config "XboxNetApiSvc" start= disabled >nul 2>&1
sc config "XboxGipSvc" start= disabled >nul 2>&1
echo    Done.

:: PHASE 3 - Block telemetry in HOSTS file
echo [3/10] Blocking telemetry domains in HOSTS file...
set HOSTS=%SystemRoot%\System32\drivers\etc\hosts
echo. >> "%HOSTS%"
echo 0.0.0.0 vortex.data.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 vortex-win.data.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 telecommand.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 oca.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 sqm.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 watson.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 redir.metaservices.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 choice.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 df.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 reports.wes.df.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 wes.df.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 services.wes.df.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 sqm.df.telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 telemetry.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 watson.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 statsfe2.ws.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 corpext.msitadfs.glbdns2.microsoft.com >> "%HOSTS%"
echo 0.0.0.0 compatexchange.cloudapp.net >> "%HOSTS%"
echo 0.0.0.0 cs1.wpc.v0cdn.net >> "%HOSTS%"
echo 0.0.0.0 a-0001.a-msedge.net >> "%HOSTS%"
echo    Done.

:: PHASE 4 - Disable privacy settings
echo [4/10] Disabling privacy data collection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessLocation /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessCamera /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessMicrophone /t REG_DWORD /d 2 /f >nul
echo    Done.

:: PHASE 5 - Activate Ultimate Performance power plan
echo [5/10] Activating Ultimate Performance power plan...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
for /f "tokens=4" %%i in ('powercfg -list ^| findstr "Ultimate"') do (
    powercfg -setactive %%i >nul 2>&1
)
powercfg -change -standby-timeout-ac 0 >nul
powercfg -change -hibernate-timeout-ac 0 >nul
echo    Done.

:: PHASE 6 - Disable visual effects
echo [6/10] Disabling visual effects and CPU core parking...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 100 /f >nul
echo    Done.

:: PHASE 7 - Set DNS to Cloudflare
echo [7/10] Setting DNS to Cloudflare 1.1.1.1...
for /f "tokens=3*" %%i in ('netsh interface show interface ^| findstr "Connected"') do (
    netsh interface ip set dns "%%j" static 1.1.1.1 >nul 2>&1
    netsh interface ip add dns "%%j" 1.0.0.1 index=2 >nul 2>&1
)
echo    Done.

:: PHASE 8 - Remove startup junk
echo [8/10] Removing startup junk...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Skype" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f >nul 2>&1
schtasks /Change /TN "MicrosoftEdgeUpdateTaskMachineCore" /Disable >nul 2>&1
schtasks /Change /TN "MicrosoftEdgeUpdateTaskMachineUA" /Disable >nul 2>&1
taskkill /f /im OneDrive.exe >nul 2>&1
taskkill /f /im Teams.exe >nul 2>&1
echo    Done.

:: PHASE 9 - Clear temp files and caches
echo [9/10] Clearing temp files, caches, and prefetch...
del /s /q /f "%TEMP%\*.*" >nul 2>&1
rd /s /q "%TEMP%" >nul 2>&1
md "%TEMP%" >nul 2>&1
del /s /q /f "%SystemRoot%\Temp\*.*" >nul 2>&1
del /s /q /f "%SystemRoot%\Prefetch\*.*" >nul 2>&1
del /s /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*" >nul 2>&1
del /s /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
ipconfig /flushdns >nul
echo    Done.

:: PHASE 10 - Disk optimization and system file check
echo [10/10] Running system file check and disk optimization...
sfc /scannow >nul 2>&1
defrag C: /U /V >nul 2>&1
echo    Done.

echo.
echo ============================================================
echo  All 10 phases complete! PC will restart in 30 seconds.
echo  Press Ctrl+C to cancel restart.
echo ============================================================
shutdown /r /t 30 /c "CleanWindows MASTER complete. Restarting..."
pause
