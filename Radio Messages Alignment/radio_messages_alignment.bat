@echo off
setlocal enabledelayedexpansion

echo %time%
del 2.txt /q

set /a count=0

for /f "tokens=1* delims=:" %%f in ('findstr /n "^" "1.txt"') do (
	set prefix=%%f
	set /a count+=1
	set line=%%g
	set first=!line:~8,1!
	echo !count!
	
	echo !first!|findstr /r "^[^\t]"
	if errorlevel 1  (
		echo "!first!"
		echo here
		pause
	)
	
	for /f "tokens=1 delims=<tab><space>" %%f in ("!line!") do (
		echo %%f
		echo %%g
		echo %%h
		echo %%i
		pause
	)
	
)


echo %time%
echo.
echo.
echo Finished^^!
echo.
pause