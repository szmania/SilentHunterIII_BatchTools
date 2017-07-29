::export all Navalbase units from campaign_LND.mis that is found in 1.txt file

@echo off
setlocal enabledelayedexpansion
set /a line=0
::ENTER last unit number for your destination LND file
for /f "tokens=1,2 delims=[] " %%f in ('findstr /c:"Unit" Campaign_LND-USING.mis') do ( 
	set startUnitNum=%%g
)


set /a foundName=0
set /a foundNB=0
set /a line=0
set /a unitNum=!startUnitNum!
del ExtractedUnits.txt

		
for /f "tokens=1,2 delims==" %%f in (Campaign_LND.mis) do (
	set var1=%%f
	set var2=%%g
	set /a line=!line!+1
	set /a test1=!line!/1000
	set /a test2=!test1!*1000
	if !line! EQU !test2! (
		echo Line: !line!
	)
	echo !var1!|findstr /B /c:"[" >nul
	if not errorlevel 1 (
		if !foundNB! EQU 1 (
			set /a foundNB=0
		)
	)

	if !foundNB! EQU 0 (
		if !foundName! EQU 0 (
			if "!var1!"=="Name" (
				set /a foundName=1
				set varName=!var2!
			) else (
				set /a foundName=0
			)
		) else (
			if "!var2!"=="NavalBase" (
				set /a foundName=0
				call :part2
			)
			set /a foundName=0
		)
	) else (
		echo !var1!=!var2!>>ExtractedUnits.txt
	)
)

set /a units=!unitNum!-!startUnitNum!
echo.
echo ---------------------------
echo.
echo Units extracted: !units!
pause
Exit

:part2
for /f "tokens=*" %%f in (1.txt) do (
	set varNameTest=%%f
	if "!varNameTest!"=="!varName!" (
		for /f "tokens=*" %%f in (Excluded.txt) do (
			set varNameTest2=%%f
			if "!varNameTest2!"=="!varName!" (
				goto :eof
			)
		)
		set /a unitNum=!unitNum!+1
		echo.>>ExtractedUnits.txt
		echo [Unit !unitNum!]>>ExtractedUnits.txt
		echo Name=!varName!>>ExtractedUnits.txt
		echo Class=NavalBase>>ExtractedUnits.txt
		set /a foundNB=1
	)
)



goto :eof

::findstr /E /c:"!varName!" "1.txt"
::if not errorlevel 1 (
::	set /a unitNum=!unitNum!+1
::	echo.>>ExtractedUnits.txt
::	echo [Unit !unitNum!]>>ExtractedUnits.txt
::	echo Name=!varName!>>ExtractedUnits.txt
::	echo Class=NavalBase>>ExtractedUnits.txt
::	set /a foundNB=1
::)





