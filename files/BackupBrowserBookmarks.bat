@echo off
title Backup Browser Bookmarks

set DEST=%USERPROFILE%\Desktop\BookmarksBackup
if not exist "%DEST%" mkdir "%DEST%"

echo Backing up Chrome bookmarks...
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Bookmarks" (
    copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Bookmarks" "%DEST%\Chrome_Bookmarks.json" >nul
    echo Chrome bookmarks saved.
)

echo Backing up Edge bookmarks...
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Bookmarks" (
    copy "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Bookmarks" "%DEST%\Edge_Bookmarks.json" >nul
    echo Edge bookmarks saved.
)

echo Backing up Firefox bookmarks...
if exist "%APPDATA%\Mozilla\Firefox\Profiles" (
    for /D %%P in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
        if exist "%%P\places.sqlite" (
            copy "%%P\places.sqlite" "%DEST%\Firefox_places.sqlite" >nul
            echo Firefox bookmarks saved.
        )
    )
)

echo Backing up Brave bookmarks...
if exist "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Bookmarks" (
    copy "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Bookmarks" "%DEST%\Brave_Bookmarks.json" >nul
    echo Brave bookmarks saved.
)

echo.
echo Bookmarks backed up to %DEST%
pause
