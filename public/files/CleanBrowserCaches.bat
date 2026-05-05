@echo off
:: CleanBrowserCaches.bat - Clears cache for Chrome, Edge, and Firefox

echo Please close all browsers before continuing.
pause

echo Clearing Google Chrome cache...
del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache\*" >nul 2>&1

echo Clearing Microsoft Edge cache...
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Code Cache\*" >nul 2>&1

echo Clearing Mozilla Firefox cache...
for /d %%p in ("%AppData%\Mozilla\Firefox\Profiles\*") do (
    del /f /s /q "%%p\cache2\*" >nul 2>&1
)

echo Done. Browser caches cleared.
echo Passwords, bookmarks, and extensions are NOT affected.
pause
