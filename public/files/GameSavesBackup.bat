@echo off
:: GameSavesBackup.bat - Backs up save files from Steam, Epic, Ubisoft, GOG, EA
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo GameSavesBackup - Backup game save files
echo.
set /p DEST=Enter backup destination (e.g. D:\GameSaves or external drive):

for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set TODAY=%%c-%%a-%%b
set FOLDER=%DEST%\GameSaves_%TODAY%

if not exist "%FOLDER%" mkdir "%FOLDER%"

echo.
echo Backing up Steam saves...
if exist "%AppData%\Roaming\Microsoft\Windows\GameExplorer" (
    robocopy "%AppData%\Roaming\Microsoft\Windows\GameExplorer" "%FOLDER%\Steam_GameExplorer" /MIR /R:1 /W:1 /NP >nul
)
if exist "%LocalAppData%\Steam" (
    robocopy "%LocalAppData%\Steam" "%FOLDER%\Steam_Local" /MIR /R:1 /W:1 /NP >nul
)

echo Backing up Epic Games saves...
if exist "%LocalAppData%\EpicGamesLauncher" (
    robocopy "%LocalAppData%\EpicGamesLauncher\Saved\Config" "%FOLDER%\Epic_Config" /MIR /R:1 /W:1 /NP >nul
)

echo Backing up Ubisoft Connect saves...
if exist "%LocalAppData%\Ubisoft Game Launcher" (
    robocopy "%LocalAppData%\Ubisoft Game Launcher\savegames" "%FOLDER%\Ubisoft_Saves" /MIR /R:1 /W:1 /NP >nul
)

echo Backing up GOG Galaxy saves...
if exist "%LocalAppData%\GOG.com" (
    robocopy "%LocalAppData%\GOG.com" "%FOLDER%\GOG_Local" /MIR /R:1 /W:1 /NP >nul
)

echo Backing up EA App saves...
if exist "%LocalAppData%\Electronic Arts" (
    robocopy "%LocalAppData%\Electronic Arts" "%FOLDER%\EA_Saves" /MIR /R:1 /W:1 /NP >nul
)

echo Backing up common Documents game saves...
if exist "%UserProfile%\Documents\My Games" (
    robocopy "%UserProfile%\Documents\My Games" "%FOLDER%\MyGames" /MIR /R:1 /W:1 /NP >nul
)

echo Backing up Saved Games folder...
if exist "%UserProfile%\Saved Games" (
    robocopy "%UserProfile%\Saved Games" "%FOLDER%\SavedGames" /MIR /R:1 /W:1 /NP >nul
)

echo.
echo Backup complete! Saved to: %FOLDER%
echo To restore: copy files from backup folder back to original locations.
pause
