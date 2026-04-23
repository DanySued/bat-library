@echo off
:: ============================================================
::  CleanWindows_MASTER.bat
::  Complete Windows Debloat, Optimization & Privacy Script
::  Combines ALL steps — Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click this file and choose "Run as administrator"
    pause
    exit /b
)

echo.
echo  =====================================================
echo   CleanWindows MASTER — Full Clean + Optimize
echo   This will take several minutes. Do NOT close.
echo  =====================================================
echo.
echo  Press any key to begin...
pause >nul

:: ============================================================
:: PHASE 1 — REMOVE BLOATWARE
:: ============================================================
echo.
echo ============================================================
echo  PHASE 1 — Removing Bloatware
echo ============================================================

echo  [1/1] Removing Xbox...
powershell -Command "Get-AppxPackage *Xbox* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *XboxApp* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *XboxGameCallableUI* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *XboxIdentityProvider* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *XboxGameBar* | Remove-AppxPackage -ErrorAction SilentlyContinue"

echo  [1/2] Removing games...
powershell -Command "Get-AppxPackage *MicrosoftSolitaireCollection* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.Mahjong* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.MicrosoftMinesweeper* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *CandyCrush* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *BubbleWitch* | Remove-AppxPackage -ErrorAction SilentlyContinue"

echo  [1/3] Removing Bing apps, Weather, Maps, Cortana...
powershell -Command "Get-AppxPackage *BingWeather* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *BingNews* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *BingFinance* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *BingSports* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *WindowsMaps* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage -ErrorAction SilentlyContinue"

echo  [1/4] Removing 3D and Mixed Reality...
powershell -Command "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.3DBuilder* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *MixedReality* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *HolographicFirstRun* | Remove-AppxPackage -ErrorAction SilentlyContinue"

echo  [1/5] Removing communication and office junk...
powershell -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.CommsPhone* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.ConnectivityStore* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *MicrosoftTeams* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *SpotifyAB* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Dell* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Samsung* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *Duolingo* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *EclipseManager* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *ActiproSoftware* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppxPackage *AdobeSystemsIncorporated* | Remove-AppxPackage -ErrorAction SilentlyContinue"
echo  Done.

:: ============================================================
:: PHASE 2 — DISABLE SERVICES
:: ============================================================
echo.
echo ============================================================
echo  PHASE 2 — Disabling Unnecessary Services
echo ============================================================

echo  Disabling Xbox services...
sc stop XblAuthManager >nul 2>&1
sc config XblAuthManager start=disabled >nul 2>&1
sc stop XblGameSave >nul 2>&1
sc config XblGameSave start=disabled >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1
sc config XboxNetApiSvc start=disabled >nul 2>&1
sc stop XboxGipSvc >nul 2>&1
sc config XboxGipSvc start=disabled >nul 2>&1

echo  Disabling Windows Search indexing...
sc stop WSearch >nul 2>&1
sc config WSearch start=disabled >nul 2>&1

echo  Disabling SysMain / Superfetch...
sc stop SysMain >nul 2>&1
sc config SysMain start=disabled >nul 2>&1

echo  Disabling Print Spooler...
sc stop Spooler >nul 2>&1
sc config Spooler start=disabled >nul 2>&1

echo  Disabling Fax...
sc stop Fax >nul 2>&1
sc config Fax start=disabled >nul 2>&1

echo  Disabling Remote Registry...
sc stop RemoteRegistry >nul 2>&1
sc config RemoteRegistry start=disabled >nul 2>&1

echo  Disabling Windows Error Reporting...
sc stop WerSvc >nul 2>&1
sc config WerSvc start=disabled >nul 2>&1

echo  Disabling telemetry relay services...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1

echo  Disabling Maps Manager...
sc stop MapsBroker >nul 2>&1
sc config MapsBroker start=disabled >nul 2>&1

echo  Disabling misc unused services...
sc stop NetTcpPortSharing >nul 2>&1
sc config NetTcpPortSharing start=disabled >nul 2>&1
sc stop RetailDemo >nul 2>&1
sc config RetailDemo start=disabled >nul 2>&1
sc stop TabletInputService >nul 2>&1
sc config TabletInputService start=disabled >nul 2>&1
sc stop TermService >nul 2>&1
sc config TermService start=disabled >nul 2>&1
sc stop bthserv >nul 2>&1
sc config bthserv start=disabled >nul 2>&1
sc stop BluetoothUserService >nul 2>&1
echo  Done.

:: ============================================================
:: PHASE 3 — PRIVACY & TELEMETRY
:: ============================================================
echo.
echo ============================================================
echo  PHASE 3 — Privacy and Telemetry Lockdown
echo ============================================================

echo  Disabling telemetry data collection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul

echo  Disabling location, camera, microphone access...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f >nul

echo  Disabling advertising ID and Wi-Fi Sense...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 0 /f >nul

echo  Disabling typing and input data collection...
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f >nul

echo  Disabling notifications, feedback, activity history...
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f >nul

echo  Blocking Microsoft telemetry domains in HOSTS file...
echo. >> "%WINDIR%\System32\drivers\etc\hosts"
echo # === Microsoft Telemetry Block (CleanWindows MASTER) === >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 vortex.data.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 vortex-win.data.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 telecommand.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 telecommand.telemetry.microsoft.com.nsatc.net >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 oca.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 oca.telemetry.microsoft.com.nsatc.net >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 sqm.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 sqm.telemetry.microsoft.com.nsatc.net >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 watson.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 watson.telemetry.microsoft.com.nsatc.net >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 settings-sandbox.data.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 reports.wes.df.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 wes.df.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 services.wes.df.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 sqm.df.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 watson.ppe.telemetry.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 statsfe2.update.microsoft.com.akadns.net >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 diagnostics.support.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 feedback.windows.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo 0.0.0.0 survey.watson.microsoft.com >> "%WINDIR%\System32\drivers\etc\hosts"
echo # ======================================================= >> "%WINDIR%\System32\drivers\etc\hosts"
echo  Done.

:: ============================================================
:: PHASE 4 — POWER & PERFORMANCE
:: ============================================================
echo.
echo ============================================================
echo  PHASE 4 — Power and Performance
echo ============================================================

echo  Activating Ultimate Performance power plan...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
for /f "tokens=4" %%G in ('powercfg -list ^| findstr /i "Ultimate"') do (
    powercfg -setactive %%G >nul 2>&1
)
powercfg -setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg -setacvalueindex scheme_current 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0 >nul 2>&1
powercfg -setactive scheme_current >nul 2>&1

echo  Disabling CPU core parking and power throttling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul

echo  Disabling visual effects and animations...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9012038010000000 /f >nul
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d 1 /f >nul

echo  Disabling GameDVR and Game Bar...
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul
echo  Done.

:: ============================================================
:: PHASE 5 — STARTUP & RAM
:: ============================================================
echo.
echo ============================================================
echo  PHASE 5 — Startup and RAM Optimization
echo ============================================================

echo  Removing junk from startup...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Skype" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul

echo  Disabling Edge preload and startup boost...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul

echo  Disabling Prefetcher and Superfetch in registry...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f >nul

echo  Setting boot timeout to 3 seconds...
bcdedit /set bootmenupolicy standard >nul 2>&1
bcdedit /timeout 3 >nul 2>&1

echo  Tuning virtual memory...
wmic computersystem set AutomaticManagedPagefile=False >nul 2>&1
wmic pagefileset delete >nul 2>&1
wmic pagefileset create name="C:\pagefile.sys" >nul 2>&1
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=8192 >nul 2>&1

echo  Scheduling standby RAM flush on login...
schtasks /create /tn "ClearStandbyRAM" /tr "rundll32.exe advapi32.dll,ProcessIdleTasks" /sc onlogon /ru SYSTEM /f >nul 2>&1
echo  Done.

:: ============================================================
:: PHASE 6 — NETWORK
:: ============================================================
echo.
echo ============================================================
echo  PHASE 6 — Network Optimization
echo ============================================================

echo  Setting DNS to Cloudflare 1.1.1.1 on all adapters...
for /f "tokens=*" %%i in ('netsh interface show interface ^| findstr /i "connected" ^| findstr /v "Loopback"') do (
    for /f "tokens=4" %%j in ("%%i") do (
        netsh interface ipv4 set dns name="%%j" static 1.1.1.1 primary >nul 2>&1
        netsh interface ipv4 add dns name="%%j" 8.8.8.8 index=2 >nul 2>&1
    )
)

echo  Disabling P2P Windows Update sharing...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul

echo  Removing 20 percent bandwidth reservation...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d 0 /f >nul

echo  Tuning TCP settings...
netsh interface tcp set global autotuninglevel=normal >nul 2>&1
netsh interface tcp set global timestamps=enabled >nul 2>&1

echo  Flushing DNS and resetting network...
ipconfig /flushdns >nul
netsh winsock reset >nul 2>&1
echo  Done.

:: ============================================================
:: PHASE 7 — TELEMETRY SCHEDULED TASKS
:: ============================================================
echo.
echo ============================================================
echo  PHASE 7 — Disabling Telemetry Scheduled Tasks
echo ============================================================

schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Clip\License Validation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WDI\ResolutionHost" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Subscription\EnableLicenseAcquisition" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Subscription\LicenseAcquisition" /Disable >nul 2>&1
echo  Done.

:: ============================================================
:: PHASE 8 — EDGE CLEANUP
:: ============================================================
echo.
echo ============================================================
echo  PHASE 8 — Microsoft Edge Cleanup
echo ============================================================

echo  Disabling Edge telemetry, news feed, shopping, Bing...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "SendSiteInfoToImproveServices" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageQuickLinksEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "AddressBarMicrosoftSearchInBingProviderEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HardwareAccelerationModeEnabled" /t REG_DWORD /d 0 /f >nul

echo  Removing Edge from startup...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
powershell -Command "Get-ScheduledTask | Where-Object {$_.TaskName -like '*MicrosoftEdge*'} | Disable-ScheduledTask -ErrorAction SilentlyContinue" >nul 2>&1

echo  Clearing Edge cache...
taskkill /f /im msedge.exe >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache\*.*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache\*.*" >nul 2>&1
echo  Done.

:: ============================================================
:: PHASE 9 — CLEAN ALL TEMPORARY FILES
:: ============================================================
echo.
echo ============================================================
echo  PHASE 9 — Cleaning Temporary Files
echo ============================================================

echo  Wiping Windows Temp...
del /s /f /q "%WINDIR%\Temp\*.*" >nul 2>&1
rd /s /q "%WINDIR%\Temp" >nul 2>&1
md "%WINDIR%\Temp" >nul 2>&1

echo  Wiping User Temp...
del /s /f /q "%TEMP%\*.*" >nul 2>&1
rd /s /q "%TEMP%" >nul 2>&1
md "%TEMP%" >nul 2>&1

echo  Wiping Prefetch...
del /s /f /q "%WINDIR%\Prefetch\*.*" >nul 2>&1

echo  Wiping browser caches...
del /s /f /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.default\cache2\*.*" >nul 2>&1

echo  Clearing Recent Documents and thumbnails...
del /s /f /q "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

echo  Clearing Windows Update download cache...
net stop wuauserv >nul 2>&1
del /s /f /q "%WINDIR%\SoftwareDistribution\Download\*.*" >nul 2>&1
net start wuauserv >nul 2>&1

echo  Running Disk Cleanup...
cleanmgr /sagerun:1 >nul 2>&1
echo  Done.

:: ============================================================
:: PHASE 10 — DISK HEALTH
:: ============================================================
echo.
echo ============================================================
echo  PHASE 10 — Disk Health Check
echo ============================================================

echo  Running SSD TRIM...
defrag C: /U /V /H >nul 2>&1

echo  Running System File Checker (sfc /scannow)...
sfc /scannow

echo  Running DISM health restore...
DISM /Online /Cleanup-Image /RestoreHealth

echo  Scheduling chkdsk on next reboot...
echo Y | chkdsk C: /f /r /x >nul 2>&1
echo  Done.

:: ============================================================
:: FINAL — AUTO RESTART
:: ============================================================
echo.
echo  =====================================================
echo   ALL DONE — MASTER CLEAN COMPLETE
echo.
echo   Summary of everything done:
echo.
echo   REMOVED:
echo     Xbox, Solitaire, Mahjong, Minesweeper, Candy Crush
echo     Weather, News, Finance, Cortana, Bing apps
echo     Skype, Teams, 3D Viewer, Mixed Reality
echo     OneDrive + Edge from startup
echo.
echo   DISABLED SERVICES:
echo     Search Index, SysMain, Print Spooler, Fax
echo     Remote Registry, Error Reporting
echo     Bluetooth, Remote Desktop, Telemetry relay
echo.
echo   PRIVACY:
echo     Location, Camera, Microphone — blocked
echo     Advertising ID, Wi-Fi Sense — off
echo     Typing data collection — off
echo     20+ telemetry domains blocked in HOSTS
echo     25 telemetry scheduled tasks — disabled
echo.
echo   PERFORMANCE:
echo     Ultimate Performance power plan — active
echo     CPU core parking + throttling — disabled
echo     Animations — off, Menu delay — 0ms
echo     GameDVR — off
echo.
echo   NETWORK:
echo     DNS set to Cloudflare 1.1.1.1
echo     P2P update sharing — off
echo     20 percent bandwidth reservation — removed
echo.
echo   EDGE:
echo     Startup boost, news feed, shopping,
echo     Bing, telemetry — all disabled
echo.
echo   CLEANED:
echo     Windows Temp, User Temp, Prefetch
echo     Browser caches, Recent files, Thumbnails
echo     Windows Update download cache
echo.
echo   DISK:
echo     SFC scan done, DISM repair done
echo     SSD TRIM done, chkdsk scheduled for boot
echo.
echo   Restarting in 30 seconds...
echo   Press Ctrl+C to cancel the restart.
echo  =====================================================
echo.
timeout /t 30
shutdown /r /t 0
