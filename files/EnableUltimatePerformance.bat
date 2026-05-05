@echo off
title Enable Ultimate Performance Power Plan
net session >nul 2>&1 || (echo Run as administrator. & pause & exit /b 1)

echo Adding Ultimate Performance power plan...
powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1

echo Activating Ultimate Performance...
for /F "tokens=4" %%G in ('powercfg /list ^| findstr /i "Ultimate"') do (
    powercfg /setactive %%G >nul 2>&1
)

echo.
echo Ultimate Performance power plan activated.
powercfg /getactivescheme
pause
