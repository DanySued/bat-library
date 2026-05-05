@echo off
title Clean Desktop

set DESK=%USERPROFILE%\Desktop
set ARCHIVE=%DESK%\DesktopArchive_%date:~-4,4%%date:~-10,2%%date:~-7,2%

echo Moving all non-shortcut files from Desktop to archive folder...
if not exist "%ARCHIVE%" mkdir "%ARCHIVE%"

for %%F in ("%DESK%\*.*") do (
    if /i not "%%~xF"==".lnk" (
        if /i not "%%~xF"==".url" (
            move "%%F" "%ARCHIVE%\" >nul 2>&1
        )
    )
)

echo.
echo Desktop cleaned. Files moved to %ARCHIVE%
pause
