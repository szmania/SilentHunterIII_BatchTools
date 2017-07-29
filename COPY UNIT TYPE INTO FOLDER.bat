@echo off

setlocal enabledelayedexpansion

del Found /q

set unitType=13
set "dTarget=E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster\AllUnits\Sea"

mkdir Found


for /r "%dTarget%" %%h in (*) do (
	set fullpath=%%h
	echo !fullpath!
call :part1

)

:part1
findstr /b /C:"UnitType=!unitType!" "!fullpath!"
if not errorlevel 1 (

	for /f "usebackq tokens=*" %%g in ("!fullpath!") do (
		set line=%%g
		if "!line!"=="UnitType=!unitType!" (

			copy /y "!fullpath!" Found
		)
	)
)
goto :eof
