@echo off
title Copy as Path — Right-Click Shortcut Setup
echo Adding "Copy as Path" to your right-click menu...
echo.

:: Add for files
reg add "HKCU\Software\Classes\*\shell\Copy as Path"         /ve /d "Copy as Path"                                              /f >nul
reg add "HKCU\Software\Classes\*\shell\Copy as Path"         /v "Icon" /d "shell32.dll,259"                                    /f >nul
reg add "HKCU\Software\Classes\*\shell\Copy as Path\command" /ve /d "cmd /c echo.|set /p=\"%1\"| clip"                         /f >nul

:: Add for folders
reg add "HKCU\Software\Classes\Directory\shell\Copy as Path"         /ve /d "Copy as Path"                                     /f >nul
reg add "HKCU\Software\Classes\Directory\shell\Copy as Path"         /v "Icon" /d "shell32.dll,259"                            /f >nul
reg add "HKCU\Software\Classes\Directory\shell\Copy as Path\command" /ve /d "cmd /c echo.|set /p=\"%1\"| clip"                 /f >nul

:: Add for folder background (right-click inside a folder)
reg add "HKCU\Software\Classes\Directory\Background\shell\Copy as Path"         /ve /d "Copy as Path"                         /f >nul
reg add "HKCU\Software\Classes\Directory\Background\shell\Copy as Path"         /v "Icon" /d "shell32.dll,259"                /f >nul
reg add "HKCU\Software\Classes\Directory\Background\shell\Copy as Path\command" /ve /d "cmd /c echo.|set /p=\"%V\"| clip"     /f >nul

echo.
echo Done! Right-click any file or folder to use "Copy as Path".
echo No restart needed — open a new File Explorer window to see it.
echo.
echo To remove it, run this command:
echo   reg delete "HKCU\Software\Classes\*\shell\Copy as Path" /f
echo   reg delete "HKCU\Software\Classes\Directory\shell\Copy as Path" /f
echo   reg delete "HKCU\Software\Classes\Directory\Background\shell\Copy as Path" /f
echo.
pause
