@echo off
:: RestorePhotoViewer.bat - Brings back classic Windows Photo Viewer from Windows 7
net session >nul 2>&1 || (echo Run as Administrator && pause && exit /b)

echo Restoring Windows Photo Viewer...

:: Re-register Photo Viewer DLL
reg add "HKCR\PhotoViewer.FileAssoc.Tiff\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\shimgvw.dll,0" /f >nul
reg add "HKCR\PhotoViewer.FileAssoc.Tiff\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f >nul
reg add "HKCR\PhotoViewer.FileAssoc.Tiff\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f >nul

:: Add Photo Viewer for common image types
for %%e in (jpg jpeg png bmp gif tif tiff) do (
    reg add "HKCU\Software\Classes\.%%e" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.%%e" /f >nul
    reg add "HKCU\Software\Classes\PhotoViewer.FileAssoc.%%e\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f >nul
    reg add "HKCU\Software\Classes\PhotoViewer.FileAssoc.%%e\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f >nul
    reg add "HKCU\Software\Classes\PhotoViewer.FileAssoc.%%e\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\shimgvw.dll,0" /f >nul
)

echo.
echo Windows Photo Viewer restored!
echo Right-click any image ^> Open With ^> Windows Photo Viewer.
echo.
echo Note: Does not support HEIC or RAW formats.
pause
