Const ForReading = 1, ForWriting = 2

  infile = "Campaign_LND.mis.tmp"   '<= Set input file here
  outfile = "Campaign_LND.mis.tmp.tmp2"   '<= Set output file here
  infile2 = "1.txt"   '<= Set output file here
  tmpoutfile = "Campaign_LND.tmp"   '<= Set output file here

  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f1 = fso.OpenTextFile(infile, ForReading)
  Set f2 = fso.OpenTextFile(tmpoutfile, ForWriting, True)

  Set objArgs = WScript.Arguments  

  Do While not F1.AtEndOfStream
	line=F1.readline
	if left(line,5) = "Name=" then
		f2.writeline line
		Set f3 = fso.OpenTextFile(infile2, ForReading)
		Do While not F3.AtEndOfStream
			line2=F3.readline
			if not line = "Name="+line2 then
				for count = 1 to 2: line=F1.readline: f2.writeline line: next
					line=F1.readline
					if line = "Origin="+objArgs(0) then				
						f2.writeline line
						for count = 1 to 7: line=F1.readline: f2.writeline line: next
							line=F1.readline
							if not left(line,14) = "GameEntryDate=" then
								WScript.Echo("The file format is not correct: an instance of 'GameEntryDate=' was not found")
								f2.close
								Set f2 = fso.GetFile(outfile)
								f2.Delete
								WScript.Quit (1)
							else
								subline=mid(line,15,8)
								yearline=mid(subline,1,4)
								monthline=mid(subline,5,2)
								dayline=mid(subline,7,2)
								yearlineInt=CInt(yearline)
								monthlineInt=CInt(monthline)
								
								monthlineInt=monthlineInt+objArgs(1)
								
								if not yearlineInt < 1939 then
									if monthlineInt > 12 then
										yearlineInt= yearlineInt + 1
										monthlineInt = monthlineInt - 12
										if monthlineInt < 10 then
											monthline=(CStr(monthlineInt))
											monthline=("0"+monthline)
										else
											monthline=(CStr(monthlineInt))
										end if
									else
										if monthlineInt < 0 then
											yearlineInt= yearlineInt - 1
											monthlineInt = monthlineInt + 12
											if monthlineInt < 10 then
												monthline=(CStr(monthlineInt))
												monthline=("0"+monthline)
											else
												monthline=(CStr(monthlineInt))
											end if	
										else
											
										end if
									end if
								
									if yearlineInt < 1938 then
										subline=("19380101")
										f2.writeline "GameEntryDate="+subline
									else
										yearline=(CStr(yearlineInt))
										subline=(yearline+monthline+dayline)

										f2.writeline "GameEntryDate="+subline	
									end if
								else
								f2.writeline line
								end if
							end if
					else
						f2.writeline line
					end if
			else 

			end if
			
		Loop
		
	else
		f2.writeline line
	end if
	 Loop
	 
f1.Close
f2.Close
f3.Close
	 
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f1 = fso.OpenTextFile(tmpoutfile, ForReading)
  Set f2 = fso.OpenTextFile(outfile, ForWriting, True)

  Set objArgs = WScript.Arguments  
  
Do While not F1.AtEndOfStream
	line=F1.readline
	if left(line,5) = "Name=" then
		f2.writeline line
		Set f3 = fso.OpenTextFile(infile2, ForReading)
		Do While not F3.AtEndOfStream
			line2=F3.readline
			if not line = "Name="+line2 then
				for count = 1 to 2: line=F1.readline: f2.writeline line: next
					line=F1.readline
					if line = "Origin="+objArgs(0) then				
						f2.writeline line
						for count = 1 to 9: line=F1.readline: f2.writeline line: next
							line=F1.readline
							if not left(line,13) = "GameExitDate=" then
								WScript.Echo("The file format is not correct: an instance of 'GameExitDate=' was not found")
								f2.close
								Set f2 = fso.GetFile(outfile)
								f2.Delete
								WScript.Quit (1)
							else
								subline=mid(line,14,8)
								yearline=mid(subline,1,4)
								monthline=mid(subline,5,2)
								dayline=mid(subline,7,2)
								yearlineInt=CInt(yearline)
								monthlineInt=CInt(monthline)
								
								monthlineInt=monthlineInt+objArgs(2)
								
								if not yearlineInt > 1945 then
									if monthlineInt > 12 then
										yearlineInt= yearlineInt + 1
										monthlineInt = monthlineInt - 12
										if monthlineInt < 10 then
											monthline=(CStr(monthlineInt))
											monthline=("0"+monthline)
										else
											monthline=(CStr(monthlineInt))
										end if
									else
										if monthlineInt < 0 then
											yearlineInt= yearlineInt - 1
											monthlineInt = monthlineInt + 12
											if monthlineInt < 10 then
												monthline=(CStr(monthlineInt))
												monthline=("0"+monthline)
											else
												monthline=(CStr(monthlineInt))
											end if	
										else
											
										end if			
									end if
								
									if yearlineInt > 1945 then
										subline=("19451231")
										f2.writeline "GameExitDate="+subline
									else
										yearline=(CStr(yearlineInt))
										subline=(yearline+monthline+dayline)

										f2.writeline "GameExitDate="+subline	
									end if
								else
								f2.writeline line
								end if
							end if
					else
						f2.writeline line
					end if
			else 

			end if
			
		Loop
		
	else
		f2.writeline line
	end if
	Loop



f1.Close
f2.Close
f3.Close

