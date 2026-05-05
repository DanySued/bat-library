@echo off
:: PowerButtonConfig.bat - Configure power button and lid closing behavior
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo PowerButtonConfig - Configure power button and lid behavior
echo.
echo Power button options:
echo   0 = Do nothing
echo   1 = Sleep
echo   2 = Hibernate
echo   3 = Shut down
echo.
set /p BTN_AC=Power button (plugged in):
set /p BTN_DC=Power button (on battery):

echo.
echo Lid close options (laptops only):
echo   0 = Do nothing
echo   1 = Sleep
echo   2 = Hibernate
echo   3 = Shut down
echo.
set /p LID_AC=Lid close (plugged in):
set /p LID_DC=Lid close (on battery):

echo.
echo Applying settings...

powercfg -setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION %BTN_AC% >nul
powercfg -setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION %BTN_DC% >nul
powercfg -setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION %LID_AC% >nul
powercfg -setdcvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION %LID_DC% >nul
powercfg -setactive SCHEME_CURRENT >nul

echo.
echo Settings applied immediately. No restart needed.
echo Run again to change.
pause
