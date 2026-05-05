@echo off
title Set Wallpaper Slideshow

set /p FOLDER=Enter folder with wallpaper images (or Enter for Pictures):
if "%FOLDER%"=="" set FOLDER=%USERPROFILE%\Pictures

if not exist "%FOLDER%" (
    echo Folder not found: %FOLDER%
    pause
    exit /b 1
)

echo Setting up wallpaper slideshow from %FOLDER%...

PowerShell -Command ^
  "Add-Type -TypeDefinition @'" ^
  "using System; using System.Runtime.InteropServices;" ^
  "public class WP { [DllImport(\"user32.dll\")] public static extern bool SystemParametersInfo(int a, int b, string c, int d); }" ^
  "'@;" ^
  "$regPath = 'HKCU:\Control Panel\Desktop';" ^
  "Set-ItemProperty $regPath WallpaperStyle 10;" ^
  "Set-ItemProperty $regPath TileWallpaper 0"

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" /v "BackgroundType" /t REG_DWORD /d 2 /f >nul

echo.
echo For slideshow, go to Settings ^> Personalization ^> Background ^> Slideshow
echo and select: %FOLDER%
echo.
echo Opening Personalization settings...
start ms-settings:personalization-background
pause
