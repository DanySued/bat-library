@echo off
:: SetCustomWallpaper.bat - Sets a wallpaper from a file path
:: EDIT: Set your image path below
set IMAGE=C:\Users\%USERNAME%\Pictures\wallpaper.jpg

if not exist "%IMAGE%" (
    echo Image not found: %IMAGE%
    echo Edit this script and set IMAGE to your wallpaper path.
    pause
    exit /b
)

reg add "HKCU\Control Panel\Desktop" /v "Wallpaper" /t REG_SZ /d "%IMAGE%" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "WallpaperStyle" /t REG_SZ /d "10" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "TileWallpaper" /t REG_SZ /d "0" /f >nul

powershell -Command "Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class W{[DllImport(\"user32.dll\")]public static extern bool SystemParametersInfo(int a,int b,string c,int d);}'; [W]::SystemParametersInfo(20,0,'%IMAGE%',3)" >nul 2>&1

echo Wallpaper set to: %IMAGE%
