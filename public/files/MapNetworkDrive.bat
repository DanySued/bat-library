@echo off
:: MapNetworkDrive.bat - Maps a network share as a persistent drive letter
:: EDIT: Set your network path and drive letter below
set DRIVE=Z:
set PATH_NET=\\SERVER\SharedFolder

echo Mapping %PATH_NET% as %DRIVE%...
net use %DRIVE% %PATH_NET% /persistent:yes

if %errorlevel%==0 (
    echo Success. Drive %DRIVE% mapped to %PATH_NET%
    start explorer %DRIVE%
) else (
    echo Failed. Check the network path and that you have access.
)
pause
