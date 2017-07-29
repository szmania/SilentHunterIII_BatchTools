@echo off
setlocal enabledelayedexpansion
set count=1
echo %time%
del "4c.txt" /q
copy /y "finished.mis" "finished.mis.txt"
for /f "tokens=2 delims=.] " %%f in ('findstr /c:"[OrdnanceUnit " "finished.mis.txt"') do (
set var4=%%f
echo !var4!

echo [OrdnanceUnit !var4!>> 4c.txt
set count=count+1 

)

start /b "" "5c.bat"
