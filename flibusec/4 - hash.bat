@echo off
chcp 65001 > nul
set "SCAN_PATH=H:\books\fb2.flibusta.lib.rus.ec.7z"

set start_time=%DATE% %TIME%

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scan.ps1" "%SCAN_PATH%"

echo -- Start: %start_time%
echo -- Stop:  %DATE% %TIME%
