::export all Navalbase names from campaign_LND.mis and put into 1.txt file

@echo off
setlocal enabledelayedexpansion

del 1.txt
del 1t.txt
del USING.txt

set /a foundName=0
set /a foundNavalBase=0

for /f "tokens=1,2 delims==" %%f in (Campaign_LND-USING.mis) do (
	set var1=%%f
	set var2=%%g

	if !foundName! EQU 0 (
		if "!var1!"=="Name" (
			set /a foundName=1
			set varName=!var2!
		) else (
			set /a foundName=0
		)
	) else (
			if "!var2!"=="NavalBase" (
				call :part2
			)
			set /a foundName=0
	)
)

del 1t.txt

copy "1.txt" "USING.txt"
del 1.txt

"2 - Export NavalBases - Compare first LND to second LND.bat"
exit

:part2
for /f "tokens=*" %%f in (1t.txt) do (
	set varNameTest=%%f
	if "!varNameTest!"=="!varName!" (
		goto :eof
	)
)
echo !varName!>> 1.txt
copy "1.txt" "1t.txt"

goto :eof

::findstr /c:"%varName%" "1t.txt"
::if errorlevel 1 (
::	echo !varName!>> 1.txt
::	copy "1.txt" "1t.txt"
::)







