@echo off
setlocal enabledelayedexpansion
set "varNation=France"
set "varDateEntry=-5"
set "varDateExit=5"
echo %time%
cscript /nologo "3.vbs"
echo %time%
if errorlevel 1 echo Error:&pause

pause