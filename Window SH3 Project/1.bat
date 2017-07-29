@echo off

setlocal enabledelayedexpansion

set new=%1
echo !new!

:TEST2
del temp.txt /q


set /a maxCount=100
set /a count=0

for /f "delims=" %%f in ('dir /b /a:-d /o:d /s ".\SH3\data\cfg\Careers"') do (
REM for /f "delims=" %%f in ('dir /b /a:-d /o:-d /s "C:\Users\P Ditty\Documents\SH3\data\cfg\Careers"') do (	
	set name=%%~tf
	echo !name! >> temp.txt
)

findstr /c:"journAl" "temp.txt" 
if not errorlevel 1 (
	echo found
)

if "!name!"=="journal" (
		echo !name!
	)
if "!name!"=="JOURNAL" (
		echo !name!
	)
if "!name!"=="journAL" (
		echo !name!
	)	




	
:next




:TEST1

pause