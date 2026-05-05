@echo off
title Organize Downloads Folder

set SRC=%USERPROFILE%\Downloads

echo Organizing Downloads folder by file type...

if not exist "%SRC%\Images" mkdir "%SRC%\Images"
if not exist "%SRC%\Documents" mkdir "%SRC%\Documents"
if not exist "%SRC%\Videos" mkdir "%SRC%\Videos"
if not exist "%SRC%\Music" mkdir "%SRC%\Music"
if not exist "%SRC%\Archives" mkdir "%SRC%\Archives"
if not exist "%SRC%\Installers" mkdir "%SRC%\Installers"
if not exist "%SRC%\Other" mkdir "%SRC%\Other"

for %%F in ("%SRC%\*.jpg" "%SRC%\*.jpeg" "%SRC%\*.png" "%SRC%\*.gif" "%SRC%\*.bmp" "%SRC%\*.webp" "%SRC%\*.svg") do (
    if exist "%%F" move "%%F" "%SRC%\Images\" >nul 2>&1
)
for %%F in ("%SRC%\*.pdf" "%SRC%\*.doc" "%SRC%\*.docx" "%SRC%\*.xls" "%SRC%\*.xlsx" "%SRC%\*.ppt" "%SRC%\*.pptx" "%SRC%\*.txt") do (
    if exist "%%F" move "%%F" "%SRC%\Documents\" >nul 2>&1
)
for %%F in ("%SRC%\*.mp4" "%SRC%\*.mkv" "%SRC%\*.avi" "%SRC%\*.mov" "%SRC%\*.wmv") do (
    if exist "%%F" move "%%F" "%SRC%\Videos\" >nul 2>&1
)
for %%F in ("%SRC%\*.mp3" "%SRC%\*.wav" "%SRC%\*.flac" "%SRC%\*.aac") do (
    if exist "%%F" move "%%F" "%SRC%\Music\" >nul 2>&1
)
for %%F in ("%SRC%\*.zip" "%SRC%\*.rar" "%SRC%\*.7z" "%SRC%\*.tar" "%SRC%\*.gz") do (
    if exist "%%F" move "%%F" "%SRC%\Archives\" >nul 2>&1
)
for %%F in ("%SRC%\*.exe" "%SRC%\*.msi" "%SRC%\*.msix") do (
    if exist "%%F" move "%%F" "%SRC%\Installers\" >nul 2>&1
)

echo.
echo Downloads folder organized into subfolders.
pause
