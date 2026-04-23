@echo off
:: ============================================================
::  RestorePhotoViewer.bat
::  Brings back the classic Windows Photo Viewer from Windows 7
::  and sets it as the default for all image types.
::  Run as Administrator!
:: ============================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Please right-click and choose "Run as administrator"
    pause
    exit /b
)

echo.
echo  =====================================================
echo   Restoring Classic Windows Photo Viewer
echo  =====================================================
echo.

:: ============================================================
:: STEP 1 — Restore the Photo Viewer registration in registry
:: (Microsoft removed these keys in Windows 10/11 but the
::  actual program, PhotoViewer.dll, is still on your system)
:: ============================================================
echo [1/3] Registering Windows Photo Viewer...

reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp"  /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib"  /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif"  /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe"  /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg"  /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png"  /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tif"  /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tiff" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".wdp"  /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul

echo    Done.

:: ============================================================
:: STEP 2 — Register the Open With handler so it appears
::          in right-click menus and the default apps list
:: ============================================================
echo [2/3] Adding Photo Viewer to Open With menu...

reg add "HKCR\Applications\photoviewer.dll\shell\open" /v "MuiVerb" /t REG_SZ /d "@photoviewer.dll,-3043" /f >nul
reg add "HKCR\Applications\photoviewer.dll\shell\open\command" /ve /t REG_SZ /d "%SystemRoot%\System32\rundll32.exe \"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f >nul
reg add "HKCR\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f >nul

echo    Done.

:: ============================================================
:: STEP 3 — Set as default for all image types (current user)
:: ============================================================
echo [3/3] Setting Photo Viewer as default for image files...

reg add "HKCU\SOFTWARE\Classes\.bmp"  /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.dib"  /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.gif"  /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.jfif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.jpe"  /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.jpeg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.jpg"  /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.png"  /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.tif"  /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.tiff" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul
reg add "HKCU\SOFTWARE\Classes\.wdp"  /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul

:: Refresh explorer so changes take effect without reboot
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo    Done.

echo.
echo  =====================================================
echo   Classic Windows Photo Viewer restored!
echo.
echo   Now default for: jpg, jpeg, png, bmp, gif,
echo                     tif, tiff, wdp, jpe, jfif
echo.
echo   If any image still opens in Photos app, right-click
echo   it, choose Open With, then select Photo Viewer.
echo  =====================================================
echo.
pause
