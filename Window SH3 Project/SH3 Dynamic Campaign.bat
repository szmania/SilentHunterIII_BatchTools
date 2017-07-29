@echo off



setlocal enabledelayedexpansion

for /f "usebackq delims=" %%q in ("Dynamic Campaign\VARIABLES\sh3directory.txt") do (
set sh3directory=%%q
)

for /f "usebackq delims=" %%r in ("Dynamic Campaign\VARIABLES\sh3saves.txt") do (
set sh3saves=%%r
)

for /f "usebackq delims=" %%s in ("Dynamic Campaign\VARIABLES\sh3commander.txt") do (
set sh3commander=%%s
)

cd /d "!sh3directory!"


setlocal enabledelayedexpansion

del "!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt" /q



if not exist "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" (

mkdir "!sh3directory!\Dynamic Campaign\Original Backups"

copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis"

)


if not exist "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" (

mkdir "!sh3directory!\Dynamic Campaign\Original Backups"

copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis"

)


for /f "delims=" %%A in ('dir "!sh3saves!\data\cfg\Careers" /A:D /b') do ( 
set careerdirectory=%%A

if not exist "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_SCR.mis" (

mkdir "!sh3directory!\Dynamic Campaign\Careers"

mkdir "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!"


if exist "!sh3directory!\Dynamic Campaign\Original Backups" (

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_SCR.mis"
copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_RND.mis"
)

else (
copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_SCR.mis"
copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_RND.mis"
)
)
)


if not exist "!sh3directory!\Dynamic Campaign\Original Backups\EnglishNames.cfg" (

copy /-y "!sh3directory!\data\Sea\EnglishNames.cfg" "!sh3directory!\Dynamic Campaign\Original Backups\EnglishNames.cfg"

copy /-y "!sh3directory!\data\Sea\GermanNames.cfg" "!sh3directory!\Dynamic Campaign\Original Backups\GermanNames.cfg"

copy /-y "!sh3directory!\data\Sea\FrenchNames.cfg" "!sh3directory!\Dynamic Campaign\Original Backups\FrenchNames.cfg"
)



setlocal enabledelayedexpansion

:typeofgame
echo.
echo.
echo.
echo Select a task:
 echo =============
 echo.
 echo 1) Play Campaign/Missions with Dynamic Campaign
 echo 2) Play Campaign/Missions with Dynamic Campaign AND SH3 Commander
 echo 3) Play Standard Campaign/Missions
 echo 4) Backup Standard Campaign files
 echo 5) Ensure Standard Campaign files are enabled (use if computer crashes during Dynamic Campaign or DC SH3 Commander play)
 echo 6) Uninstall SH3 Dynamic Campaign
 echo 7) Exit
 echo.
 echo HINT: (press the corresponding number and press "ENTER")
 echo.

set /p web=Type option:
 if "%web%"=="1" goto dynamiccampaign
 if "%web%"=="2" goto dynamiccampaignsh3commander
 if "%web%"=="3" goto standard
 if "%web%"=="4" goto backup
 if "%web%"=="5" goto crash
 if "%web%"=="6" goto uninstall
 if "%web%"=="7" exit



:dynamiccampaign

setlocal enabledelayedexpansion

mkdir "!sh3directory!\Dynamic Campaign\PERL\Temp"

dir "!sh3saves!\data\cfg\Careers" /A:D /b >"!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt"


for /f "usebackq delims=" %%A in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do ( 
set careerdir1=%%A
goto 2)
:2
for /f "usebackq skip=1 delims=" %%B in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir2=%%B
goto 3
)
:3
for /f "usebackq skip=2 delims=" %%C in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir3=%%C
goto 4
)
:4
for /f "usebackq skip=3 delims=" %%D in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir4=%%D
goto 5
)
:5
for /f "usebackq skip=4 delims=" %%E in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir5=%%E
goto 6
)
:6
for /f "usebackq skip=5 delims=" %%F in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir6=%%F
goto 7
)
:7
for /f "usebackq skip=6 delims=" %%G in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir7=%%G
goto 8
)
:8
for /f "usebackq skip=7 delims=" %%H in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir8=%%H
goto 9
)
:9
for /f "usebackq skip=8 delims=" %%I in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir9=%%I
goto 10
)
:10
for /f "usebackq skip=9 delims=" %%J in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir10=%%J
goto 11
)
:11
for /f "usebackq skip=10 delims=" %%K in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir11=%%K
goto 12
)
:12
for /f "usebackq skip=11 delims=" %%L in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir12=%%L
goto 13
)
:13
for /f "usebackq skip=12 delims=" %%M in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir13=%%M
goto 14
)
:14
for /f "usebackq skip=13 delims=" %%N in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir14=%%N
goto 15
)
:15
for /f "usebackq skip=14 delims=" %%O in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir15=%%O
goto 16
)
:16
setlocal enabledelayedexpansion



echo.
echo.
echo.
echo Select which career you'd like to play:
 echo =============
 echo.
 echo 1) !careerdir1!
 echo 2) !careerdir2!
 echo 3) !careerdir3!
 echo 4) !careerdir4!
 echo 5) !careerdir5!
 echo 6) !careerdir6!
 echo 7) !careerdir7!
 echo 8) !careerdir8!
 echo 9) !careerdir9!
 echo 10) !careerdir10!
 echo 11) !careerdir11!
 echo 12) !careerdir12!
 echo 13) !careerdir13!
 echo 14) !careerdir14!
 echo 15) !careerdir15!
 echo 16) New Career
 echo 17) Back
 echo 18) Exit
 echo.
 echo HINT: (press the corresponding number and press "ENTER")
 echo.


set /p career=Type option:
 if "%career%"=="1" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir1!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir1!
 goto afterdc)
 if "%career%"=="2" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir2!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir2!
 goto afterdc)
 if "%career%"=="3" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir3!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir3!
 goto afterdc)
 if "%career%"=="4" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir4!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir4!
 goto afterdc)
 if "%career%"=="5" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir5!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir5!
 goto afterdc)
 if "%career%"=="6" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir6!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir6!
 goto afterdc)
 if "%career%"=="7" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir7!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir7!
 goto afterdc)
 if "%career%"=="8" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir8!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir8!
 goto afterdc)
 if "%career%"=="9" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir9!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir9!
 goto afterdc)
 if "%career%"=="10" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir10!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir10!
 goto afterdc)
 if "%career%"=="11" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir11!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir11!
 goto afterdc)
 if "%career%"=="12" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir12!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir12!
 goto afterdc)
 if "%career%"=="13" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir13!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir13!
 goto afterdc)
 if "%career%"=="14" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir14!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir14!
 goto afterdc)
 if "%career%"=="15" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir15!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir15!
 goto afterdc)
 if "%career%"=="16" goto :newcareer
 if "%career%"=="17" goto :typeofgame
 if "%career%"=="18" exit

:newcareer

set /p newcareer=Please enter the EXACT name of the career you plan to create. Example: John Smith :
set careerdirectory2=!newcareer!

if not exist "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!" (

mkdir "!sh3directory!\Dynamic Campaign\Careers"
mkdir "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!"

if exist "!sh3directory!\Dynamic Campaign\Original Backups" (

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_SCR.mis"
copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_RND.mis"
)

else (
copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_SCR.mis"
copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_RND.mis"
)

)



:afterdc

del "!sh3directory!\data\Sea\EnglishNames.cfg" /q

del "!sh3directory!\data\Sea\GermanNames.cfg" /q

del "!sh3directory!\data\Sea\FrenchNames.cfg" /q

copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"

copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_RND.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis"

echo.
echo.
echo starting Silent Hunter 3...

ping -n 5 -w 1000 127.0.0.1 > nul

cd /d "!sh3directory!"

start sh3.exe

ping -n 5 -w 2000 127.0.0.1 > nul

cd /d "!sh3directory!\Dynamic Campaign\PERL"

start /min BATCH_SCR2.bat

if not "%minimized%"=="" goto :minimized
set minimized=true
:minimized


:TEST2

for /f "delims=" %%A in ('dir "!sh3saves!\data\cfg\Careers" /A:D /b') do ( 
set careerdirectory=%%A

if not exist "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_SCR.mis" (

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_SCR.mis"
copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_RND.mis"

)
)

ping -n 10 -w 1000 127.0.0.1 > nul

copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"

copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_RND.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis"


tasklist /FI "IMAGENAME eq sh3.exe" | find /i "sh3.exe"  
IF NOT ERRORLEVEL 1 (GOTO TEST2) 
IF ERRORLEVEL 1 (GOTO TEST1)


:TEST1

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" 

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis"

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\EnglishNames.cfg" "!sh3directory!\data\Sea\EnglishNames.cfg"

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\GermanNames.cfg" "!sh3directory!\data\Sea\GermanNames.cfg" 

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\FrenchNames.cfg" "!sh3directory!\data\Sea\FrenchNames.cfg" 

del "!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt" /q

exit








:dynamiccampaignsh3commander


setlocal enabledelayedexpansion


mkdir "!sh3directory!\Dynamic Campaign\PERL\Temp"

dir "!sh3saves!\data\cfg\Careers" /A:D /b > "!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt"


for /f "usebackq delims=" %%A in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do ( 
set careerdir21=%%A
goto 22)
:22
for /f "usebackq skip=1 delims=" %%B in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir22=%%B
goto 23
)
:23
for /f "usebackq skip=2 delims=" %%C in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir23=%%C
goto 24
)
:24
for /f "usebackq skip=3 delims=" %%D in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir24=%%D
goto 25
)
:25
for /f "usebackq skip=4 delims=" %%E in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir25=%%E
goto 26
)
:26
for /f "usebackq skip=5 delims=" %%F in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir26=%%F
goto 27
)
:27
for /f "usebackq skip=6 delims=" %%G in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir27=%%G
goto 28
)
:28
for /f "usebackq skip=7 delims=" %%H in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir28=%%H
goto 29
)
:29
for /f "usebackq skip=8 delims=" %%I in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir29=%%I
goto 30
)
:30
for /f "usebackq skip=9 delims=" %%J in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir30=%%J
goto 31
)
:31
for /f "usebackq skip=10 delims=" %%K in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir31=%%K
goto 32
)
:32
for /f "usebackq skip=11 delims=" %%L in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir32=%%L
goto 33
)
:33
for /f "usebackq skip=12 delims=" %%M in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir33=%%M
goto 34
)
:34
for /f "usebackq skip=13 delims=" %%N in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir34=%%N
goto 35
)
:35
for /f "usebackq skip=14 delims=" %%O in ("!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt") do (
set careerdir35=%%O
goto 36
)
:36


setlocal enabledelayedexpansion
echo.
echo.
echo Select which career you'd like to play:
 echo =============
 echo.
 echo 1) !careerdir21!
 echo 2) !careerdir22!
 echo 3) !careerdir23!
 echo 4) !careerdir24!
 echo 5) !careerdir25!
 echo 6) !careerdir26!
 echo 7) !careerdir27!
 echo 8) !careerdir28!
 echo 9) !careerdir29!
 echo 10) !careerdir30!
 echo 11) !careerdir31!
 echo 12) !careerdir32!
 echo 13) !careerdir33!
 echo 14) !careerdir34!
 echo 15) !careerdir35!
 echo 16) New Career
 echo 17) Back
 echo 18) Exit
 echo.
 echo HINT: Press the corresponding number and press "ENTER"
 echo.


set /p career=Type option:
 if "%career%"=="1" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir21!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" 
set careerdirectory2=!careerdir21!
goto afterdcsh3)
 if "%career%"=="2" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir22!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir22!
 goto afterdcsh3)
 if "%career%"=="3" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir23!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir23!
 goto afterdcsh3)
 if "%career%"=="4" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir24!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir24!
 goto afterdcsh3)
 if "%career%"=="5" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir25!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir25!
 goto afterdcsh3)
 if "%career%"=="6" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir26!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir26!
 goto afterdcsh3)
 if "%career%"=="7" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir27!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir27!
 goto afterdcsh3)
 if "%career%"=="8" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir28!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir28!
 goto afterdcsh3)
 if "%career%"=="9" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir29!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir29!
 goto afterdcsh3)
 if "%career%"=="10" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir30!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir30!
 goto afterdcsh3)
 if "%career%"=="11" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir31!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir31!
 goto afterdcsh3)
 if "%career%"=="12" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir32!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir32!
 goto afterdcsh3)
 if "%career%"=="13" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir33!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir33!
 goto afterdcsh3)
 if "%career%"=="14" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir34!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir34!
 goto afterdcsh3)
 if "%career%"=="15" (copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdir35!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"
set careerdirectory2=!careerdir35!
 goto afterdcsh3)
 if "%career%"=="16" goto :sh3commandernewcareer
 if "%career%"=="17" goto :typeofgame
 if "%career%"=="18" exit


:sh3commandernewcareer
echo.
echo Please keep this window open and launch SH3 Commander. In SH3 Commander create a new career. 
set /p newcareer=Once created, EXIT SH3 Commander and type the EXACT name of your new career here: 
set careerdirectory2=!newcareer!


if not exist "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!" (

mkdir "!sh3directory!\Dynamic Campaign\Careers"
mkdir "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!"

if exist "!sh3directory!\Dynamic Campaign\Original Backups" (

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_SCR.mis"
copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_RND.mis"
)

else (
copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_SCR.mis"
copy /y "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_RND.mis"
)

)


:afterdcsh3

copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"

copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_RND.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis" 


echo.
echo.
echo SH3 Commander is now launching....... Please launch Silent Hunter 3 through SH3 Commander after your settings there are to your liking.

ping -n 5 -w 1000 127.0.0.1 > nul

cd /d "!sh3commander!"

start SH3Cmdr.exe


:TEST3sh3
tasklist /FI "IMAGENAME eq sh3.exe" | find /i "sh3.exe"  
IF ERRORLEVEL 2 GOTO TEST4sh3 
IF ERRORLEVEL 1 GOTO TEST3sh3 


:TEST4sh3  

cd /d "!sh3directory!\Dynamic Campaign\PERL"

start /min BATCH_SCR2.bat



:TEST2sh3

for /f "delims=" %%A in ('dir "!sh3saves!\data\cfg\Careers" /A:D /b') do ( 
set careerdirectory=%%A

if not exist "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_SCR.mis" (

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_SCR.mis"
copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory!\Campaign_RND.mis"
)
)


ping -n 10 -w 1000 127.0.0.1 > nul

copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis"

copy /y "!sh3directory!\Dynamic Campaign\Careers\!careerdirectory2!\Campaign_RND.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis"

tasklist /FI "IMAGENAME eq sh3.exe" | find /i "sh3.exe" 
IF NOT ERRORLEVEL 1 (GOTO TEST2sh3)    
IF ERRORLEVEL 1 (GOTO TEST1sh3)


:TEST1sh3

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" 

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis"

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\EnglishNames.cfg" "!sh3directory!\data\Sea\EnglishNames.cfg"

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\GermanNames.cfg" "!sh3directory!\data\Sea\GermanNames.cfg" 

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\FrenchNames.cfg" "!sh3directory!\data\Sea\FrenchNames.cfg" 

del "!sh3directory!\Dynamic Campaign\PERL\Temp\filepath.txt" /q

exit








:standard

start sh3.exe

exit






:backup

copy /-y "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis"

copy /-y "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis" "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis"

copy /-y "!sh3directory!\data\Sea\EnglishNames.cfg" "!sh3directory!\Dynamic Campaign\Original Backups\EnglishNames.cfg"

copy /-y "!sh3directory!\data\Sea\GermanNames.cfg" "!sh3directory!\Dynamic Campaign\Original Backups\GermanNames.cfg"

copy /-y "!sh3directory!\data\Sea\FrenchNames.cfg" "!sh3directory!\Dynamic Campaign\Original Backups\FrenchNames.cfg"


goto :typeofgame




:crash

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" 

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis"

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\EnglishNames.cfg" "!sh3directory!\data\Sea\EnglishNames.cfg"

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\GermanNames.cfg" "!sh3directory!\data\Sea\GermanNames.cfg" 

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\FrenchNames.cfg" "!sh3directory!\data\Sea\FrenchNames.cfg" 

echo.
echo Your SH3 Dynamic Campaign has been recovered successfully from the crash. 


goto :typeofgame




:uninstall

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_SCR.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_SCR.mis" 

copy /y "!sh3directory!\Dynamic Campaign\Original Backups\Campaign_RND.mis" "!sh3directory!\data\Campaigns\Campaign\Campaign_RND.mis" 

rd /s /q "!sh3directory!\Dynamic Campaign"

rd /s /q "!sh3directory!\DC-BACKUP"

del "!sh3directory!\sh3dc.ico" /q

del "%userprofile%\Start Menu\Programs\Ubisoft\Silent Hunter III\SH3 Dynamic Campaign.lnk" /q

echo.
echo SH3 Dynamic Campaign has been uninstalled successfully.
pause

SETLOCAL
SET "someOtherProgram=SH3 Dynamic Campaign.bat"
TASKKILL /IM "%someOtherProgram%"
DEL "%~f0"
