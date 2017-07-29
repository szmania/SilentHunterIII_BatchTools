@echo off

setlocal enabledelayedexpansion

set sh3saves=C:\Users\P Ditty\Documents\SH3
set dSource2=!sh3saves!\data\cfg\Careers
set fType2=*.clg

ping -n 10 -w 1000 127.0.0.1 > nul
:loop
for /f "delims=" %%f in ('dir /a-d /b /s "%dSource2%\%fType2%"') do (
	echo %%f
	set fullpath3=%%f

	for /D %%I in ("!fullpath3!") do set name=%%~nI
		if "!name!" EQU "journal" (
			start WINDOWED2.exe
			pause
			exit
		)

)

ping -n 10 -w 1000 127.0.0.1 > nul

goto loop
