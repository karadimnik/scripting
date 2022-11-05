@echo off
SET runningPath=%~dp0
echo "Current directory: %runningPath:~0,-1%"  >  "%runningPath:~0,-1%\ip-forward-cmd.log" 2>&1
@echo on

echo "$ Execution Policy" >>  "%runningPath:~0,-1%\ip-forward-cmd.log" 2>&1
PowerShell -Command "Set-ExecutionPolicy ByPass" >> "%runningPath:~0,-1%\ip-forward-cmd.log" 2>&1
echo "$ Unblock-File" >>  "%runningPath:~0,-1%\ip-forward-cmd.log" 2>&1
PowerShell -Command "Unblock-File %runningPath:~0,-1%\ip-forward.ps1"  >> "%runningPath:~0,-1%\ip-forward-cmd.log" 2>&1
echo "$ Run [ip-forward.ps1]" >>  "%runningPath:~0,-1%\ip-forward-cmd.log" 2>&1
PowerShell "%runningPath:~0,-1%\ip-forward.ps1" 