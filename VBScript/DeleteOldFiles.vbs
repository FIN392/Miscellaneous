Option Explicit 

WScript.Echo 	"*** " & "1"
DeleteOldFiles ".\NO_EXISTE", 90
WScript.Echo 	"*** " & ""

WScript.Echo 	"*** " & "2"
DeleteOldFiles ".\TEST", "NOVENTA"
WScript.Echo 	"*** " & ""

WScript.Echo 	"*** " & "3"
DeleteOldFiles ".\TEST", 90
WScript.Echo 	"*** " & ""


WScript.Quit 0


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Syntax
' ------
' DeleteOldFiles( {Folder}, {Days} )
'
' Description
' -----------
' Delete any file within a folder with more that X days since last modification.
'
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub DeleteOldFiles( strFolder, intDays )
On Error resume next

	Dim objFiles
	Dim objFile
	Dim strFileName
	
	strFolder = CreateObject( "Scripting.FileSystemObject" ).GetAbsolutePathName( strFolder )
	
	Set objFiles = CreateObject( "Scripting.FileSystemObject" ).GetFolder( strFolder ).Files
	If Oops( Err, "Access folder '" & CreateObject( "Scripting.FileSystemObject" ).GetFileName( strFolder ) & "'" ) Then Exit Sub
	
	For Each objFile in objFiles		
		If objFile.DateLastModified + intDays < Now Then
			If Oops( Err, "Number of days" ) Then Exit Sub

			strFileName = objFile.Name
			CreateObject("Scripting.FileSystemObject").DeleteFile( objFile.Path )
			Oops Err, "Delete file '" & strFileName & "'"

		End If
	Next
	
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
