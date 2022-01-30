Include "library\LogLine.vbs"

WScript.echo "---Inicio---"

LogLine( "Inicio" )
LogLine( "Lista:" )
LogLine( "	Primera" )
LogLine( "	Segunda" )
LogLine( "	La pr�xima l�nea va en blanco" )
LogLine( "" )
LogLine( "Esta es la l�nea final" )

WScript.echo "---Final---"

Sub Include( ByRef sIncludeFile )
	On Error Resume Next

	Dim oFSO, oFile, sFileContent

	Set oFSO = CreateObject( "Scripting.FileSystemObject" )
	If oFSO.FileExists( sIncludeFile ) Then
		Set oFile = oFSO.OpenTextFile( sIncludeFile )
		sFileContent = oFile.ReadAll
		oFile.Close
		ExecuteGlobal sFileContent
	End If
	
	Set oFSO = Nothing
	Set oFile = Nothing
	
End Sub
