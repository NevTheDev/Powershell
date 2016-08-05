@setlocal enableextensions
@cd /d "%~dp0%tasks"

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './setup-iis.ps1'"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './setup-eventlog.ps1'"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './setup-hosts.ps1'"

pause