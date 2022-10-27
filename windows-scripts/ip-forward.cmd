@echo off
SET runningPath=%~dp0
echo %runningPath:~0,-1%
@echo on

PowerShell -Command "Set-ExecutionPolicy Unrestricted" > "%runningPath:~0,-1%\ip-forward-cmd.log" 2>&1
PowerShell "%runningPath:~0,-1%\ip-forward.ps1" >> "%runningPath:~0,-1%\ip-forward-cmd.log" 2>&1
