@echo off
setlocal enabledelayedexpansion
set "varNation=France"
set "varDateEntry=-5"
set "varDateExit=5"
echo %time%
cscript /nologo "ChangeGameINI.vbs" !varNation! !varDateEntry! !varDateExit!
del "Campaign_LND.tmp" /q
echo %time%
if errorlevel 1 echo Error:&pause

pause