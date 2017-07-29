@echo off

ping -n 5 -w 1000 127.0.0.1 > nul

call "%cd%\WINDOWED.exe"