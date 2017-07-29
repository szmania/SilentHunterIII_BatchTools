@echo off
setlocal enabledelayedexpansion

set "varNation=France"
set "varDate=19391001"
set "varLong=0"
set "varLat=0"
set "varDayChange=5"

echo %time%

cscript /nologo "ChangeGameINI.vbs" !varNation! !varDate! !varLong! !varLat! !varDayChange!

echo %time%
if errorlevel 1 echo Error:&pause

pause

