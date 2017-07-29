@echo off
setlocal enabledelayedexpansion
set /a count=1
del 5b.txt /q
echo %time%

for /f "tokens=2,4 delims=. " %%f in ('findstr /c:".Unit " "4b.txt"') do (
	set /a var5=%%f
	set /a var4=%%g

	call :parts
	set /a prevVar4=!var4!
	set /a prevVar5=!var5!
)

:parts
set /a next=!count!+1
set /a nextGroup=!prevVar5!+1
echo !var5! !var4!


if !var5!==!nextGroup! (
set /a count=1
set /a next=!count!+1	
if not !var4!==!count! (
	if !var4!==!next! (
		echo Group !var5!.Unit !count!>> 5b.txt
		set /a count=!count!+1
	)
	if not !var4!==!next! (
		
		echo Group !var5!.Unit !next!>> 5b.txt
		set /a count=!var4!
	)
)
goto :EOF
)

if !var4!==1 (
set /a count=!var4!
goto :EOF
)



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
		
		echo Group !var5!.Unit !next!>> 5b.txt
		set /a count=!var4!
	)
)

goto :EOF





for /f "tokens=2,4,5,6 delims=. " %%f in ('findstr /R "\.Unit .*\.Waypoint" "4b.txt"') do (
	set /a var5=%%f
	set /a var4=%%g
	set /p var6a=%%h
	set /a var7a=%%i

if not "!var7a!"=="" ( 
	set /p var6=!var6a!
	set /a var7=!var7a!
)

	call :parts
	set /a prevVar4=!var4!
	set /a prevVar5=!var5!
)

:parts
set /a next=!count!+1
set /a nextGroup=!prevVar5!+1
echo !var5! !var4! !var6! !var7!

if not "!var6!"=="" (
if "!var6!"=="Waypoint" (
	set /a waypoint=1
)else  (set /a waypoint=0)
)

if !var5!==!nextGroup! (
set /a count=1
set /a next=!count!+1	
if not !var4!==!count! (
	if !var4!==!next! (
		echo Group !var5!.Unit !count!>> 5b.txt
		set /a count=!count!+1
	)
	if not !var4!==!next! (
		
		echo Group !var5!.Unit !next!>> 5b.txt
		set /a count=!var4!
	)
)
goto :EOF
)

if !var4!==1 (
set /a count=!var4!
goto :EOF
)



if !waypoint!==1 && !var4!==!prevVar4! (
	goto :EOF
) else (
echo Group !var5!.Unit !next!>> 5b.txt)


if !var4!==!count! (
goto :EOF
)

if not !var4!==!count! (
	if !var4!==!next! (
		set /a count=!count!+1
	)
	if not !var4!==!next! (
		
		echo Group !var5!.Unit !next!>> 5b.txt
		set /a count=!var4!
	)
)

goto :EOF

del 4b.txt /q
