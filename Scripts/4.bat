@echo off
setlocal enabledelayedexpansion
set count=1
echo %time%
copy /y "finished.mis" "finished.mis.txt"
del "4.txt" /q
for /f "tokens=2 delims=.] " %%f in ('findstr /c:"[Group " "finished.mis.txt"') do (
set var4=%%f
echo !var4!

echo [Group !var4!>> 4.txt
set count=count+1 

)

start /b "" "5.bat"