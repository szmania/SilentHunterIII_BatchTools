@echo off

setlocal enabledelayedexpansion

del AllUnits /q

mkdir AllUnits\Air
mkdir AllUnits\Land
mkdir AllUnits\Ordnance
mkdir AllUnits\Sea
mkdir AllUnits\Submarine

for /f "usebackq" %%m in (`dir /b "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster"`) do (
	copy /y "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster\%%m\Air\" AllUnits\Air\
)	

for /f "usebackq" %%m in (`dir /b "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster"`) do (
	copy /y "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster\%%m\Land\" AllUnits\Land\
)	

for /f "usebackq" %%m in (`dir /b "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster"`) do (
	copy /y "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster\%%m\Ordnance\" AllUnits\Ordnance\
)
	
for /f "usebackq" %%m in (`dir /b "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster"`) do (
	copy /y "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster\%%m\Sea\" AllUnits\Sea\
)	

for /f "usebackq" %%m in (`dir /b "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster"`) do (
	copy /y "E:\Dropbox\SH3 Files\SH3 BATCH TOOLS\Roster\%%m\Submarine\" AllUnits\Submarine\
)	