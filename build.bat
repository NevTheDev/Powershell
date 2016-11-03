@setlocal enableextensions
@cd /d "%~dp0%tasks"


PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './git-update.ps1'"

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './msbuild.ps1'"

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './gulp.ps1'"


pause