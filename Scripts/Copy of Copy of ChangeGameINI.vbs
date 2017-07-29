Const ForReading = 1, ForWriting = 2, ForAppending = 8

  infile = "Campaign_LND.mis"   '<= Set input file here
  outfile = "Campaign_LND.mis.tmp"   '<= Set output file here
  tmp2infile = "test.txt"   '<= Set input file here
  tmpoutfile = "Campaign_LND.mis.tmp.tmp"   '<= Set output file here

    Set fso = CreateObject("Scripting.FileSystemObject")
	Set f1 = fso.OpenTextFile(infile, ForReading)
	Set f2 = fso.OpenTextFile(outfile, ForWriting, True)

  Set objArgs = WScript.Arguments  
  
	found = "false"
	firstOver = "false"
	firstDone = "false"
	lineCount = 0
	
Function FindPrevGroupNum(line, groupNum)
	if ((left(line,7) = "[Group ") AND (InStr(line,"[Group "& supposedGroupNum) = 0)) then						
		prevGroupNum=groupNum	
	else
	end if
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
	
Function FindUnitNum(line)
	if not ((InStr(line,"Unit ")) = 0) then
		pos=(InStr(line,"Unit "))
		unitNumTemp3=mid(line,pos)
		c=split(unitNumTemp3)
		maxloop=2
		linecount=0
		for each z in c
			linecount=linecount+1
			if linecount = maxloop then
				unitNumTemp4=z
				a=split(unitNumTemp4,"]")
				maxloop=1
				linecount=0
				for each y in a
					linecount=linecount+1
					if linecount = maxloop then
						unitNum=y			
					else
					end if
				next
			else
			end if
		next	
	else		
	end if
End Function
	
Function FindWaypointNum(line)
	if not ((InStr(line,"Waypoint ")) = 0) then
		pos=(InStr(line,"Waypoint "))
		waypointNumTemp=mid(line,pos)
		c=split(waypointNumTemp)
		maxloop=2
		linecount=0
		for each z in c
			linecount=linecount+1
			if linecount = maxloop then
				waypointNumTemp2=z
				a=split(waypointNumTemp2,"]")
				maxloop=1
				linecount=0
				for each y in a
					linecount=linecount+1
					if linecount = maxloop then
						waypointNum=y			
					else
					end if
				next
			else
			end if
		next	
	else		
	end if
End Function	
	
Function IsPrevUnit(line)
	if (((InStr(line,"[Group ")) <> 0) AND ((InStr(line,"Unit 1")) <> 0)) then
		prevIsUnit = "false"	
	elseif (((InStr(line,"Unit ")) <> 0) AND ((InStr(line,"Unit 1")) = 0)) then
		prevIsUnit = "true"
	elseif (((InStr(line,"[Group ")) <> 0) AND ((InStr(line,"Unit 1")) = 0)) then
		prevIsUnit = "true"
	elseif (((InStr(line,"[Group ")) = 0) AND ((InStr(line,"[Unit ")) <> 0)) then
		prevIsUnit = "true"
	else
	end if
End Function

Function FoundDup(line)
	if left(line,5) = "Name=" then
		Set f5 = fso.OpenTextFile(tmp2infile, ForReading, True)		
			Do While not f5.AtEndofStream	
				contents=f5.readline
				if (contents = line) then
					'DupTest line, found, mainLineCount
					found = "true"	
				else
					found = "false"
				end if
			Loop
		f5.Close
	else
	end if
End Function	

Function FindName(line)
	if left(line,5) = "Name=" then
		name=mid(line,6)
		firstOver="false"
		Set f6 = fso.OpenTextFile(tmp2infile, ForAppending, True)
		Set f4 = fso.OpenTextFile(infile, ForReading)
		Do While not F4.AtEndOfStream
			line2=F4.readline	
			if ((line = line2) AND (firstOver="false")) then
				firstOver="true"
				if found = "false" then
					F6.writeline line
				else
				end if
			else
			end if
			prevLine2=line2
		Loop
		f6.Close
	else
	end if
End Function

Function	SetGroupNumMinus1(line, groupNum)
	if (((InStr(line,".Unit ")) <> 0) AND ((InStr(line,"[Group "&groupNum)) = 0)) then
		a=split(line,".",2)
		maxloop=2
		linecount=0
		for each x in a
			linecount=linecount+1
			if (linecount = maxloop) then
				line=("[Group "& groupNum &"."& x)
			else
			end if
		next	
	elseif ((InStr(line,"[Group "&supposedGroupNum)) <> 0) AND ((InStr(line,".Unit ")) = 0)then
		line=("[Group "& groupNum&"]")
	else
	end if
End Function

Function DupTest(line, found, mainLineCount)
	Set f8 = fso.OpenTextFile(infile, ForReading)
	countLine=0
	Do While not F8.AtEndOfStream
		countLine=countLine+1
		dupLine = f8.readline
		if (dupLine = line) then
			Do Until ((InStr(dupLine,"Class=")) <> 0)
				dupLine = f8.readline				
			Loop
			firstClass=dupLine
			Do Until ((InStr(dupLine,"Long=")) <> 0)
				dupLine = f8.readline
			Loop
			firstLong=dupLine
			Do Until  ((InStr(dupLine,"Lat=")) <> 0)
				dupLine = f8.readline
			Loop
			firstLat=dupLine
		else
		end if
		if (countLine = mainLineCount) then
			Do Until ((InStr(dupLine,"Class=")) <> 0)
				dupLine = f8.readline
			Loop
			secondClass=dupLine
			if (secondClass = firstClass) then
				Do Until ((InStr(dupLine,"Long=")) <> 0)
					dupLine = f8.readline
				Loop
				secondLong=dupLine
				if (secondLong = firstLong) then										
					Do Until ((InStr(dupLine,"Lat=")) <> 0)
						dupLine = f8.readline
					Loop
					secondLat=dupLine	
					if (secondLat = firstLat) then
					found = "true"		
					else
					found = "false"	
					end if
				else
				found = "false"	
				end if
			else
			found = "false"	
			end if	
		else
		found = "false"	
		end if
	Loop
	f8.Close
End Function


	mainLineCount = 0
	prevIsUnit="false"
	groupNumMinus1 = "false"
	unitType=407 
	timesThru=0
	
	Do While not F1.AtEndOfStream

	line=F1.readline
	mainLineCount = mainLineCount + 1
	
	FindPrevGroupNum line, groupNum 
	FindGroupNum(line)
	FindUnitNum(line)
	FindWaypointNum(line)
	IsPrevUnit(line)
	FoundDup(line)
	FindName(line)
	SetGroupNumMinus1 line, groupNum
	

	
	
	
	
	if (found = "false") then
		if ((InStr(line,"Unit ")) = 0) then
			if ((InStr(prevLine,"Unit ")) <> 0) then
				f2.writeline prevLine
			else
			end if
			
			if ((firstOver="false") AND (firstDone="false")) then
				f2.writeline line
			elseif ((firstOver="true") AND (firstDone="false")) then
				if (((InStr(line,"[")) <> 0) AND ((InStr(line,"Waypoint ")) = 0)) then 		
					firstDone="true"
					if ((InStr(line,"Unit ")) = 0) then
						f2.writeline line
					else
					end if
				else
					f2.writeline line
				end if
			elseif ((firstOver="true") AND (firstDone="true")) then
				f2.writeline line
				firstOver="false"
				firstDone="false"
			else
				f2.writeline line
			end if
		else
		end if
	else
		Do Until (((InStr(line,"[")) <> 0) AND ((InStr(line,"Waypoint ")) = 0))
			line=F1.readline		
		Loop
		
		FindGroupNum(line)
		prevGroupNum=groupNum-1
		supposedGroupNum=groupNum+timesThru
	
			
		
		if ((InStr(line,"[Unit ")) = 0) then	
			if (prevIsUnit = "false") then
				f2.Close
				Set f2 = fso.OpenTextFile(tmpoutfile, ForWriting, True)
				Set f7 = fso.OpenTextFile(outfile, ForReading)
					timesThru=timesThru+1
					groupNum=supposedGroupNum-timesThru
					prevGroupNum=groupNum-1
					count=0
					WScript.Echo("prevGroupNum = [Group " & prevGroupNum & "]")
					WScript.Echo("groupNum = [Group " & groupNum & "]")
					WScript.Echo("supposedGroupNum = [Group " & supposedGroupNum & "]")
					WScript.Echo("in " &outfile)
					WScript.Echo(line)
					WScript.Echo("[Group " & supposedGroupNum-timesThru & "]")
					WScript.Echo(timesThru)
				Do Until (line3 = "[Group " & supposedGroupNum-timesThru & "]")	
					count=count+1
					if (count > 1) then
						F2.writeline line3
					else
					end if
					line3 = f7.readline
				Loop
				switch=outfile
				outfile=tmpoutfile
				tmpoutfile=switch
				f7.Close
			else

				f2.writeline line
			end if
			found = "false"	
		elseif ((InStr(line,"[Unit ")) <> 0) then
			line3 = f7.readline	
			f2.writeline line
			found = "false"	
		else		
		end if		
		prevLine2=line		
	end if
	


	prevLine=line
	prevUnitNum=unitNum
	prevWaypointNum=waypointNum

	Loop
	
	WScript.Echo(tmpoutfile & " contains the final product")
	
f1.Close
f4.Close
f6.Close


