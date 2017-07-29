Const ForReading = 1, ForWriting = 2, ForAppending = 8

  infile = "Campaign_SCR.mis"   '<= Set input file here
  outfile = "Campaign_LND.mis.tmp"   '<= Set output file here
  tmp2infile = "test.txt"   '<= Set input file here
  tmpoutfile = "Campaign_LND.mis.tmp.tmp"   '<= Set output file here

    Set fso = CreateObject("Scripting.FileSystemObject")
	Set f1 = fso.OpenTextFile(infile, ForReading)
	Set f2 = fso.OpenTextFile(outfile, ForWriting, True)
	Set d = Wscript.Createobject("Scripting.Dictionary")
	Set dAll = Wscript.Createobject("Scripting.Dictionary")

  Set objArgs = WScript.Arguments  
  
	found = "false"
	lineCount = 0
	
Function PlaceDup(line)
	if ((left(line,5) = "Name=") AND (found = "false")) then
		if not(d.Exists(line)) then
		d.Add line," "
		'Set f3 = fso.OpenTextFile(tmp2infile, ForAppending, True)
		'f3.writeline line
		'f3.Close
		else
		end if
	else
	end if
End Function

Function FoundDup(line, mainLineCount, myArray)
	if left(line,5) = "Name=" then
		if(d.Exists(line)) then
			'found = "true"
			DupTest line, found, mainLineCount, myArray
		else
			found = "false"
		end if
	
		'Set f5 = fso.OpenTextFile(tmp2infile, ForReading, True)		
		'Do While not f5.AtEndofStream	
		'	contents=f5.readline
		'	if (contents = line) then
		'		DupTest line, found, mainLineCount
				'found = "true"	
		'		Exit Do
		'	else
		'		found = "false"
		'	end if
	'	Loop
		'f5.Close
	else
	end if
End Function	



Function DupTest(line, found, mainLineCount, myArray)
	Set f8 = fso.OpenTextFile(infile, ForReading)
	countLine=0
	once = "false"
	Do While not F8.AtEndOfStream
		countLine=countLine+1
		dupLine = f8.readline
		if (dupLine = line) then
			once = "true"
			Do Until ((InStr(dupLine,"Class=")) <> 0)
				countLine=countLine+1
				dupLine = f8.readline	
			Loop
			firstClass=dupLine
			Do Until ((InStr(dupLine,"GameEntryDate=")) <> 0)
				countLine=countLine+1
				dupLine = f8.readline
			Loop
			firstEntry=dupLine
			Do Until ((InStr(dupLine,"GameExitDate=")) <> 0)
				countLine=countLine+1
				dupLine = f8.readline
			Loop
			firstExit=dupLine
			Do Until ((InStr(dupLine,"Long=")) <> 0)
				countLine=countLine+1
				dupLine = f8.readline
			Loop
			firstLong=dupLine
			Do Until  ((InStr(dupLine,"Lat=")) <> 0)
				countLine=countLine+1
				dupLine = f8.readline				
			Loop
			firstLat=dupLine
			
			'countLine2=0
			'Set f9 = fso.OpenTextFile(infile, ForReading)
			
			'Do Until (countLine2 = mainLineCount)
			'	dupLine = f9.readline
			'	countLine2=countLine2+1
			'Loop
			
			'Do Until ((InStr(dupLine,"Class=")) <> 0)
			'	dupLine = f9.readline
			'Loop
			'secondClass=dupLine
			secondClass=myArray(mainLineCount+1)
			if (secondClass = firstClass) then
				'Do Until ((InStr(dupLine,"GameEntryDate=")) <> 0)
				'WScript.Echo("HERE")
				'	dupLine = f9.readline
				'Loop
				'secondEntry=dupLine
				secondEntry=myArray(mainLineCount+12)
				if (secondEntry = firstEntry) then	
				'	Do Until ((InStr(dupLine,"GameExitDate=")) <> 0)
				'		dupLine = f9.readline
				'	Loop
				'	secondExit=dupLine
					secondExit=myArray(mainLineCount+14)
					if (secondExit = firstExit) then		
						'Do Until ((InStr(dupLine,"Long=")) <> 0)
						'	dupLine = f9.readline
						'Loop
						'secondLong=dupLine
						secondLong=myArray(mainLineCount+17)
						if (secondLong = firstLong) then	
						'	Do Until ((InStr(dupLine,"Lat=")) <> 0)
						'		dupLine = f9.readline
						'	Loop
						'	secondLat=dupLine	
							secondLat=myArray(mainLineCount+18)
							if (secondLat = firstLat) then
								found = "true"	
								Exit Do
							else
								found = "false"	
							Exit Do
							end if
						else
							found = "false"	
						Exit Do
						end if
					else
						found = "false"	
					Exit Do
					end if
				else
					found = "false"	
				Exit Do
				end if
			else
			found = "false"	
			Exit Do
			end if	
			f9.Close
		else
		end if
	Loop
	f8.Close
End Function

Function FindGroupNum(line)
	if left(line,7) = "[Group " then
		a=split(line,".",-1)
		maxloop=1
		linecount=0
		for each x in a
			linecount=linecount+1				
			if linecount = maxloop then
				b=split(x," ",-1)
				maxloop=2
				linecount=0
				for each y in b
					linecount=linecount+1
					if linecount = maxloop then
						if (InStr(y,"]")) = 0 then
							groupNum=y-timesThru
							supposedGroupNum=z
						else
							c=split(y,"]",-1)
							maxloop=1
							linecount=0
							for each z in c
								linecount=linecount+1
								if linecount = maxloop then
									groupNum=z-timesThru
									supposedGroupNum=z
								else
								end if
							next
						end if
					else
					end if
				next
			else
			end if
		next
	else
	end if
End Function


	mainLineCount = 0
	prevIsUnit="false"
	groupNumMinus1 = "false"
	unitType=407 
	timesThru=0
	secondMainLineCount=0
	Dim myArray()
	foundCount=0

	Do While not f1.AtEndOfStream
	secondMainLineCount=secondMainLineCount+1
	lineArray=f1.readline
	ReDim Preserve myArray(secondMainLineCount)
	myArray(secondMainLineCount) = lineArray
	WScript.Echo(secondMainLineCount)
	Loop
	f1.Close
	
	
	Set f1 = fso.OpenTextFile(infile, ForReading)
	
	Do While not F1.AtEndOfStream
	line=F1.readline
	mainLineCount = mainLineCount + 1

	FoundDup line, mainLineCount, myArray
	PlaceDup(line)

	
	if (found = "false") then
		f2.writeline line
	else
		foundCount=foundCount+1
		WScript.Echo("FOUND"&foundCount)
		Do Until ((left(line,1) = "[") AND ((InStr(line,"Waypoint ")) = 0))
			mainLineCount = mainLineCount + 1
			line=F1.readline	
		Loop
		
		Set f2 = fso.OpenTextFile(tmpoutfile, ForWriting, True)
		Set f7 = fso.OpenTextFile(outfile, ForReading)
		count=0
		if (((InStr(line,".Unit ")) = 0) AND ((InStr(tenthPrevLine,".Unit ")) = 0)) then
			Do Until (line3 = tenthPrevLine)
			count=count+1
			if (count > 1) then
				F2.writeline line3
			else
			end if
			line3=F7.readline		
			Loop
		else
			Do Until (line3 = prevLine)
			count=count+1
			if (count > 1) then
				F2.writeline line3
			else
			end if
			line3=F7.readline		
			Loop
		end if
	
		switch=outfile
		outfile=tmpoutfile
		tmpoutfile=switch
		f7.Close
		
		
		f2.writeline line
		found = "false"
	end if
	
	prevLine=line
	secondPrevLine=prevLine
	thirdPrevLine=secondPrevLine
	fourthPrevLine=thirdPrevLine
	fifthPrevLine=fourthPrevLine
	sixthPrevLine=fifthPrevLine
	seventhPrevLine=sixthPrevLine
	eighthPrevLine=seventhPrevLine
	ninthPrevLine=eighthPrevLine
	tenthPrevLine=ninthPrevLine
	Loop
	
f1.Close
f6.Close






