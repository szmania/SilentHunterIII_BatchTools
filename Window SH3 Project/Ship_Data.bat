@echo off

setlocal enabledelayedexpansion
del uBoatStats.txt /q

set /a maxCount=0
for /f "tokens=2 delims==" %%f in ('findstr /c:"PatrolNumber=" "Patrols.cfg"') do (
	set patNum=%%f
	set /a maxCount=!maxCount! + 1
call :next
)
goto end

setlocal enabledelayedexpansion	
:next	
	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"SubName=" "Patrols.cfg"') do (
		set subName=%%f	
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next1)	
	)
	:next1


	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"SubType=" "Patrols.cfg"') do (
		set subType=%%f
		if "!subType!" EQU "0" (
			set subType=II
		)
		if "!subType!" EQU "1" (
			set subType=VII
		)
		if "!subType!" EQU "2" (
			set subType=IX
		)
		if "!subType!" EQU "3" (
			set subType=XXI
		)
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next2)
	)
	:next2
	echo.
	echo Submarine Name: !subName!		U-boat Type: !subType! >> uBoatStats.txt
	

	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"PatrolArea=" "Patrols.cfg"') do (
		set patArea=%%f	
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next3)	
	)
	:next3
	echo.
	echo Patrol Area: !patArea! >> uBoatStats.txt


	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"StartYear=" "Patrols.cfg"') do (
		set startYear=%%f
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next4)		
	)


	:next4
	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"StartMonth=" "Patrols.cfg"') do (
		set startMonth=%%f
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next5)	
	)	
	:next5		
	call :startMonthAdjust !startMonth!
	goto :eof
	:back


	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"StartDay=" "Patrols.cfg"') do (
		set startDay=%%f
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next6)	
	)	
	:next6

	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"StartYear=" "Patrols.cfg"') do (
		set startYear=%%f
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next7)		
	)

	:next7
	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"StartHour=" "Patrols.cfg"') do (
		set startHour=%%f
		if !startHour! LSS 10 (
			set startHour=0!startHour!
		)
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next8)		
	)

	:next8
	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"StartMin=" "Patrols.cfg"') do (
		set /a startMin=%%f
		if !startMin! LSS 10 (
			set startMin=0!startMin!
		)
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next9)		
	)
	:next9
	echo.
	echo Start Date: !startMonth! !startDay!, !startYear!		Start Time: !startHour!:!startMin!>> uBoatStats.txt


	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"EndYear=" "Patrols.cfg"') do (
		set endYear=%%f
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next10)		
	)

	:next10
	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"EndMonth=" "Patrols.cfg"') do (
		set endMonth=%%f
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next11)	
	)	
	:next11		
	call :endMonthAdjust !endMonth!
	goto :eof
	:back2


	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"EndDay=" "Patrols.cfg"') do (
		set endDay=%%f
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next12)	
	)	
	:next12
	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"EndHour=" "Patrols.cfg"') do (
		set endHour=%%f
		if !endHour! LSS 10 (
			set endHour=0!endHour!
		)
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next13)		
	)

	:next13
	set /a count=0
	for /f "tokens=2 delims==" %%f in ('findstr /c:"EndMin=" "Patrols.cfg"') do (
		set /a endMin=%%f
		if !endMin! LSS 10 (
			set endMin=0!endMin!
		)
		set /a count= count + 1
		if "!count!" EQU "!maxCount!" (goto :next14)		
	)
	:next14
	echo.
	echo End Date: !endMonth! !endDay!, !endYear!		End Time: !endHour!:!endMin!>> uBoatStats.txt




echo. >> uBoatStats.txt
goto :eof




:startMonthAdjust
setlocal enabledelayedexpansion

set variable=%1

if "!variable!" EQU "1" (
	set variable=January
)

if "!variable!" EQU "2" (
	set variable=February
)

if "!variable!" EQU "3" (
	set variable=March
)

if "!variable!" EQU "4" (
	set variable=April
)

if "!variable!" EQU "5" (
	set variable=May
)

if "!variable!" EQU "6" (
	set variable=June
)

if "!variable!" EQU "7" (
	set variable=July
)

if "!variable!" EQU "8" (
	set variable=August
)

if "!variable!" EQU "9" (
	set variable=September
)

if "!variable!" EQU "10" (
	set variable=October
)

if "!variable!" EQU "11" (
	set variable=November
)

if "!variable!" EQU "12" (
	set variable=December
)

set startMonth=!variable!
set endMonth=!variable!
goto :back



:endMonthAdjust
setlocal enabledelayedexpansion

set variable=%1

if "!variable!" EQU "1" (
	set variable=January
)

if "!variable!" EQU "2" (
	set variable=February
)

if "!variable!" EQU "3" (
	set variable=March
)

if "!variable!" EQU "4" (
	set variable=April
)

if "!variable!" EQU "5" (
	set variable=May
)

if "!variable!" EQU "6" (
	set variable=June
)

if "!variable!" EQU "7" (
	set variable=July
)

if "!variable!" EQU "8" (
	set variable=August
)

if "!variable!" EQU "9" (
	set variable=September
)

if "!variable!" EQU "10" (
	set variable=October
)

if "!variable!" EQU "11" (
	set variable=November
)

if "!variable!" EQU "12" (
	set variable=December
)

set endMonth=!variable!
goto :back2




:end



pause