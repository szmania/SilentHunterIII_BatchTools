Const ForReading = 1, ForWriting = 2

infile = "Campaign_LND.mis.tmp"   '<= Set input file here
tmpoutfile = "Campaign_LND.mis.tmp.tmp"   '<= Set output file here
outfile = "Campaign_LND.mis.tmp.tmp2"   '<= Set output file here

Set fso = CreateObject("Scripting.FileSystemObject")
Set f1 = fso.OpenTextFile(infile, ForReading)
Set f2 = fso.OpenTextFile(tmpoutfile, ForWriting, True)

Set objArgs = WScript.Arguments  

Do While not f1.AtEndOfStream
	line=f1.readline
	if left(line,5) = "Name=" then
		f2.writeline line
		
	else
		WScript.Echo line
	end if
Loop
	 
f1.Close
f2.Close
f3.Close
	 

