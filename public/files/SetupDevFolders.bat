@echo off
:: SetupDevFolders.bat - Creates a standard developer folder structure on C:
mkdir "C:\Dev" >nul 2>&1
mkdir "C:\Dev\Projects" >nul 2>&1
mkdir "C:\Dev\Tools" >nul 2>&1
mkdir "C:\Dev\Scripts" >nul 2>&1
mkdir "C:\Dev\Sandbox" >nul 2>&1

echo Projects go here. > "C:\Dev\Projects\README.txt"
echo Local tools and binaries. > "C:\Dev\Tools\README.txt"
echo Automation and utility scripts. > "C:\Dev\Scripts\README.txt"
echo Quick experiments and throwaway code. > "C:\Dev\Sandbox\README.txt"

echo Dev folder structure created at C:\Dev
start explorer "C:\Dev"
