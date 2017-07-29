@echo off



setlocal enabledelayedexpansion

set logFile=SCR5.log

del 1.txt
del 2.txt
del 3.txt
del 3a.txt
del NotFoundUnits.txt


echo Starting...

for /f "tokens=*" %%f in (!logFile!) do (
	echo %%f>> 1.txt
)
echo Part 1 Done!


for /f "tokens=*" %%f in ('findstr /B /c:"Type " "1.txt"') do (
	set var1=%%f

	findstr /C:"!var1!" "2.txt"
	if errorlevel 1 (
		echo !var1!>> 2.txt
		call :part1
	)

)

echo Part 2 Done!
call :part4



:part1
for /f "tokens=2,6 delims= " %%f in (2.txt) do (
	set type=%%f
	set class=%%g
	set found=false

	call :part2
	if "!found!"=="true" (
		goto :eof
	)
)



:part2

set dirTarget=%cd%\Test
set fileType=*.cfg

for /f "delims=" %%h in ('dir /a-d /b /s "%dirTarget%\%fileType%"') do (
	REM echo %%h
	set fullpath=%%h

	REM echo !fullpath!

	for /D %%I in ("!fullpath!\..") do set vehicleDir=%%~nxI

	for /D %%J in ("!fullpath!\..\..") do set typeDir=%%~nxJ

	for /D %%N in ("!fullpath!") do set FileName1=%%~nN

	REM echo !FileName1!
	call:part3
	if "!found!"=="true" (
		goto :eof
	)
)


:part3
findstr /b /c:"ClassName=!class!" "!fullpath!"
if not errorlevel 1 (
	findstr /b /c:"UnitType=!type!" "!fullpath!"
	if not errorlevel 1 (
		echo.>>3.txt
		echo.>>3.txt
		echo Found! >>3.txt
		echo !var1!>> 3.txt
		echo !var1!>>3a.txt
		echo !fullpath!>>3.txt
		echo !class!>>3.txt
		echo !type!>>3.txt
		set found=true
	)
)

goto :eof


:part4
pause
for /f "tokens=*" %%f in (2.txt) do (
	set var1=%%f
	findstr /C:"!var1!" "3a.txt"
		if errorlevel 1 (
			echo !var1!>> NotFoundUnits.txt

		)
)
echo Finished!

pause
