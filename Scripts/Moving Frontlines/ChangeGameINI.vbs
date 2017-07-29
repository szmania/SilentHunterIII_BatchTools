Const ForReading = 1, ForWriting = 2, ForAppending = 8

infile = "Campaign_LND.mis.tmp"   '<= Set input file here
tmpoutfile = "unitsEffected.tmp."   '<= Set output file here
outfile = "Campaign_LND.mis.tmp.tmp"   '<= Set output file here
infile2 = "DefSide.cfg" 'infile DefSide.cfg
Dim allies
Dim lines

Set allies = CreateObject("Scripting.Dictionary")
Set axis = CreateObject("Scripting.Dictionary")
Set lines = CreateObject("Scripting.Dictionary")

Set fso = CreateObject("Scripting.FileSystemObject")
Set f1 = fso.OpenTextFile(infile, ForReading)
Set f2Temp = fso.OpenTextFile(tmpoutfile, ForWriting, True)
Set fdefside = fso.OpenTextFile(infile2, ForReading)
Set foutput = fso.OpenTextFile(outfile, ForWriting, True)

Set objArgs = WScript.Arguments  
count = 0
prevLineCount=Empty

Function DefSide()
	Do While not fdefside.AtEndOfStream
		line=fdefside.readline
		count = count + 1
		WScript.Echo count
		
		if left(line,8) = "Country=" then
			iCountry = mid(line,9)
		else
		end if
		
		if (left(line,5) = "Side=") then
			iSide = mid(line,6)
		else
		end if
		
		if (left(line,10) = "StartDate=") then
			iStartDate = mid(line,11)
			conviStartDate = CDate(StringToDate(iStartDate))
		else
		end if
		
		if (left(line,8) = "EndDate=") then
			iEndDate = mid(line,9)
			conviEndDate = CDate(StringToDate(iEndDate))
			if (iSide = "1") and (DateDiff("d", inputDate, conviStartDate) <= 0) and (DateDiff("d", inputDate, conviEndDate) => 0) then		
				allies.Add iCountry, "1"
			elseif (iSide = "2") and (DateDiff("d", inputDate, conviStartDate) <= 0) and (DateDiff("d", inputDate, conviEndDate) => 0) then
				axis.Add iCountry, "2"
			else
			end if
		else
		end if
	Loop
	fdefside.close

	WScript.Sleep 2000
	
End Function

Function GetDistance(long1, lat1, long2, lat2)
	GetDistance = sqr(((long2 - long1)^2) + ((lat2 - lat1)^2))

End Function

Function StringToDate(varDate)
	'vYear = 1939
	vYear = mid(varDate,1,4)
	vMonth = mid(varDate,5,2)
	'vMonth = 10
	vDay = mid(varDate,7,2)
	'vDay = 01
	StringToDate = vMonth & "/" & vDay & "/" & vYear
End Function

Function DateToString(varDate)
	'vYear = 1939
	vMonth = Month(varDate)
	vDay = Day(varDate)
	'vMonth = 10
	vYear = Year(varDate)
	'vDay = 01
	DateToString = vYear & vMonth & vDay
End Function

Function GetData()
	Do While not f1.AtEndOfStream
		prevline=line
		line=f1.readline
		count = count + 1
		WScript.Echo count
		
		if left(line,5) = "Name=" then
			varName = mid(line,6)	
		else
		end if
		
		if left(line,7) = "Origin=" then
			varOrigin = mid(line,8)
		else
		end if
		
		if left(line,5) = "Long=" then
			varLong = CDbl(mid(line,6))
		else
		end if
		
		if left(line,4) = "Lat=" then
			varLat = CDbl(mid(line,5))
		else
		end if
		
		if left(line,14) = "GameEntryDate=" then
			varGameEntryDate = mid(line,15)
			convGameEntryDate = StringToDate(varGameEntryDate)
			lines.Add 1, line 
			prevLineCount = 1
			dLinesCount = 2
		else
		end if
		
		if (prevLineCount = 1) and (left(line,14) <> "GameEntryDate=") then
			lines.Add dLinesCount, line
			dLinesCount = dLinesCount + 1
		else
			if (left(line,14) <> "GameEntryDate=") then
				'foutput.writeline line
			else
			end if
		end if
		
		if left(line,13) = "GameExitDate=" then
			varGameExitDate = mid(line,14)
			convGameExitDate = StringToDate(varGameExitDate)
		else
		end if
				
		if (line = "") and (DateDiff("d", inputDate, convGameEntryDate) >= 0) and (GetDistance(objArgs(2),varLong,objArgs(3),varLat) <= 8046720) and (allies.Exists(varOrigin)=true) then
			f2Temp.writeline varName
			f2Temp.writeline varOrigin
			f2Temp.writeline varGameEntryDate
			f2Temp.writeline varGameExitDate
			f2Temp.writeline varLong
			f2Temp.writeline varLat
			f2Temp.writeline GetDistance(objArgs(2),varLong,objArgs(3),varLat)
			f2Temp.writeline 		

			foutput.writeline "GameEntryDate=" & (DateToString(DateAdd("d", objArgs(4), convGameEntryDate)))
			
			For i = 2 To 16
				foutput.writeline lines.Item(i)
			Next
			
			if not lines.Item(16) = "" then
				foutput.writeline line
			else
			end if

			lines.RemoveAll
			prevLineCount = 0
			
			convGameEntryDate=Empty
			varLong=Empty
			varLat=Empty
		else
			if (line = "") and (prevLineCount = 1) then
				For i = 1 To 16
					foutput.writeline lines.Item(i)
				Next
				
				if not lines.Item(16) = "" then
					foutput.writeline line
				else
				end if

				lines.RemoveAll
				prevLineCount = 0
				
				convGameEntryDate=Empty
				varLong=Empty
				varLat=Empty
			elseif (prevLineCount = 0) then
				foutput.writeline line		
			else
			end if
		end if
		
		if (line = "") then
			lines.RemoveAll
			prevLineCount = 0
		else
		end if
	Loop
	
End Function


inputDate = CDate(StringToDate(objArgs(1)))


DefSide()
count = 0
GetData()


	 
f1.Close
f2Temp.Close
foutput.Close

	 

