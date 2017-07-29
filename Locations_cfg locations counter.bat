@echo off
setlocal enabledelayedexpansion
set /a count=0
set line=
for /f "tokens=*" %%f in (Locations.cfg) do (
	echo %%f|findstr /B /c:"[Location " >nul
	if not errorlevel 1 (
		REM echo %%f
		set line=%%f
		set number=!line:[Location =!
		set /a number=!number:]=!
		set /a count=!count!+1
		echo !count!
		echo !number!
		if not !number! == !count! (
			echo !line!
			pause
		)
	)
)
