@echo off
:: EmptyRecycleBinSilent.bat - Silently empties the Recycle Bin
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
echo Recycle Bin emptied.
