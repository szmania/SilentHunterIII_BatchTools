::export all Navalbase names from campaign_LND.mis, then compare with navalbase names in USING.txt and then put non duplicates into 1.txt file

@echo off
setlocal enabledelayedexpansion

del 1t.txt
del 1.txt

set /a foundName=0
set /a foundNavalBase=0
set / line2=0

for /f "tokens=1,2 delims==" %%f in (Campaign_LND.mis) do (
	set var1=%%f
	set var2=%%g
	set /a line2=!line2!+1
	echo LINE: !line2!

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
				set /a foundName=0
			)
			set /a foundName=0
	)
)

del 1t.txt

"3 - Export NavalBase Units - Last Step.bat"
Exit

:part2
for /f "tokens=*" %%f in (USING.txt) do (
	set varNameTest=%%f
	if "!varNameTest!"=="!varName!" (
		goto :eof
	)
)
for /f "tokens=*" %%f in (1.txt) do (
	set varNameTest2=%%f
	if "!varNameTest2!"=="!varName!" (
		goto :eof
	)
)
echo !varName!>> 1.txt
copy "1.txt" "1t.txt"

::findstr /c:"%varName%" "USING.txt"
::if errorlevel 1 (
::	findstr /c:"%varName%" "1t.txt"
::	if errorlevel 1 (
::		echo !varName!>> 1.txt
::		copy "1.txt" "1t.txt"
::	)
::)

goto :eof






