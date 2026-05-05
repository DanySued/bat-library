@echo off
title Setup Developer Folder Structure

echo Setting up developer workspace...

set BASE=C:\Dev

mkdir "%BASE%" 2>nul
mkdir "%BASE%\projects" 2>nul
mkdir "%BASE%\tools" 2>nul
mkdir "%BASE%\scripts" 2>nul
mkdir "%BASE%\sandbox" 2>nul
mkdir "%BASE%\resources" 2>nul
mkdir "%BASE%\resources\fonts" 2>nul
mkdir "%BASE%\resources\icons" 2>nul
mkdir "%BASE%\resources\templates" 2>nul

echo Dev workspace created at %BASE%

echo Adding C:\Dev to PATH...
PowerShell -Command "[Environment]::SetEnvironmentVariable('Path', [Environment]::GetEnvironmentVariable('Path','User') + ';C:\Dev\tools', 'User')"

echo.
echo Developer folders created at C:\Dev
explorer "C:\Dev"
pause
