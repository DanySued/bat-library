@echo off
:: SetWallpaperSlideshow.bat - Sets up a wallpaper slideshow from a folder
:: EDIT: Set your wallpaper folder below
set FOLDER=C:\Users\%USERNAME%\Pictures\Wallpapers

if not exist "%FOLDER%" (
    echo Folder not found: %FOLDER%
    echo Edit this script with the path to your wallpaper folder.
    pause
    exit /b
)

reg add "HKCU\Control Panel\Desktop" /v "Wallpaper" /t REG_SZ /d "" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "WallpaperStyle" /t REG_SZ /d "10" /f >nul

powershell -Command ^
  "$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers'; " ^
  "if (!(Test-Path $key)) { New-Item $key -Force }; " ^
  "Set-ItemProperty $key 'BackgroundType' 2; " ^
  "Set-ItemProperty $key 'SlideshowSourcePath' '%FOLDER%'; " ^
  "Set-ItemProperty $key 'ImagesRootPath' '%FOLDER%'; " ^
  "Set-ItemProperty $key 'Interval' 1800000; " ^
  "Set-ItemProperty $key 'Shuffle' 1"

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Wallpaper slideshow set to: %FOLDER%
echo Rotating every 30 minutes with shuffle enabled.
