@echo off
:: BackupBrowserBookmarks.bat - Copies Chrome, Edge, Firefox bookmarks to Desktop

set DEST=%UserProfile%\Desktop\BookmarksBackup
mkdir "%DEST%" >nul 2>&1

echo Backing up Google Chrome bookmarks...
if exist "%LocalAppData%\Google\Chrome\User Data\Default\Bookmarks" (
    copy "%LocalAppData%\Google\Chrome\User Data\Default\Bookmarks" "%DEST%\Chrome_Bookmarks" >nul
    echo Chrome: Done
) else echo Chrome: Not found

echo Backing up Microsoft Edge bookmarks...
if exist "%LocalAppData%\Microsoft\Edge\User Data\Default\Bookmarks" (
    copy "%LocalAppData%\Microsoft\Edge\User Data\Default\Bookmarks" "%DEST%\Edge_Bookmarks" >nul
    echo Edge: Done
) else echo Edge: Not found

echo Backing up Firefox bookmarks...
for /d %%p in ("%AppData%\Mozilla\Firefox\Profiles\*") do (
    if exist "%%p\places.sqlite" (
        copy "%%p\places.sqlite" "%DEST%\Firefox_places.sqlite" >nul
        echo Firefox: Done
    )
)

echo.
echo Bookmarks backed up to Desktop\BookmarksBackup
pause
