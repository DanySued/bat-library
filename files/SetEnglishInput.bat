@echo off
echo Setting default input language to English...

:: Set English (US) as default input language
powershell -Command "Set-WinUserLanguageList en-US -Force"

:: Set input method override to English (US keyboard)
powershell -Command "Set-WinDefaultInputMethodOverride -InputTip '0409:00000409'"

echo Done. Please restart your computer.
pause