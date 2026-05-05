@echo off
:: OrganizeDownloads.bat - Sorts Downloads folder into subfolders by file type
set DL=%UserProfile%\Downloads

echo Organizing %DL%...

mkdir "%DL%\Images" >nul 2>&1
mkdir "%DL%\Documents" >nul 2>&1
mkdir "%DL%\Videos" >nul 2>&1
mkdir "%DL%\Music" >nul 2>&1
mkdir "%DL%\Archives" >nul 2>&1
mkdir "%DL%\Executables" >nul 2>&1
mkdir "%DL%\Others" >nul 2>&1

for %%f in ("%DL%\*.jpg" "%DL%\*.jpeg" "%DL%\*.png" "%DL%\*.gif" "%DL%\*.bmp" "%DL%\*.webp" "%DL%\*.svg") do move "%%f" "%DL%\Images\" >nul 2>&1
for %%f in ("%DL%\*.pdf" "%DL%\*.doc" "%DL%\*.docx" "%DL%\*.xls" "%DL%\*.xlsx" "%DL%\*.ppt" "%DL%\*.pptx" "%DL%\*.txt" "%DL%\*.csv") do move "%%f" "%DL%\Documents\" >nul 2>&1
for %%f in ("%DL%\*.mp4" "%DL%\*.mkv" "%DL%\*.avi" "%DL%\*.mov" "%DL%\*.wmv" "%DL%\*.flv" "%DL%\*.webm") do move "%%f" "%DL%\Videos\" >nul 2>&1
for %%f in ("%DL%\*.mp3" "%DL%\*.flac" "%DL%\*.wav" "%DL%\*.aac" "%DL%\*.ogg" "%DL%\*.m4a") do move "%%f" "%DL%\Music\" >nul 2>&1
for %%f in ("%DL%\*.zip" "%DL%\*.rar" "%DL%\*.7z" "%DL%\*.tar" "%DL%\*.gz") do move "%%f" "%DL%\Archives\" >nul 2>&1
for %%f in ("%DL%\*.exe" "%DL%\*.msi" "%DL%\*.bat" "%DL%\*.cmd" "%DL%\*.ps1") do move "%%f" "%DL%\Executables\" >nul 2>&1

echo Done. Downloads folder organized into subfolders.
pause
