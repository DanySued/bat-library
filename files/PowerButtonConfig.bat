@echo off
:: ============================================================
::  PowerButtonConfig.bat
::  Configure what the power button and lid closing does
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause & exit /b
)
echo.
echo  =====================================================
echo   Power Button Configuration
echo  =====================================================
echo.
echo  What should the POWER BUTTON do?
echo.
echo   1. Sleep      (press = sleep, wake up easily)
echo   2. Hibernate  (press = hibernate, saves session)
echo   3. Shut down  (press = full shutdown)
echo   4. Do nothing (press = nothing happens)
echo.
set /p "PBCHOICE=Enter choice (1/2/3/4): "

echo.
echo  What should CLOSING THE LID do? (laptop only)
echo.
echo   1. Sleep
echo   2. Hibernate
echo   3. Shut down
echo   4. Do nothing
echo.
set /p "LIDCHOICE=Enter choice (1/2/3/4): "

:: Map choices to action values
:: 1=Sleep, 2=Hibernate, 3=Shutdown, 4=DoNothing
set "PB_ACTION=1"
set "LID_ACTION=1"

if "%PBCHOICE%"=="1"  set "PB_ACTION=1"
if "%PBCHOICE%"=="2"  set "PB_ACTION=2"
if "%PBCHOICE%"=="3"  set "PB_ACTION=3"
if "%PBCHOICE%"=="4"  set "PB_ACTION=0"

if "%LIDCHOICE%"=="1" set "LID_ACTION=1"
if "%LIDCHOICE%"=="2" set "LID_ACTION=2"
if "%LIDCHOICE%"=="3" set "LID_ACTION=3"
if "%LIDCHOICE%"=="4" set "LID_ACTION=0"

:: Apply — ACvalue = plugged in, DCvalue = on battery
powercfg -setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION %PB_ACTION% >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION %PB_ACTION% >nul 2>&1
powercfg -setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION %LID_ACTION% >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION %LID_ACTION% >nul 2>&1
powercfg -setactive SCHEME_CURRENT >nul 2>&1

echo.
echo  =====================================================
echo   Power button and lid settings updated!
echo   Changes take effect immediately.
echo  =====================================================
echo.
pause
