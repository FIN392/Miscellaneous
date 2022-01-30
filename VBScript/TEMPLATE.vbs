'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Syntax
' ------
' TEMPLATE.vbs {param1} {param2} [[{param3}]...]
'
' Description
' -----------
' Brief description of the functionality.
'
' Exit codes
' ----------
' 0 = No error
' 1 = Sintax error
' 2 = ...
' 3 = ...
'
' Other files used
' ----------------
' (none)
'
' Change Log
' ----------
' Date       : 2017/01/01
' Who (eMail): fin392@gmail.com 
' Description: Initial version
'  
' Date       : 2017/09/20
' Who (eMail): fin392@gmail.com 
' Description: Brief description of the change
'  
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit

' Constants
'Const conForReading = 1
'Const conForWriting = 2
'Const conForAppending = 8
'Const conUnicode = -1
'Const conASCII = 0

' Global vars
'Dim intVariable
'Dim dtaVariable
'Dim strVariable
'Dim objVariable
'Dim blnVariable
'Dim arrVariable

' Set timeout to 1 hour
WScript.Timeout = 3600

' Include a VBS
ExecuteGlobal CreateObject( "Scripting.FileSystemObject" ).OpenTextFile( ".\__IniFileClass.vbs", 1, False ).ReadAll

' Check sintax
Select Case WScript.Arguments.Count
	Case 0
		' Actions for no parameters
	Case 1
		' Actions for 1 parameter
	Case 2
		' Actions for 2 parameters
	Case Else
		' Worng number of parameters
		Syntax()
		WScript.Quit 1
End Select



' Example of error handling
On Error Resume Next
WScript.this_is_an_error
If Oops( Err, "This a brief description of the attempted action" ) Then WScript.Quit 1






' End of script
WScript.Quit 0
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Oops( {Error Object}, {Description of action}  )
'
' In case of error display it and return TRUE.
' If no error return FALSE.
'
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

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Syntax
'
' Display script sintax.
'
Sub Syntax()
	WScript.Echo WScript.ScriptName & " (Version 1.0.0)" & vbCrLf & _
		vbCrLf & _
		"Brief description of the functionality." & vbCrLf & _
		vbCrLf & _
		"Sintax:  TEMAPLTE.vbs {param1} {param2} [[{param3}]...]" & vbCrLf & _
		vbCrLf & _
		"{param1}: First parameter" & vbCrLf & _
		"{param2}: Second parameter" & vbCrLf & _
		"{param3}: Optional. Third parameter" & vbCrLf
End Sub
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' End of file
'
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
