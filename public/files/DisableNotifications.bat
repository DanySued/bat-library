@echo off
:: DisableNotifications.bat - Turns off all Windows toast notifications
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotification" /t REG_DWORD /d 1 /f >nul

echo Done. All notifications have been disabled.
echo To restore: Settings > System > Notifications > On
