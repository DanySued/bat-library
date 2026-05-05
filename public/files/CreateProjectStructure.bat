@echo off
:: CreateProjectStructure.bat - Creates a standard project folder structure
set /p PROJNAME="Enter project name: "
set BASE=%UserProfile%\Documents\Projects\%PROJNAME%

mkdir "%BASE%" >nul 2>&1
mkdir "%BASE%\src" >nul 2>&1
mkdir "%BASE%\docs" >nul 2>&1
mkdir "%BASE%\assets" >nul 2>&1
mkdir "%BASE%\output" >nul 2>&1
mkdir "%BASE%\archive" >nul 2>&1

echo # %PROJNAME% > "%BASE%\README.txt"

echo Project structure created at:
echo %BASE%
start explorer "%BASE%"
