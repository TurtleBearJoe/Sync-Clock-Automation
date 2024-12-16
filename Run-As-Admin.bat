@echo off
:: Check for admin privileges
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~dpnx0' -Verb RunAs"
    exit /b
)

:: Run the PowerShell script to create the scheduled task
powershell -ExecutionPolicy Bypass -File "%~dp0Setup-TimeSync.ps1"
