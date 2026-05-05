@echo off
title Set High Performance Power Plan
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Setting power plan to High Performance...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1

if %errorlevel% neq 0 (
    echo High Performance plan not found. Creating it...
    powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
)

echo Disabling USB selective suspend...
powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1

echo.
echo Power plan set to High Performance.
powercfg /getactivescheme
pause
