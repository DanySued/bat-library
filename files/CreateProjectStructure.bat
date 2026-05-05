@echo off
title Create Project Folder Structure

set /p PROJ=Enter project name:
if "%PROJ%"=="" set PROJ=NewProject

set BASE=%USERPROFILE%\Documents\Projects\%PROJ%

echo Creating project structure at %BASE%...

mkdir "%BASE%"
mkdir "%BASE%\src"
mkdir "%BASE%\docs"
mkdir "%BASE%\assets"
mkdir "%BASE%\assets\images"
mkdir "%BASE%\assets\fonts"
mkdir "%BASE%\output"
mkdir "%BASE%\tests"
mkdir "%BASE%\.vscode"

echo # %PROJ% > "%BASE%\README.md"
echo. >> "%BASE%\README.md"
echo Created on %date% >> "%BASE%\README.md"

echo. > "%BASE%\.gitignore"

echo.
echo Project structure created at %BASE%
explorer "%BASE%"
pause
