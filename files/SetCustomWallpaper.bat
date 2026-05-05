@echo off
title Set Custom Wallpaper

echo Set a custom desktop wallpaper.
echo.
set /p IMGPATH=Enter full path to image file:

if not exist "%IMGPATH%" (
    echo File not found: %IMGPATH%
    pause
    exit /b 1
)

echo Setting wallpaper...
PowerShell -Command ^
  "Add-Type -TypeDefinition @'" ^
  "using System; using System.Runtime.InteropServices;" ^
  "public class Wallpaper {" ^
  "  [DllImport(\"user32.dll\", CharSet=CharSet.Auto)] public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);" ^
  "}" ^
  "'@; [Wallpaper]::SystemParametersInfo(20, 0, '%IMGPATH%', 3)"

reg add "HKCU\Control Panel\Desktop" /v "WallpaperStyle" /t REG_SZ /d "10" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "TileWallpaper" /t REG_SZ /d "0" /f >nul

echo.
echo Wallpaper set to %IMGPATH%
pause
