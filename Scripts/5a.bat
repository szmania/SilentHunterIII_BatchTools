@echo off
setlocal enabledelayedexpansion
set /a count=1
del 5a.txt /q
echo %time%

for /f "tokens=2 delims= " %%f in ('findstr /c:"[Unit " "4a.txt"') do (
set /a var4=%%f
call :parts
set /a prevVar4=!var4!
)

:parts
set /a next=!count!+1
echo !var4! !count!
if !var4!==!prevVar4! (
goto :EOF
)

if !var4!==!count! (
goto :EOF
)

if not !var4!==!count! (
	if !var4!==!next! (
		set /a count=!count!+1
	)
	if not !var4!==!next! (
		
		echo Unit !next!>> 5a.txt
		set /a count=!var4!
	)
)




goto :EOF

del 4a.txt /q

