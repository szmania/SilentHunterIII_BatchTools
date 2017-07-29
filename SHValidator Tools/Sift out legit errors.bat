@echo off



setlocal enabledelayedexpansion

set logFile=SCR5.log
del 1.txt
del 2.txt


echo Starting...

for /f "tokens=*" %%f in (!logFile!) do (
	echo %%f>> 1.txt
)
echo Part 1 Done!


for /f "tokens=*" %%f in ('findstr /c:"has invalid entry of" "1.txt"') do (
	set var1=%%f
	echo %%f

	findstr /C:"!var1!" "2.txt"
	if errorlevel 1 (
		echo !var1!>> 2.txt
	)

)

echo Part 2 Done!
for /f "tokens=*" %%f in ('findstr /c:"does not contain sequentially ordered entries" "1.txt"') do (
	set var1=%%f

	findstr /C:"!var1!" "2.txt"
	if errorlevel 1 (
		echo !var1!>> 2.txt
	)

)
echo Finished 
pause
