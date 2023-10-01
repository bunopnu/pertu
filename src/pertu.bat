@echo off

cd /D "%~dp0"
powershell -ExecutionPolicy Bypass -File ".\Application.ps1" %*
