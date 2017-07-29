@echo off
setlocal enabledelayedexpansion
set count=1
echo %time%
copy /y "finished.mis" "finished.mis.txt"
del "4b.txt" /q
for /f "tokens=2,4 delims=.] " %%f in ('findstr /c:".Unit " "finished.mis.txt"') do (
set var5=%%f
set var4=%%g
echo !var4!

echo Group !var5!.Unit !var4!>> 4b.txt
set count=count+1 

)

start /b "" "5b.bat"