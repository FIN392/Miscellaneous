Option Explicit
 
Dim arrWebPageTitle
Dim blnTd
Dim colMatches, objRE
Dim strAuthor, strBookTitle, strISBN, strWebPageTitle
 
 
With WScript.Arguments
	If .UnNamed.Count <> 1 Then Syntax
	If .Named.Count    > 1 Then Syntax
	If .Named.Count    = 1 And Not .Named.Exists( "TD" ) Then Syntax
	blnTd = ( .Named.Count = 1 )
End With
 
strISBN         = WScript.Arguments.UnNamed( 0 )
strBookTitle    = "Not found"
strAuthor       = "Unknown"
strWebPageTitle = TitleFromHTML( "https://www.amazon.com/dp/" & strISBN & "/" )
strWebPageTitle = Replace( strWebPageTitle, "Amazon.com: ", "" )
strWebPageTitle = Replace( strWebPageTitle, ": Books", "" )
strWebPageTitle = Trim( strWebPageTitle )
arrWebPageTitle = Split( strWebPageTitle, ":" )
If UBound( arrWebPageTitle ) > 0 Then
	strBookTitle   = Trim( arrWebPageTitle(0) )
	strAuthor      = Trim( arrWebPageTitle(1) )
	Set objRE      = New RegExp
	objRE.Pattern  = "^[^\(]+"
	Set colMatches = objRE.Execute( strBookTitle )
	If colMatches.Count = 1 Then strBookTitle = colMatches(0).Value
	Set colMatches = Nothing
	Set objRE      = Nothing
End If
 
If blnTd Then
	WScript.Echo strISBN & vbTab & strBookTitle & vbTab & strAuthor & vbCrLf
Else
	WScript.Echo vbCrLf & "Title  : " & strBookTitle & vbCrLf & "Author : " & strAuthor & vbCrLf & "ISBN   : " & strISBN
End If
 
 
Sub IETerminate( )
	Dim colItems, objItem, objWMIService
	On Error Resume Next
	Set objWMIService = GetObject( "winmgmts://./root/CIMV2" )
	Set colItems      = objWMIService.ExecQuery( "SELECT * FROM Win32_Process WHERE Name = 'iexplore.exe'" )
	If colItems.Count > 0 Then
		For Each objItem In colItems
			objItem.Terminate
		Next
	End If
	Set colItems      = Nothing
	Set objWMIService = Nothing
	On Error GoTo 0
End Sub
 
 
Function IsIEActive( )
	Dim blnActive, colItems, objWMIService
	blnActive = False
	On Error Resume Next
	Set objWMIService = GetObject( "winmgmts://./root/CIMV2" )
	Set colItems      = objWMIService.ExecQuery( "SELECT * FROM Win32_Process WHERE Name = 'iexplore.exe'" )
	blnActive = ( colItems.Count > 0 )
	Set colItems      = Nothing
	Set objWMIService = Nothing
	IsIEActive = blnActive
	On Error GoTo 0
End Function
 
 
Function TitleFromHTML( strURL )
	Dim blnIEActive, objIE
	blnIEActive = IsIEActive ' Check if this will be the only IE running
	On Error Resume Next
	Set objIE = Nothing
	Set objIE = CreateObject( "InternetExplorer.Application" )
	If Err.number Then
		Err.Clear
		Set objIE = CreateObject( "InternetExplorer.Application" )
	End If
	If Err.number Then
		TitleFromHTML = "Not found by Unknown: Unknown: Amazon.com: Books"
	Else
	 	objIE.Navigate strURL
		Do Until objIE.ReadyState = 4
			WScript.Sleep 1
		Loop
		TitleFromHTML = objIE.Document.Title
		objIE.Quit
	End If
	Set objIE = Nothing
	On Error GoTo 0
	If Not blnIEActive Then IETerminate ' If this was the only IE running, terminate all IE processes
End Function
 
 
Sub Syntax
	Dim strMsg
	strMsg = strMsg _
	       & vbCrLf _
	       & "BookFind.vbs,  Version 1.12" _
	       & vbCrLf _
	       & "Display book title and author name for the specified ISBN number." _
	       & vbCrLf & vbCrLf _
	       & "Usage:  CSCRIPT  //NOLOGO  BOOKFIND.VBS  isbn  [ /TD ]" _
	       & vbCrLf & vbCrLf _
	       & "Where:  ""isbn"" is the ISBN (or ASIN) of the book to search for" _
	       & vbCrLf _
	       & "        /TD    changes the output format to tab delimited" _
	       & vbCrLf & vbCrLf _
	       & "Note:   This script uses Amazon's web site to look up author and title."  _
	       & vbCrLf _
	       & "        To be precise, the data is extracted from the title of the page"  _
	       & vbCrLf _
	       & "        with URL ""https://www.amazon.com/dp/"" followed by the ISBN." _
	       & vbCrLf _
	       & "        That means this script will fail if Amazon changes the URLs." _
	       & vbCrLf & vbCrLf _
	       & "Written by Rob van der Woude" _
	       & vbCrLf _
	       & "https://www.robvanderwoude.com"
	Wscript.Echo( strMsg )
	Wscript.Quit( 1 )
End Sub
 
