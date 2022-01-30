Option Explicit

SendMail "no_reply@acme.com", "yo@oneacme.com", "Asunto", ".\NO_EXISTE.vbs", Null
SendMail "no_reply@acme.com", "yo@oneacme.com", "Asunto", ".\TEST_BODY.txt", ".\NO_EXISTE.vbs"

SendMail "no_reply@acme.com", "yo@oneacme.com", "Asunto", ".\TEST_BODY.txt", Null
SendMail "no_reply@acme.com", "yo@oneacme.com", "Asunto", ".\TEST_BODY.txt", ".\TEST_Attachment-1.txt"
SendMail "no_reply@acme.com", "yo@oneacme.com", "Asunto", ".\TEST_BODY.txt", Array( ".\TEST_Attachment-1.txt", ".\TEST_Attachment-2.txt" )


WScript.Quit 0


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Syntax
' ------
' SendMail( {from}, {to}, {subject}, {HTML file with body text}, {file, or array of files, for attachment(s)} )
'
' Description
' -----------
' Send an email using Windows (CDO).
'
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub SendMail( strFrom, strTo, strSubject, strBodyFile, arrstrAttachment )
On Error resume next

	Dim objEmail
	Dim i

	' Create CDO Message object
	Set objEmail = CreateObject( "CDO.Message" )
	If Oops( Err, "Create CDO Message" ) Then Exit Sub

	' Set SMTP server
	objEmail.Configuration.Fields.Item ( "http://schemas.microsoft.com/cdo/configuration/sendusing" ) = 2
	objEmail.Configuration.Fields.Item ( "http://schemas.microsoft.com/cdo/configuration/smtpserver" ) = "mail.acme.com"
	objEmail.Configuration.Fields.Item ( "http://schemas.microsoft.com/cdo/configuration/smtpserverport" ) = 2525 

	objEmail.From = strFrom
	objEmail.To = strTo
	objEmail.Subject = strSubject

	strBodyFile = CreateObject( "Scripting.FileSystemObject" ).GetAbsolutePathName( strBodyFile )

	objEmail.HTMLBody = CreateObject( "Scripting.FileSystemObject" ).OpenTextFile( strBodyFile, 1, False, 0 ).ReadAll
	If Oops( Err, "Create body from file '" & CreateObject( "Scripting.FileSystemObject" ).GetFileName( strBodyFile ) & "'" ) Then Exit Sub

	' Add attachments
	Select Case VarType( arrstrAttachment )
		Case 8 ' String
			objEmail.AddAttachment CreateObject( "Scripting.FileSystemObject" ).GetAbsolutePathName( arrstrAttachment )
			If Oops( Err, "Add attachment '" & CreateObject( "Scripting.FileSystemObject" ).GetFileName( arrstrAttachment ) & "'" ) Then Exit Sub	
		Case 8204 ' Array of strings		
			' Add attachments
			For i = 0 to UBound( arrstrAttachment )
				objEmail.AddAttachment CreateObject( "Scripting.FileSystemObject" ).GetAbsolutePathName( arrstrAttachment( i ) )
				If Oops( Err, "Add attachment '" & CreateObject( "Scripting.FileSystemObject" ).GetFileName( arrstrAttachment( i ) ) & "'" ) Then Exit Sub	
			Next		
	End Select

	' Send the email
	objEmail.Configuration.Fields.Update
	objEmail.Send
	If Oops( Err, "Send mail" ) Then Exit Sub

	' Delete objects
	Set objEmail = Nothing

End Sub
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Syntax
' ------
' Oops( {Error Object}, {Description of action}  )
'
' Description
' -----------
' In case of error display it and return TRUE.
'
' Return values
' -------------
' False = No error
' True  = An error has occurred
'
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function Oops( oError, strAction )
	If oError.Number <> 0 Then
		WScript.Echo "Attempted action: " & strAction & vbCrLf & _
			"Error code: " & oError.Number & vbCrLf & _
			"Error description: " & oError.Description
		Err.Clear
		Oops = True
	Else
		Oops = False
	End If
End Function
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
