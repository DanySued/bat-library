@echo off
title Disable Notifications

echo Disabling Windows notifications...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 0 /f >nul

echo Disabling notification banners and sounds...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableBalloonTips" /t REG_DWORD /d 0 /f >nul

echo Disabling Focus Assist auto-rules...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\^^windows.data.notifications.quiethourssettings\Current" /v "Data" /t REG_BINARY /d 02000000 /f >nul 2>&1

echo.
echo Notifications disabled.
pause
