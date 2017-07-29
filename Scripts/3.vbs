Const ForReading = 1, ForWriting = 2, ForAppending = 8

	infile = "Campaign_SCR.mis"   '<= Set input file here
	outfile = "Campaign_LND.mis.tmp.tmp"   '<= Set output file here
	tmp2infile = "test.txt"   '<= Set input file here
	tmpoutfile = "Campaign_LND.mis.tmp.tmp"   '<= Set output file here
	finished = "finished.mis"   '<= Set output file here	
    Set fso = CreateObject("Scripting.FileSystemObject")	
	Set f3 = fso.OpenTextFile(finished, ForWriting, True)
	Set f2 = fso.OpenTextFile(outfile, ForReading, True)
	Set d = Wscript.Createobject("Scripting.Dictionary")
	Set f4 = fso.OpenTextFile(outfile, ForReading, True)
	Set f1 = fso.OpenTextFile(outfile, ForReading, True)

Function IsGroup(ByRef line, ByRef isGroup2, ByRef beenHere)
	
	if ((InStr(line,"[Group") <> 0) AND (InStr(line,"Unit") = 0)) then
		beenHere=0	
	else
	end if
	
	if ((InStr(line,"[Group") <> 0) AND ((InStr(line,".Unit 1.")) <> 0)) then
		groupUnitNum=1
		nextGroupUnitNum=groupUnitNum+1
	elseif ((InStr(line,".Unit 1]")) <> 0) then
		groupUnitNum=1
		nextGroupUnitNum=groupUnitNum+1
	elseif ((InStr(line,"[Group") <> 0) AND ((InStr(line,".Unit "&groupUnitNum)) <> 0)) then
	else
	end if
	
	if (InStr(line,"[Group") <> 0) then
		if ((prevIsGroup = 1) AND ((InStr(line,".Unit")) <> 0)) then 
			prevIsGroup=1
			beenHere=1
		else			
			if ((isGroup2 = 1) AND ((InStr(line,".Unit 1.")) = 0)) then
				if ((InStr(line,".Unit 1]")) <> 0) then
					prevIsGroup=1
					beenHere=1
				else
					prevIsGroup=0
				end if
			else
			end if
		end if
			
		if ((groupNum =  1037) AND (nextGroupUnitNum = 2)) then
			WScript.Echo(groupNum &" " &nextGroupNum&" "&groupUnitNum&" " &nextGroupUnitNum)
			WScript.Echo(isGroup2& " "&prevIsGroup & " "&beenHere)
			WScript.Echo(line)
		else
		end if
	
	else
	end if
	

	
	if ((InStr(line,"[Group") <> 0) AND ((InStr(line,".Unit ")) = 0)) then		
		key=mainCount+8
		if ((InStr(d.Item(key), "[Group ") <> 0) AND (InStr(d.Item(key), ".Unit ") = 0)) then
			lineCount=0
			Do Until (lineCount = 7)
				lineCount=lineCount+1
				mainCount=mainCount+1
				line4=f2.readline
			Loop
			Exit Function
		elseif (InStr(d.Item(key), "[Unit ") <> 0) then
			lineCount=0
			Do Until (lineCount = 7)
				lineCount=lineCount+1
				mainCount=mainCount+1
				line4=f2.readline
			Loop
			Exit Function
		else
			if ((InStr(line, "[Group "&nextGroupNum) = 0) AND (InStr(line, "[Group "&groupNum) = 0)) then		
				line="[Group "& nextGroupNum &"]"
				groupNum=nextGroupNum		
			elseif (InStr(line, "[Group "&nextGroupNum &"]") <> 0) then
				groupNum=nextGroupNum
			else
			end if
		end if	
		groupUnitNum=1
		nextGroupUnitNum=2

	elseif ((InStr(line,"[Group "& groupNum) = 0) AND ((InStr(line,".Unit ")) <> 0)) then
	WScript.Echo("here")
	WScript.Echo(line)
		if ((InStr(line,"Unit "&nextGroupUnitNum) = 0) AND (InStr(line, "Waypoint") = 0)) then
			if ((InStr(line,"Unit "&groupUnitNum) = 0) AND (prevIsGroup = 1)) then
				beenHere=1
				line="[Group "&groupNum&".Unit " &groupUnitNum& "]"
				groupUnitNum=nextGroupUnitNum
			elseif (InStr(line,"Unit "&groupUnitNum) = 0) then
				line="[Group "&groupNum&".Unit "&nextGroupUnitNum&"]"
				groupUnitNum=nextGroupUnitNum
			elseif ((InStr(line,"Unit "&groupUnitNum) <> 0) AND (beenHere = 1)) then
				if ((InStr(line, "Waypoint") = 0) AND (prevIsGroup =  0)) then	
					beenHere=1
					line="[Group "&groupNum&".Unit " &nextGroupUnitNum& "]"
					groupUnitNum=nextGroupUnitNum
				elseif ((InStr(line, "Waypoint") = 0) AND (prevIsGroup =  1)) then
					beenHere=1
					line="[Group "&groupNum&".Unit " &groupUnitNum& "]"
					groupUnitNum=nextGroupUnitNum
				else
				end if
			elseif (InStr(line,"Unit "&groupUnitNum) <> 0) then
				line="[Group "&groupNum&".Unit " &groupUnitNum& "]"
			else
			end if
		elseif ((InStr(line,"Unit "&groupUnitNum) <> 0) AND (beenHere = 1)) then
				if (InStr(line, "Waypoint") <> 0) AND (InStr(line,"Unit "&nextGroupUnitNum) = 0)then
					if (prevIsGroup =  0) then
						beenHere=1
						line="[Group "&groupNum&".Unit " &nextGroupUnitNum&".Waypoint "& waypointNum&"]"
					else
					end if
				else
				end if
		elseif ((InStr(line,"Unit "&nextGroupUnitNum) = 0) AND (InStr(line, "Waypoint") <> 0)) then
			if ((InStr(line,"Unit "&groupUnitNum) = 0) AND (prevIsGroup = 1)) then
				beenHere=1
				line="[Group "&groupNum&".Unit " &groupUnitNum&".Waypoint "& waypointNum& "]"
			elseif (InStr(line,"Unit "&groupUnitNum) = 0) then
			line="[Group "&groupNum&  ".Unit "& groupUnitNum &".Waypoint "& waypointNum&"]"
			else
			line="[Group "&groupNum&  ".Unit "& groupUnitNum &".Waypoint "& waypointNum&"]"
			end if
		elseif ((InStr(line,"Unit "&nextGroupUnitNum) <> 0) AND (prevIsGroup = 1)) then
			if ((beenHere = 1) AND (groupUnitNum <> 1)) then
				beenHere=1
				line="[Group "&groupNum&".Unit " &nextGroupUnitNum& "]"
				groupUnitNum=nextGroupUnitNum
			elseif ((groupUnitNum = 1) AND (InStr(line, "Waypoint") = 0)) then
				beenHere=1
				line="[Group "&groupNum&".Unit " &groupUnitNum& "]"
				groupUnitNum=nextGroupUnitNum
			elseif ((groupUnitNum = 1) AND (InStr(line, "Waypoint") <> 0)) then
				beenHere=1
				line="[Group "&groupNum&".Unit " &groupUnitNum&".Waypoint "& waypointNum&"]"
			elseif (InStr(line, "Waypoint") = 0) then
				beenHere=1
				line="[Group "&groupNum&".Unit " &nextGroupUnitNum& "]"
				groupUnitNum=nextGroupUnitNum
			else
				beenHere=1
				line="[Group "&groupNum&".Unit " &nextGroupUnitNum&".Waypoint "& waypointNum&"]"
				groupUnitNum=nextGroupUnitNum
			end if
		elseif ((InStr(line,"Unit "&nextGroupUnitNum) <> 0) AND (beenHere = 1)) then
			if (InStr(line, "Waypoint") = 0) then	
				beenHere=1
				line="[Group "&groupNum&".Unit " &groupUnitNum& "]"
				groupUnitNum=nextGroupUnitNum
			elseif (InStr(line, "Waypoint") <> 0) then
				beenHere=1
				line="[Group "&groupNum&".Unit " &groupUnitNum&".Waypoint "& waypointNum&"]"
			else
			end if
		elseif ((InStr(line,"Unit "&nextGroupUnitNum) = 0) AND (beenHere = 1)) then
			if (InStr(line,"Unit "&groupUnitNum) = 0) then
				if (InStr(line, "Waypoint") = 0) then	
					beenHere=1
					line="[Group "&groupNum&".Unit " &nextGroupUnitNum& "]"
					groupUnitNum=nextGroupUnitNum
				elseif (InStr(line, "Waypoint") <> 0) then
					beenHere=1
					line="[Group "&groupNum&".Unit " &nextGroupUnitNum&".Waypoint "& waypointNum&"]"
				else
				end if
			elseif (InStr(line,"Unit "&groupUnitNum) <> 0) then
				if (InStr(line, "Waypoint") = 0) then	
					beenHere=1
					line="[Group "&groupNum&".Unit " &nextGroupUnitNum& "]"
					groupUnitNum=nextGroupUnitNum
				elseif (InStr(line, "Waypoint") <> 0) then
					beenHere=1
					line="[Group "&groupNum&".Unit " &nextGroupUnitNum&".Waypoint "& waypointNum&"]"
				else
				end if
			else
			end if
		elseif (InStr(line,"Unit "&nextGroupUnitNum) <> 0) then		
			groupUnitNum=nextGroupUnitNum
			line="[Group "&groupNum&".Unit " &groupUnitNum& "]"
		else
		end if
	elseif ((InStr(line,"[Group "& groupNum) <> 0) AND ((InStr(line,".Unit ")) <> 0)) then	
		if ((InStr(line,"Unit "&nextGroupUnitNum) = 0) AND (InStr(line, "Waypoint") = 0)) then	
			if (InStr(line,"Unit "&groupUnitNum) = 0) then
				line="[Group "&groupNum&".Unit "&nextGroupUnitNum&"]"
				groupUnitNum=nextGroupUnitNum
			elseif (InStr(line,"Unit "&groupUnitNum) <> 0) then
				line="[Group "&groupNum&".Unit " &groupUnitNum& "]"
			else
			end if
		elseif ((InStr(line,"Unit "&nextGroupUnitNum) = 0) AND (InStr(line, "Waypoint") <> 0)) then	
			if (InStr(line,"Unit "&groupUnitNum) = 0) then
				line="[Group "&groupNum&  ".Unit "& groupUnitNum &".Waypoint "& waypointNum&"]"
			else
			end if
		elseif ((InStr(line,"Unit "&nextGroupUnitNum) <> 0) AND (InStr(line, "Waypoint") = 0)) then
			line="[Group "&groupNum&".Unit " &groupUnitNum& "]"
			groupUnitNum=nextGroupUnitNum
		elseif ((InStr(line,"Unit "&nextGroupUnitNum) <> 0) AND (InStr(line, "Waypoint") <> 0)) then
			line="[Group "&groupNum&  ".Unit "& groupUnitNum &".Waypoint "& waypointNum&"]"
			groupUnitNum=nextGroupUnitNum
		else
		end if	
	elseif ((InStr(line,"Group") = 0) AND ((InStr(line,"[Unit ")) <> 0)) then
		if ((InStr(line, "Unit "&nextUnitNum) = 0) AND (InStr(line, "Waypoint") = 0)) then
			if (InStr(line, "Unit "&unitNum) = 0) then
				line="[Unit "& nextUnitNum &"]"
				unitNum=nextUnitNum
			else
			end if
		elseif ((InStr(line, "Unit "&nextUnitNum) = 0) AND (InStr(line, "Waypoint") <> 0)) then
			if (InStr(line, "Unit "&unitNum) = 0) then
				line="[Unit "& unitNum &".Waypoint "& waypointNum&"]"
			else
			end if			
		elseif ((InStr(line, "Unit "&nextUnitNum) <> 0) AND (InStr(line, "Waypoint") <> 0)) then
			if (InStr(line, "Unit "&unitNum) = 0) then
				line="[Unit "& unitNum &".Waypoint "& waypointNum&"]"
			else
			end if
		elseif (InStr(line, "Unit "&nextUnitNum) <> 0) then
			unitNum=nextUnitNum		
		else
		end if
	else
	end if
	f3.writeline line
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


	groupNum=1
	unitNum=1
	groupUnitNum=1	
	count=0
	mainCount=0
	isGroup2=0
	beenHere=0
	
Do While not F4.AtEndOfStream
	dLine=f4.readline
	count=count+1
	d.Add count,dLine
	WScript.Echo(count)

Loop

Do While not F2.AtEndOfStream
	mainCount=mainCount+1
	line=F2.readline
	nextGroupNum=groupNum+1
	nextUnitNum=unitNum+1
	nextWaypointNum=waypointNum+1
	nextGroupUnitNum=groupUnitNum+1
	FindWayPointNum(line)
	
	if ((beenHere = 1) AND ((InStr(line,".Unit ")) = 0)) then
	elseif ((beenHere = 1) AND ((InStr(line,".Unit ")) <> 0)) then
	else
	end if

	
	IsGroup line,  isGroup2, beenHere
	if (InStr(line,"[Group") <> 0) then
		if ((InStr(line,".Unit ")) = 0) then
			isGroup2=1
		elseif ((InStr(line,".Unit ")) <> 0) then
			isGroup2=0
		else
		end if
	else
	end if

	
Loop

f2.Close
f3.Close
f1.Close
f4.Close