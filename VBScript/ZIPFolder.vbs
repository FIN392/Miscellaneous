Option Explicit

ZIPFolder "C:\System Volume Information\qwe.zip", "C:\Temp"
ZIPFolder ".\TEST.zip", "C:\NO_EXIST"

ZIPFolder ".\TEST.zip", "C:\Temp"


WScript.Quit 0


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Syntax
' ------
' ZIPFolder( {ZipFile}, {Folder} )
'
' Description
' -----------
' Create a ZIP file with files within a folder.
' If the ZIP file already exist, it is overwritten.
'
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub ZIPFolder( strZipFile, strFolder )
On Error resume next

	strZipFile = CreateObject( "Scripting.FileSystemObject" ).GetAbsolutePathName( strZipFile )
	strFolder = CreateObject( "Scripting.FileSystemObject" ).GetAbsolutePathName( strFolder )

	' Create ZIP file
	CreateObject( "Scripting.FileSystemObject" ).CreateTextFile( strZipFile, True, False ).Write Chr( 80 ) & Chr( 75 ) & Chr( 5 ) & Chr( 6 ) & String( 18, Chr( 0 ) )
	If Oops( Err, "Create ZIP file '" & CreateObject( "Scripting.FileSystemObject" ).GetFileName( strZipFile ) & "'" ) Then Exit Sub

	' Add files in folder
	CreateObject( "Shell.Application" ).NameSpace( strZipFile ).CopyHere CreateObject( "Shell.Application" ).NameSpace( strFolder ).Items
	If Oops( Err, "Add files from '...\" & CreateObject( "Scripting.FileSystemObject" ).GetFileName( strFolder ) & "' to ZIP file" ) Then Exit Sub
	Do Until CreateObject( "Shell.Application" ).NameSpace( strZipFile ).Items.Count = CreateObject( "Shell.Application" ).NameSpace( strFolder ).Items.Count
		WScript.Sleep 1000 
	Loop

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
