@echo off
title Empty Recycle Bin

powershell -ExecutionPolicy Bypass -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

echo Recycle Bin emptied.
timeout /t 2 /nobreak >nul
