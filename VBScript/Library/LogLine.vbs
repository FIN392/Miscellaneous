Sub LogLine( ByRef sLogText )
	Dim sLine
	sLine = _
		Year( Now ) & "/" & _
		Right( 100 + Month( Now ), 2 ) & "/" & _
		Right( 100 + Day( Now ), 2 ) & " " & _
		Right( 100 + Hour( Now ), 2 ) & ":" & _
		Right( 100 + Minute( Now ), 2 ) & ":" & _
		Right( 100 + Second( Now ), 2 ) & " - " & _
		sLogText
	WScript.echo sLine
End Sub
