@echo off
title Remove OneDrive
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Killing OneDrive process...
taskkill /f /im OneDrive.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo Uninstalling OneDrive...
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
) else if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
) else (
    echo OneDrive installer not found - may already be removed.
)

echo Removing OneDrive from Explorer sidebar...
reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1

echo Disabling OneDrive via Group Policy...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul

echo Removing OneDrive from startup...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1

echo Cleaning up leftover folders...
rd /s /q "%UserProfile%\OneDrive" >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft OneDrive" >nul 2>&1

echo.
echo OneDrive has been removed. Files already synced to cloud are not deleted.
pause
