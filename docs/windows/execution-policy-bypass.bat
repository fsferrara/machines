@echo off
set "BYPASS_CMD=Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass"

echo.
echo To bypass the execution policy, run the following command in PowerShell:
echo %BYPASS_CMD%
echo.
pause
