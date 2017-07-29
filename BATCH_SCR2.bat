@echo off

:start

setlocal enabledelayedexpansion

for /f "usebackq delims=" %%q in ("VARIABLES\sh3directory.txt") do (
set sh3directory=%%q
)

for /f "usebackq delims=" %%r in ("VARIABLES\sh3saves.txt") do (
set sh3saves=%%r
)

for /f "usebackq delims=" %%s in ("VARIABLES\sh3commander.txt") do (
set sh3commander=%%s
)



RD /S /Q "!sh3saves!\data\cfg\Backups_SCR2"


del Campaign_SCR2.mis.tmp /q

del Campaign_RND2.mis.tmp /q

del Campaign_SCR.mis /q

del Marks.txt /q

del List.txt /q

del PosTime_Campaign_SCR.mis  /q

del working.clg /q

del variable.txt /q

del variable2.txt /q

del variable3.txt /q

del input.txt /q


del "Temp\shipsunk.txt" /q
del "Temp\var1.txt" /q
del "Temp\var1b.txt" /q
del "Temp\var1c.txt" /q
del "Temp\var2a.txt" /q
del "Temp\var2b.txt" /q
del "Temp\var3a.txt" /q
del "Temp\var3b.txt" /q
del "Temp\var5a.txt" /q
del "Temp\var5b.txt" /q
del "Temp\var6.txt" /q
del "Temp\pat1.txt" /q
del "Temp\prevcareer.txt" /q


mkdir "!sh3saves!\data\cfg\Backups_SCR2"


if not exist "Temp" (
mkdir "Temp"
)


::COPYING FILES FROM CAREER SAVE FOLDERS

set dSource=!sh3saves!\data\cfg\Careers
set dTarget=!sh3saves!\data\cfg\Backups_SCR2
set fType=*.clg

setlocal enabledelayedexpansion


for /f "delims=" %%f in ('dir /a-d /b /s "%dSource%\%fType%"') do (
 echo %%f
set fullpath=%%f

for /D %%I in ("!fullpath!\..") do set patroldir=%%~nxI

for /D %%J in ("!fullpath!\..\..") do set careerdir=%%~nxJ

mkdir "!dTarget!\!careerdir!\!patroldir!\"

copy  /v /y "%%~f" "!dTarget!\!careerdir!\!patroldir!\"
)






set dSource2=!sh3saves!\data\cfg\Careers
set dTarget2=!sh3saves!\data\cfg\Backups_SCR2
set fType2=*.map

setlocal enabledelayedexpansion


for /f "delims=" %%f in ('dir /a-d /b /s "%dSource2%\%fType2%"') do (
 echo %%f
set fullpath3=%%f

for /D %%I in ("!fullpath3!\..") do set patroldir3=%%~nxI

for /D %%J in ("!fullpath3!\..\..") do set careerdir3=%%~nxJ

mkdir "!dTarget2!\!careerdir3!\!patroldir3!\"

copy  /v /y "%%~f" "!dTarget2!\!careerdir3!\!patroldir3!\"

)







copy "!sh3directory!\Dynamic Campaign\Marks.txt" Marks.txt


copy "!sh3directory!\Dynamic Campaign\List.txt" List.txt



:restart1

set /a maxlines4=0
set /a linecount4=0

set /a maxlines5=0
set /a linecount5=0

set /a maxlinesnf=0
set /a linecountnf=0

del variable.txt
del variable2.txt

set /a PrevPatNum=0
set /a PrevNum=0
set /a maxlines1=0
set /a linecountcareer=0
set /a linecount1=0
set /a skipcareerline=0




::CAREER ASSIGNMENT

SETLOCAL ENABLEDELAYEDEXPANSION

for /f "tokens=2* delims=:" %%m in ('findstr /c:"Career" Marks.txt') do (
set CareerName=%%m
set /a skipcareertimes=0


if not exist "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\Campaign_SCR.mis" (

mkdir "!sh3directory!\Dynamic Campaign\Careers\!CareerName!"

copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\Campaign_SCR.mis"

)

if not exist "!sh3saves!\data\cfg\Careers\!CareerName!" (
RD /S /Q "!sh3directory!\Dynamic Campaign\Careers\!CareerName!"
)


call :partz
)
goto :finish



:partz



set careerstartline=0
for /f "tokens=1 delims=:" %%i in ('findstr /N /c:"Career:!CareerName!" Marks.txt') do (
set careerstartline=%%i
set /a skipcareerline+=1

goto :partz2
)
goto :eof

:partz2
set careerstartlinep=
for /f "tokens=3* delims=:" %%l in ('findstr /N /c:"Career" Marks.txt') do (
set careerstartlinep=%%l

set /a skipcareerlinep+=1
if "!careerstartlinep!"=="!CareerName!" (goto partz2a)
)
goto :eof


:partz2a

set /a skipcareer=0
for /f "tokens=2* delims=:" %%n in ('findstr /c:"Career" Marks.txt') do (
set NextCareerName=%%n
set /a skipcareer+=1

if !skipcareer! GTR %skipcareerlinep% (
goto partz3
)
)

:partz3

if !NextCareerName! EQU !CareerName! (
set NextCareerName=NO MORE
set nextcareerstartline=999999
) else (

for /f "tokens=1 delims=:" %%k in ('findstr /N /c:"Career:!NextCareerName!" Marks.txt') do (
set nextcareerstartline=%%k
)
)


:partz4


::PATROL ASSIGNMENT

for /f "tokens=2 delims= " %%z in ('findstr /c:"Patrol" Marks.txt') do (
set PatrolNumber=%%z
set /a linecountcareer+=1


del variable.txt /q

del variable2.txt /q

del variable3.txt /q




if defined var1c (

if not exist "Temp\var1b.txt" (goto :eof)
)

if exist "Temp\var1b.txt" (
for /f "delims=" %%w in (Temp\var1b.txt) do (
set NextCareerNameCheck=%%w

if "!NextCareerNameCheck!"=="Career:!NextCareerName!" (
goto :eof
)
)
)

set var1c=Been Here

for /f "tokens=2* delims=:" %%h in (Temp\var1.txt) do (
set var1a=%%h

if !var1a!==!NextCareerName! (

del "Temp\var1.txt" /q
goto :eof
)
)



set /a skippatrolpatrolnumberline=0
for /f "tokens=2 delims= " %%w in ('findstr /c:"Patrol !PatrolNumber!" Marks.txt') do (
set skippatrolpatrolnumber=%%w
set /a skippatrolpatrolnumberline+=1

if !skippatrolpatrolnumberline! EQU !skipcareerline! (


set /a animal=0
for /f "tokens=1 delims=:" %%t in ('findstr /n /c:"Patrol !PatrolNumber!" Marks.txt') do (
set /a animal+=1
set patrolpatrolnumberstartline2=%%t


if !animal! EQU !skipcareerline! (

if !careerstartline! LSS !patrolpatrolnumberstartline2! (

if !nextcareerstartline! GTR !patrolpatrolnumberstartline2! (

if exist "Temp\pat1.txt" (

for /f "tokens=1 delims= " %%s in (Temp\pat1.txt) do (
set linecountcareer1a=%%s


if !patrolpatrolnumberstartline2! GTR !linecountcareer1a! (

if !careerstartline! LSS !patrolpatrolnumberstartline2! (

if not !skippatrolpatrolnumberline! GTR !skipcareerline! (

del "Temp\pat1.txt" /q

echo !patrolpatrolnumberstartline2! > "Temp\pat1.txt"

call :part1z
)
)
)
)
)


if not exist "Temp\pat1.txt" (

if !careerstartline! LSS !patrolpatrolnumberstartline2! (

if not !skippatrolpatrolnumberline! GTR !skipcareerline! (

del "Temp\pat1.txt" /q

echo !patrolpatrolnumberstartline2! > "Temp\pat1.txt"

call :part1z
)
)
)
)
)
)
)
)

if !skippatrolpatrolnumberline! LSS !skipcareerline! (

for /f "tokens=1 delims=:" %%u in ('findstr /n /c:"Patrol !PatrolNumber!" Marks.txt') do (
set patrolpatrolnumberstartline2a=%%u

if !patrolpatrolnumberstartline2a! GEQ !careerstartline! (

if !patrolpatrolnumberstartline2a! LSS !nextcareerstartline! (

for /f "tokens=1 delims= " %%s in (Temp\pat1.txt) do (
set linecountcareer1ab=%%s


if !patrolpatrolnumberstartline2a! GTR !linecountcareer1ab! (


if !careerstartline! LSS !patrolpatrolnumberstartline2a! (


del "Temp\pat1.txt" /q

echo !patrolpatrolnumberstartline2a! > "Temp\pat1.txt"

call :part1x
)
)
)
)
)
)
)
)
)

goto :eof

:part1x


set /a maxlines1=0
set maxlines1=%PatrolNumber%
set /a linecount1a=0
set /a linecount1b=0
set /a linecount1c=0
set startline=!patrolpatrolnumberstartline2a!

set /a nextPatrolNumber=0

set /a linecountnextpatrolnumberyes=0
for /f "tokens=2 delims= " %%i in (Marks.txt) do (
set nextPatrolNumber=%%i
set /a linecountnextpatrolnumberyes+=1

if !linecountnextpatrolnumberyes! GTR !careerstartline! (

if !linecountnextpatrolnumberyes! GTR !patrolpatrolnumberstartline2a! (

if !linecountnextpatrolnumberyes! LSS !nextcareerstartline! (

set /a linecountnextpatrolnumberno=0
for /f "delims=" %%e in (Marks.txt) do (
set nextPatrolNumber2=%%e
set /a linecountnextpatrolnumberno+=1

if !linecountnextpatrolnumberno! EQU !linecountnextpatrolnumberyes! (

echo !nextPatrolNumber2!|findstr "Patrol"
if not errorlevel 1 (
if !nextPatrolNumber!==!PatrolNumber! (goto :itequals)

goto beforepart1b
)
)
)
)
)
)
)
:itequals
set /a nextPatrolNumber=!PatrolNumber!+1

:beforepart1b
goto part1b




:part1z

set /a nextPatrolNumber=0

set /a linecountnextpatrolnumberyes=0
for /f "tokens=2 delims= " %%v in (Marks.txt) do (
set nextPatrolNumber=%%v
set /a linecountnextpatrolnumberyes+=1

if !linecountnextpatrolnumberyes! GTR !careerstartline! (

if !linecountnextpatrolnumberyes! GTR !patrolpatrolnumberstartline2! (

if !linecountnextpatrolnumberyes! LSS !nextcareerstartline! (


set /a linecountnextpatrolnumberno=0
for /f "delims=" %%p in (Marks.txt) do (
set nextPatrolNumber2=%%p
set /a linecountnextpatrolnumberno+=1

if !linecountnextpatrolnumberno! EQU !linecountnextpatrolnumberyes! (

echo !nextPatrolNumber2!|findstr "Patrol"
if not errorlevel 1 (
if !nextPatrolNumber!==!PatrolNumber! (goto :itequals2)
goto :afternextpatrolnumber

)
)
)
)
)
)
)
:itequals2
set /a nextPatrolNumber=!PatrolNumber!+1




::ASSIGNMING PATROL NUMBERS




:afternextpatrolnumber

:part1za

set /a maxlines1=0
set maxlines1=%PatrolNumber%
set /a linecount1a=0
set /a linecount1b=0
set /a linecount1c=0

SETLOCAL ENABLEDELAYEDEXPANSION
set startline=
for /f "tokens=1 delims=:" %%i in ('findstr /N /c:"Patrol !PatrolNumber!" Marks.txt') do (
   set startline=%%i
set /a linecount1+=1



if !startline! GEQ !careerstartline! (
if !startline! LSS !nextcareerstartline! (

goto part1b
)
)
)
goto :eof

:part1b

if !nextPatrolNumber!==!PatrolNumber! (
set /a nextPatrolNumber=!PatrolNumber!+1
)


set /a linecount1a=0
set /a linecount1b=0
set /a linecount1c=0


for /f "tokens=1 delims=:" %%e in ('findstr /n /c:"Patrol !nextPatrolNumber!" Marks.txt') do (
set nextpatrolnumberexactline=%%e

if !nextpatrolnumberexactline! GTR !careerstartline! (

if !nextpatrolnumberexactline! LSS !nextcareerstartline! (

set /a linecount1a=0
for /f "delims=" %%y in (Marks.txt)  do (
set wholenextpatrolname=%%y
set /a linecount1a+=1
if !linecount1a! EQU !nextpatrolnumberexactline! (
goto nextpatnumcheck
)
)
)
)
)

:nextpatnumcheck

for /f "tokens=1 delims=:" %%e in ('findstr /n /c:"Patrol !PatrolNumber!" Marks.txt') do (
set patrolnumberexactline=%%e

if !patrolnumberexactline! GTR !careerstartline! (

if !patrolnumberexactline! LSS !nextcareerstartline! (

set /a linecount1b=0
for /f "delims=" %%x in (Marks.txt)  do (
set wholepatrolname=%%x
set /a linecount1b+=1
if !linecount1b! EQU !patrolnumberexactline! (
goto donepatnumcheck
)
)
)
)
)
:donepatnumcheck



if !wholepatrolname! EQU !wholenextpatrolname! (
set wholenextpatrolname=Patrol !nextPatrolNumber!
)
echo !wholepatrolname!
echo !wholenextpatrolname!



::SEARCHING MARKS.TXT FOR VAR1

set /a linecount1c=0

SETLOCAL ENABLEDELAYEDEXPANSION

for /f "delims=" %%A in (Marks.txt) do (
set var1=
set var1=%%A
set /a linecount1c+=1




echo !var1! > "Temp\var1b.txt"


if not "!NextCareerName!"=="NO MORE" (


if "!var1!"=="Career:!NextCareerName!" (
echo !var1!> "Temp\var1.txt"
echo !CareerName!> "Temp\prevcareer.txt"
echo.
goto :eof
)
)

for /f "delims=" %%h in (Temp\prevcareer.txt) do (
set PrevCareerName=%%h
)


if not defined PrevCareerName (
if !linecount1c! GEQ !startline! (
if "!var1!"=="!wholenextpatrolname!" goto :eof
)
)

if defined PrevCareerName (
if "!var1!"=="!wholenextpatrolname!" (
set /a skipcareertimes+=1

if !linecount1c! GEQ !startline! (

if !skipcareertimes! GEQ !skipcareer! (
goto :eof
)
)
set /a instancesofword=0
for /f "delims=" %%u in ('findstr /c:"!var1!" "Marks.txt"') do (
set /a instancesofword+=1
echo !var1!|findstr /c:"Patrol"
if not errorlevel 1 (

if !linecount1c! GEQ !startline! (

if !instancesofword! LSS !skipcareer! (
goto :eof
)
)
)
)
)
)


if !linecount1c! GEQ %startline% (
echo !var1!|findstr /c:"Patrol"
if not errorlevel 1 (
echo !var1!|findstr /c:"Patrol !nextPatrolNumber!"
if errorlevel 1 (

echo !var1!|findstr /c:"Patrol !PatrolNumber!"
if errorlevel 1 (

goto :eof)

)
)
) 

echo !var1!|findstr "Mark"
if not errorlevel 1 (
if !linecount1c! GEQ %startline% (

call :wholepatrolnamecheck
)
)
)


del "Temp\var1b.txt" /q
goto :eof

:wholepatrolnamecheck
SETLOCAL ENABLEDELAYEDEXPANSION

if not "!var1!"=="!wholepatrolname!" (

goto :notpatrol
) else (
goto :eof
)

:notpatrol

if defined wholenextpatrolname (
if "!var1!"=="!wholenextpatrolname!" goto :eof
)

echo !var1!|findstr "Mark"
if errorlevel 1 (goto :eof)


call :part2
call :part3
call :part4
)


del "Temp\var1b.txt" /q

goto :eof



::PART2 ASSIGNING VAR2

:part2

for /f "delims=" %%a in ('findstr /e /s "!var1!" "!sh3saves!\data\cfg\Backups_SCR2\*.map"') do (
set fulldirpath2=!fulldirpath2!%%~fa

set /a patroldir2=!PatrolNumber!-1

set careerdir2=!CareerName!





for /f "tokens=1 delims=." %%q in ('findstr /e "!var1!" "!sh3saves!\data\cfg\Backups_SCR2\!careerdir2!\!patroldir2!\*.map"') do set FileName=%%~nq


findstr /e /c:"!var1!" "!sh3saves!\data\cfg\Backups_SCR2\!careerdir2!\!patroldir2!\!FileName!.map" 
if not errorlevel 1 (

for /f "tokens=2 delims==,." %%B in ('findstr /e /c:"!var1!" "!sh3saves!\data\cfg\Backups_SCR2\!careerdir2!\!patroldir2!\!FileName!.map"') do (
set var2=
set var2=!var2!%%B



goto :eof
)
) else (goto :eof)

)



::PART3 ASSIGNING VAR3

:part3

for /f "tokens=4 delims==,." %%C in ('findstr /e /c:"!var1!" "!sh3saves!\data\cfg\Backups_SCR2\!careerdir2!\!patroldir2!\!FileName!.map"') do (
set var3=
set var3=!var3!%%C



goto :eof
)




::PART 4 ASSIGNING VAR4

:part4

SETLOCAL ENABLEDELAYEDEXPANSION




for /F "tokens=1 delims= " %%p in (variable.txt) do (
set PrevPatName=%%p
)

for /F "tokens=1 delims= " %%p in (variable2.txt) do (
set PrevName=%%p
)

set PrevName=
for /F "tokens=1 delims= " %%p in (variable3.txt) do (
set PrevPatNum=%%p
)


if defined PrevPatName (
goto defined
) else (
goto notsame
)

:defined
if !PrevPatName! EQU %patroldir2% (
goto same
) else (
goto notsame
)


:same
if !PrevName! EQU %FileName% (
goto same2
) else (
goto samenotsame
)

:same2
:samenotsame
set /a PrevPatNum+=1

goto return5

:notsame
set /a PrevPatNum=1


:return5



set /a maxlines4=0
set /a maxlines4=!PrevPatNum!
set /a linecount4=0



del "Temp\shipsunk.txt" /q

for /f "tokens=3 delims=|" %%D in ('findstr /c:"Ship sunk" "!sh3saves!\data\cfg\Backups_SCR2\!careerdir2!\!patroldir2!\!FileName!.clg"') do (
set /a linecount4+=1
set var4a=
set var4a=%%D
echo !var4a!> Temp\shipsunk.txt

for /f "tokens=1 delims=," %%d in (Temp\shipsunk.txt) do (
set var4= 
set var4=%%d
)

if !linecount4! GEQ %maxlines4% goto :prepart5
)


:prepart5


::PART5 ASSIGNING VAR5

:part5




:part5b

set file="!sh3saves!\data\cfg\Backups_SCR2\!careerdir2!\!patroldir2!\!FileName!.clg"

copy "!sh3saves!\data\cfg\Backups_SCR2\!careerdir2!\!patroldir2!\!FileName!.clg" "working.clg"


:part5c
set /a maxlines5a=0
set maxlines5a=!PrevPatNum!
set /a linecount5a=0


SETLOCAL ENABLEDELAYEDEXPANSION
set line1=
for /f "tokens=1 delims=:" %%i in ('findstr /N /c:"Ship sunk" working.clg') do (
   set line1=%%i
set /a linecount5a+=1
if !linecount5a! GEQ %maxlines5a% goto part5cb
) 

:part5cb

set /A lineskip=line1+1
if defined line1 (
   for /f "skip=%lineskip% tokens=2 delims==" %%j in (working.clg) do (
set var5=%%j
goto part6
   )
) 






::PART6 ADJUSTING VARIABLES JUST BEFORE PLACING INTO PERL SCRIPT



:part6


findstr /c:"!var1! !var2! !var3! !var4! !var5! " "Temp\!careerdir2!oldvariables.txt"
if not errorlevel 1 (
goto :eof
) else (
goto var6temp1
)

:var6temp1

findstr /c:"!var1! !var2! !var3! !var4! !var5! " "Temp\!careerdir2!random.txt"
if not errorlevel 1 (
goto :eof
) else (
goto var6temp2
)

:var6temp2

copy /y "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\Campaign_SCR.mis" Campaign_SCR2.mis.tmp

copy /y "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\Campaign_RND.mis" Campaign_RND2.mis.tmp

copy /y "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\Campaign_SCR.mis" Campaign_SCR.mis




if defined var2 (
if defined var3 (
if defined var4 (goto part6next
) else (goto :eof)
) else (goto :eof)
) else (goto :eof)

:part6next



set /a maxlinesnf=0
set /a maxlinesnf+=1000
set /a linecountnf=0

if exist "Temp\var2a" (
del "Temp\var2a.txt" /q
del "Temp\var2b.txt" /q
del "Temp\var3a.txt" /q
del "Temp\var3b.txt" /q
)


del variable.txt
echo !patroldir2! > variable.txt

del variable2.txt
echo !FileName! > variable2.txt

del variable3.txt
echo !PrevPatNum! > variable3.txt

set /a var2a=!var2!/100
set /a var2b=!var2!/100

set /a var3a=!var3!/100
set /a var3b=!var3!/100

set /a var2a+=1


set /a var3a+=1



call :DateToJDN !var5! JDN=
set /A JDN+=1
call :JDNToDate %JDN% var5a=


call :DateToJDN !var5! JDN=
set /A JDN-=1
call :JDNToDate %JDN% var5b=













:part6nf





::PART6A LAUNCHING PERL SCRIPT AND OUTPUTTING VARIABLES TO INPUT.TXT

:part6a

del input.txt /q

echo !var2a!
echo !var2b!
echo !var3a!
echo !var3b!
echo !var5a!
echo !var5b!

echo s> "input.txt"
echo !var5b!>> "input.txt"
echo !var5a!>> "input.txt"
echo !var2a!>> "input.txt"
echo !var2b!>> "input.txt"
echo !var3a!>> "input.txt"
echo !var3b!>> "input.txt"
echo y>> "input.txt"



cd "!sh3directory!\Dynamic Campaign\PERL"

PosTimeFilter.exe < input.txt
type input.txt | PosTimeFilter.exe





findstr "Class=!var4!" "PosTime_Campaign_SCR.mis" 
if not errorlevel 1 (
goto nextstep1
)else (
if !linecountnf! GEQ %maxlinesnf% (

echo|set /p=!var1! >> "Temp\!careerdir2!random.txt"
echo|set /p=!var2! >> "Temp\!careerdir2!random.txt"
echo|set /p=!var3! >> "Temp\!careerdir2!random.txt"
echo|set /p=!var4! >> "Temp\!careerdir2!random.txt"
echo|set /p=!var5! >> "Temp\!careerdir2!random.txt"

 goto :eof
)
goto notfound
)


:notfound
SETLOCAL ENABLEDELAYEDEXPANSION
set /a linecountnf+=1



if exist "Temp\var2a" (
del "Temp\var2a.txt" /q
del "Temp\var2b.txt" /q
del "Temp\var3a.txt" /q
del "Temp\var3b.txt" /q
del "Temp\var5a.txt" /q
del "Temp\var5b.txt" /q
)

set /a divnumber=!linecountnf!/2
set /a sum=!divnumber!*2




if !linecountnf! NEQ %sum% goto odds
if !linecountnf! EQU %sum% goto evens


:odds
echo !var2a! > "Temp\var2a.txt"
set /a var2b-=1
echo !var2b! > "Temp\var2b.txt"
echo !var3a! > "Temp\var3a.txt"
set /a var3b-=1
echo !var3b! > "Temp\var3b.txt"

goto afteroddeven

:evens
set /a var2a+=1
echo !var2a! > "Temp\var2a.txt"
echo !var2b! > "Temp\var2b.txt"
set /a var3a+=1
echo !var3a! > "Temp\var3a.txt"
echo !var3b! > "Temp\var3b.txt"


:afteroddeven

set /a divnumber2=!linecountnf!/500
set /a sum2=!divnumber2!*500

if !linecountnf! EQU %sum2% goto fivehundred

goto afterfivehundred

:fivehundred
call :DateToJDN !var5a! JDN=
set /A JDN+=1
call :JDNToDate %JDN% var5a=
echo !var5a! > "Temp\var5a.txt"

call :DateToJDN !var5b! JDN=
set /A JDN-=1
call :JDNToDate %JDN% var5b=

echo !var5b! > "Temp\var5b.txt"

:afterfivehundred

echo !var2a!
echo !var2b!
echo !var3a!
echo !var3b!

goto part6nf




:nextstep1






::SETTING VAR6

SETLOCAL ENABLEDELAYEDEXPANSION

for /f "tokens=2 delims==" %%L in (PosTime_Campaign_SCR.mis) do (
if /i "%%L" equ "%var4%" (
        goto endloop
    )
    	    set "var6=%%L"
)


:endloop


:var6temp

echo !var6!> "Temp\var6.txt"
echo !var6!>> "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\sunkships.txt"
echo.>> "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\sunkships.txt"


::ADDING SHIPDUMMY


SETLOCAL ENABLEDELAYEDEXPANSION
find "!var6!" < "Campaign_SCR2.mis.tmp" >nul && (
call :replace "!var6!"
call :stripdup "Campaign_SCR2.mis.tmp.tmp2" "Campaign_SCR2.mis.tmp" "(Class=.*\nType=.*\nOrigin=.*\nSide=.*)\nClass=.*\nType=.*\nOrigin=.*\nSide=.*" "$1"
del "Campaign_SCR2.mis.tmp.tmp2"
)
)
)
goto Loop
goto :EOF

:replace
set vbs="%temp%\%random%.vbs"
if exist %vbs% goto :replace

 >%vbs% echo set regex=new regexp
>>%vbs% echo regex.global=true
>>%vbs% echo regEx.IgnoreCase=False
>>%vbs% echo regex.pattern="\nName=%~1[\W]*\n"
>>%vbs% echo wscript.stdOut.write regex.replace(wscript.stdin.readall,"Name=ShipDummy"+vbCRLF+"Class=ShipDummy"+vbCRLF+"Type=0"+vbCRLF+"Origin=Environmental"+vbCRLF+"Side=0"+vbCRLF)
cscript /nologo %vbs% <"Campaign_SCR2.mis.tmp" >"Campaign_SCR2.mis.tmp.tmp2"
del %vbs%
goto :EOF


:stripdup
set vbs="%temp%\%random%.vbs"
if exist %vbs% goto :stripdup


 >%vbs% echo set regex=new regexp
>>%vbs% echo regex.global=true
>>%vbs% echo regEx.IgnoreCase=False
>>%vbs% echo regex.pattern="%~3"
>>%vbs% echo wscript.stdOut.write regex.replace(wscript.stdin.readall,"%~4")
cscript /nologo %vbs% <"%~1" >"%~2"
del %vbs%
goto :EOF


:exitloop4
:Loop



for /f "delims=" %%a in (List.txt) do (
findstr "%%a" "Temp\var6.txt" >nul 
if not errorlevel 1 (
find "%%a" < "Campaign_SCR2.mis.tmp" >nul && (
call :replace "%%a"
call :stripdup "Campaign_SCR2.mis.tmp.tmp2" "Campaign_SCR2.mis.tmp" "(Class=.*\nType=.*\nOrigin=.*\nSide=.*)\nClass=.*\nType=.*\nOrigin=.*\nSide=.*" "$1"
del "Campaign_SCR2.mis.tmp.tmp2"
)
)
)

goto Loop2
goto :EOF

:replace
set vbs="%temp%\%random%.vbs"
if exist %vbs% goto :replace

 >%vbs% echo set regex=new regexp
>>%vbs% echo regex.global=true
>>%vbs% echo regEx.IgnoreCase=False
>>%vbs% echo regex.pattern="\nName=.*%~1.*\n"
>>%vbs% echo wscript.stdOut.write regex.replace(wscript.stdin.readall,"Name=ShipDummy"+vbCRLF+"Class=ShipDummy"+vbCRLF+"Type=0"+vbCRLF+"Origin=Environmental"+vbCRLF+"Side=0"+vbCRLF)
cscript /nologo %vbs% <"Campaign_SCR2.mis.tmp" >"Campaign_SCR2.mis.tmp.tmp2"
del %vbs%
goto :EOF


:stripdup
set vbs="%temp%\%random%.vbs"
if exist %vbs% goto :stripdup


 >%vbs% echo set regex=new regexp
>>%vbs% echo regex.global=true
>>%vbs% echo regEx.IgnoreCase=False
>>%vbs% echo regex.pattern="%~3"
>>%vbs% echo wscript.stdOut.write regex.replace(wscript.stdin.readall,"%~4")
cscript /nologo %vbs% <"%~1" >"%~2"
del %vbs%
goto :EOF


:exitloop5
:Loop2



for /f "delims=" %%a in (List.txt) do (
findstr "%%a" "Temp\var6.txt" >nul 
if not errorlevel 1 (
find "%%a" < "Campaign_RND2.mis.tmp" >nul && (
call :replace "%%a"
call :stripdup "Campaign_RND2.mis.tmp.tmp2" "Campaign_RND2.mis.tmp" "(Class=.*\nType=.*\nOrigin=.*\nSide=.*)\nClass=.*\nType=.*\nOrigin=.*\nSide=.*" "$1"
del "Campaign_RND2.mis.tmp.tmp2"
)
)
)

goto Loop2
goto :EOF

:replace
set vbs="%temp%\%random%.vbs"
if exist %vbs% goto :replace

 >%vbs% echo set regex=new regexp
>>%vbs% echo regex.global=true
>>%vbs% echo regEx.IgnoreCase=False
>>%vbs% echo regex.pattern="\nName=.*%~1.*\n"
>>%vbs% echo wscript.stdOut.write regex.replace(wscript.stdin.readall,"Name=ShipDummy"+vbCRLF+"Class=ShipDummy"+vbCRLF+"Type=0"+vbCRLF+"Origin=Environmental"+vbCRLF+"Side=0"+vbCRLF)
cscript /nologo %vbs% <"Campaign_RND2.mis.tmp" >"Campaign_RND2.mis.tmp.tmp2"
del %vbs%
goto :EOF


:stripdup
set vbs="%temp%\%random%.vbs"
if exist %vbs% goto :stripdup


 >%vbs% echo set regex=new regexp
>>%vbs% echo regex.global=true
>>%vbs% echo regEx.IgnoreCase=False
>>%vbs% echo regex.pattern="%~3"
>>%vbs% echo wscript.stdOut.write regex.replace(wscript.stdin.readall,"%~4")
cscript /nologo %vbs% <"%~1" >"%~2"
del %vbs%
goto :EOF


:exitloop5
:Loop2






echo|set /p=!var1! >> "Temp\!careerdir2!oldvariables.txt"
echo|set /p=!var2! >> "Temp\!careerdir2!oldvariables.txt"
echo|set /p=!var3! >> "Temp\!careerdir2!oldvariables.txt"
echo|set /p=!var4! >> "Temp\!careerdir2!oldvariables.txt"
echo|set /p=!var5! >> "Temp\!careerdir2!oldvariables.txt"


del Campaign_SCR.mis /q

copy Campaign_SCR2.mis.tmp Campaign_SCR.mis
goto :part7

goto :EOF



:part7

copy Campaign_SCR2.mis.tmp "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\Campaign_SCR.mis"

copy Campaign_RND2.mis.tmp "!sh3directory!\Dynamic Campaign\Careers\!CareerName!\Campaign_RND.mis"


goto :eof



::FINISH

:finish




del Campaign_SCR2.mis.tmp /q

del Campaign_RND2.mis.tmp /q

del Campaign_SCR.mis /q

del Marks.txt /q

del List.txt /q

del PosTime_Campaign_SCR.mis /q

del working.clg /q

del variable.txt /q

del variable2.txt /q

del variable3.txt /q

del input.txt /q

del "Campaign_SCR.mis.tmp.tmp2" /q

del "Temp\shipsunk.txt" /q
del "Temp\var1.txt" /q
del "Temp\var1b.txt" /q
del "Temp\var1c.txt" /q
del "Temp\var2a.txt" /q
del "Temp\var2b.txt" /q
del "Temp\var3a.txt" /q
del "Temp\var3b.txt" /q
del "Temp\var5a.txt" /q
del "Temp\var5b.txt" /q
del "Temp\var6.txt" /q
del "Temp\pat1.txt" /q
del "Temp\prevcareer.txt" /q

RD /S /Q "!sh3saves!\data\cfg\Backups_SCR2"



endlocal 




tasklist /FI "IMAGENAME eq sh3.exe" | find /i "sh3.exe"  
IF not ERRORLEVEL 1 (GOTO start) 
IF ERRORLEVEL 1 (GOTO TEST1)  

:TEST1

exit











::ADJUSTING VARIABLES TO DATE JULIAN CALENDAR


SETLOCAL ENABLEDELAYEDEXPANSION
rem Convert the date to Julian Day Number

:DateToJDN yyyymmdd jdn=
setlocal
set date=%1
set /A yy=%date:~0,4%, mm=1%date:~4,2% %% 100, dd=1%date:~6% %% 100
set /A a=mm-14, jdn=(1461*(yy+4800+a/12))/4+(367*(mm-2-12*(a/12)))/12-(3*((yy+4900+a/12)/100))/4+dd-32075
endlocal & set %2=%jdn%
exit /B


SETLOCAL ENABLEDELAYEDEXPANSION

rem Convert Julian Day Number back to date

:JDNToDate jdn yyyymmdd=
setlocal
set /A l=%1+68569,n=(4*l)/146097,l=l-(146097*n+3)/4,i=(4000*(l+1))/1461001,l=l-(1461*i)/4+31,j=(80*l)/2447,dd=l-(2447*j)/80,l=j/11,mm=j+2-(12*l),yy=100*(n-49)+i+l
if %dd% lss 10 set dd=0%dd%
if %mm% lss 10 set mm=0%mm%
endlocal & set %2=%yy%%mm%%dd%
exit /B











