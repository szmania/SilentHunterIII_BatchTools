@echo off
setlocal enabledelayedexpansion
set "varNation=France"
set "varDateEntry=-5"
set "varDateExit=5"
del test.txt /q
del "Campaign_LND.mis.tmp.tmp" /q
del "Campaign_LND.mis.tmp" /q
echo %time%
cscript /nologo "2.vbs"
echo %time%
if errorlevel 1 echo Error:&pause

pause