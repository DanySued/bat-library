@echo off
:: ============================================================
::  GameSavesBackup.bat
::  Backs up save files from common game locations
::  Steam, Epic, Ubisoft, GOG, EA, Minecraft, and more
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Game Saves Backup
echo  =====================================================
echo.

for /f "tokens=2 delims==" %%a in ('wmic OS get LocalDateTime /value') do set "dt=%%a"
set "DATESTR=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%"

set /p "DEST=Enter backup destination (e.g. D:\GameBackup): "
if "%DEST%"=="" (
    echo  No path entered. Exiting.
    pause & exit /b
)

set "OUTDIR=%DEST%\GameSavesBackup_%DATESTR%"
md "%OUTDIR%" >nul 2>&1

echo.
echo  Backing up game saves to: %OUTDIR%
echo.

echo  [Steam] Backing up...
if exist "%USERPROFILE%\AppData\Local\Steam" (
    robocopy "%USERPROFILE%\AppData\Local\Steam\userdata" "%OUTDIR%\Steam" /E /Z /NP /R:1 /W:1
)
if exist "C:\Program Files (x86)\Steam\userdata" (
    robocopy "C:\Program Files (x86)\Steam\userdata" "%OUTDIR%\Steam" /E /Z /NP /R:1 /W:1
)

echo  [Minecraft Java] Backing up...
if exist "%APPDATA%\.minecraft\saves" (
    robocopy "%APPDATA%\.minecraft\saves" "%OUTDIR%\Minecraft_Java" /E /Z /NP /R:1 /W:1
)

echo  [Minecraft Bedrock] Backing up...
if exist "%LOCALAPPDATA%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds" (
    robocopy "%LOCALAPPDATA%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds" "%OUTDIR%\Minecraft_Bedrock" /E /Z /NP /R:1 /W:1
)

echo  [Epic Games] Backing up...
if exist "%LOCALAPPDATA%\EpicGamesLauncher\Saved" (
    robocopy "%LOCALAPPDATA%\EpicGamesLauncher\Saved" "%OUTDIR%\EpicGames" /E /Z /NP /R:1 /W:1
)

echo  [Ubisoft Connect] Backing up...
if exist "%USERPROFILE%\Documents\My Games\Ubisoft" (
    robocopy "%USERPROFILE%\Documents\My Games\Ubisoft" "%OUTDIR%\Ubisoft" /E /Z /NP /R:1 /W:1
)
if exist "%LOCALAPPDATA%\Ubisoft Game Launcher\savegames" (
    robocopy "%LOCALAPPDATA%\Ubisoft Game Launcher\savegames" "%OUTDIR%\Ubisoft_saves" /E /Z /NP /R:1 /W:1
)

echo  [EA / Origin] Backing up...
if exist "%USERPROFILE%\Documents\EA Games" (
    robocopy "%USERPROFILE%\Documents\EA Games" "%OUTDIR%\EA_Games" /E /Z /NP /R:1 /W:1
)

echo  [GOG Galaxy] Backing up...
if exist "%USERPROFILE%\AppData\Local\GOG.com\Galaxy\Applications" (
    robocopy "%USERPROFILE%\AppData\Local\GOG.com\Galaxy\Applications" "%OUTDIR%\GOG" /E /Z /NP /R:1 /W:1
)

echo  [My Games folder] Backing up...
if exist "%USERPROFILE%\Documents\My Games" (
    robocopy "%USERPROFILE%\Documents\My Games" "%OUTDIR%\MyGames" /E /Z /NP /R:1 /W:1
)

echo  [Saved Games folder] Backing up...
if exist "%USERPROFILE%\Saved Games" (
    robocopy "%USERPROFILE%\Saved Games" "%OUTDIR%\SavedGames" /E /Z /NP /R:1 /W:1
)

echo.
echo  =====================================================
echo   Game saves backup complete!
echo   Location: %OUTDIR%
echo  =====================================================
echo.
pause
