@echo off
:: ============================================================
::  SwitchToEnglish.bat
::  Switches Windows display language from Hebrew to English
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause
    exit /b
)

echo.
echo  =====================================================
echo   Switching Windows Language to English (US)
echo  =====================================================
echo.

:: ============================================================
:: STEP 1 — Install English language pack via PowerShell
:: ============================================================
echo [1/4] Installing English language pack...
powershell -Command "Install-Language en-US -CopyToSettings" >nul 2>&1
powershell -Command "Install-Language en-US" >nul 2>&1
echo    Done.

:: ============================================================
:: STEP 2 — Set English as the system UI language
:: ============================================================
echo [2/4] Setting English as system display language...

reg add "HKCU\Control Panel\Desktop" /v "PreferredUILanguages" /t REG_MULTI_SZ /d "en-US" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "PreferredUILanguagesPending" /t REG_MULTI_SZ /d "en-US" /f >nul
reg add "HKCU\Control Panel\International\User Profile" /v "Languages" /t REG_MULTI_SZ /d "en-US" /f >nul
reg add "HKCU\Control Panel\International\User Profile System Backup" /v "Languages" /t REG_MULTI_SZ /d "en-US" /f >nul

:: Set locale and region to English US
reg add "HKCU\Control Panel\International" /v "Locale" /t REG_SZ /d "00000409" /f >nul
reg add "HKCU\Control Panel\International" /v "LocaleName" /t REG_SZ /d "en-US" /f >nul
reg add "HKCU\Control Panel\International" /v "sLanguage" /t REG_SZ /d "ENU" /f >nul
reg add "HKCU\Control Panel\International" /v "sCountry" /t REG_SZ /d "United States" /f >nul

echo    Done.

:: ============================================================
:: STEP 3 — Apply language settings system-wide via PowerShell
::          (covers login screen, new users, system accounts)
:: ============================================================
echo [3/4] Applying language settings system-wide...

powershell -Command ^
  "$langList = New-WinUserLanguageList 'en-US'; ^
   $langList[0].Handwriting = $true; ^
   Set-WinUserLanguageList $langList -Force" >nul 2>&1

powershell -Command "Set-WinSystemLocale -SystemLocale en-US" >nul 2>&1
powershell -Command "Set-WinUILanguageOverride -Language en-US" >nul 2>&1
powershell -Command "Set-WinHomeLocation -GeoId 244" >nul 2>&1
powershell -Command "Set-Culture en-US" >nul 2>&1

:: Copy settings to system (login screen + new users)
powershell -Command ^
  "$xmlContent = @'
<gs:GlobalizationServices xmlns:gs=""urn:longhornxmlnamespaces:globalization"">
  <gs:UserList>
    <gs:User UserID=""Current"" CopySettingsToDefaultUserAcct=""true"" CopySettingsToSystemAcct=""true""/>
  </gs:UserList>
  <gs:MUILanguagePreferences>
    <gs:MUILanguage Value=""en-US""/>
    <gs:MUIFallback Value=""en-US""/>
  </gs:MUILanguagePreferences>
  <gs:SystemLocale Name=""en-US""/>
  <gs:InputPreferences>
    <gs:InputLanguageID Action=""add"" ID=""0409:00000409""/>
    <gs:InputLanguageID Action=""remove"" ID=""040D:0002040D""/>
  </gs:InputPreferences>
  <gs:UserLocale>
    <gs:Locale Name=""en-US"" SetAsCurrent=""true"" ResetAllSettings=""false""/>
  </gs:UserLocale>
</gs:GlobalizationServices>
'@
$xmlContent | Out-File -FilePath '$env:TEMP\lang.xml' -Encoding UTF8" >nul 2>&1

control.exe intl.cpl,,/f:"%TEMP%\lang.xml" >nul 2>&1

echo    Done.

:: ============================================================
:: STEP 4 — Remove Hebrew from language list
:: ============================================================
echo [4/4] Removing Hebrew from language list...

powershell -Command ^
  "$list = Get-WinUserLanguageList; ^
   $list = $list | Where-Object { $_.LanguageTag -ne 'he' -and $_.LanguageTag -ne 'he-IL' }; ^
   Set-WinUserLanguageList $list -Force" >nul 2>&1

echo    Done.

echo.
echo  =====================================================
echo   Language switch complete!
echo.
echo   Windows will be in English after you restart.
echo   The login screen and all system menus will
echo   switch to English on next boot.
echo.
echo   Note: your keyboard layout (Hebrew/English toggle)
echo   is not affected — only the Windows UI language.
echo.
echo   Restarting in 15 seconds...
echo   Press Ctrl+C to cancel and restart manually.
echo  =====================================================
echo.
timeout /t 15
shutdown /r /t 0
