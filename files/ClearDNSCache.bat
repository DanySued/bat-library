@echo off
title Clear DNS Cache

echo Flushing DNS resolver cache...
ipconfig /flushdns

echo.
echo DNS cache cleared. Fresh DNS lookups will be used for all domains.
pause
