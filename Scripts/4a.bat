@echo off
setlocal enabledelayedexpansion
set count=1
echo %time%
del "4a.txt" /q
copy /y "finished.mis" "finished.mis.txt"
for /f "tokens=2 delims=.] " %%f in ('findstr /c:"[Unit " "finished.mis.txt"') do (
set var4=%%f
echo !var4!

echo [Unit !var4!>> 4a.txt
set count=count+1 

)

start /b "" "5a.bat"
