@echo off
:: BackupStartLayout.bat - Exports current Start menu layout to XML
set OUT=%UserProfile%\Desktop\StartLayout.xml

powershell -Command "Export-StartLayout -Path '%OUT%'"
echo Start menu layout exported to Desktop\StartLayout.xml
pause
