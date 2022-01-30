

'...

' Control de WSH utilizado.
ChkScriptHost( "xCSCRIPT" )

'...


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' ChkScriptHost ( <Nombre de WSH permitido> )
'
' Chequea el Windows Scripting Host (WSH) utilizado para ejecutar el script.
' Si NO coincide con la cadena pasada como parámetro, muestra un aviso y
' finaliza el script.
'
' 2006/08/24 - FIN392 - Versión inicial.
'
Private Sub ChkScriptHost( ByRef strWSH )

	On Error Resume Next

	Dim strFullName
	Dim i
	Dim j

	strFullName = UCase( WScript.FullName )
	If Err.Number then
		WScript.Echo "ERROR: No se pudo identificar el motor WSH utilizado."
		WScript.Quit
	End If

	i = InStr( 1, strFullName, ".EXE", 1 )
	If i = 0 Then
		WScript.Echo "ERROR: No se pudo identificar el motor WSH utilizado."
		WScript.Quit
	Else
		j = InStrRev( strFullName, "\", i, 1 )
		If j = 0 Then
			WScript.Echo "ERROR: No se pudo identificar el motor WSH utilizado."
			WScript.Quit
		Else
			If Mid( strFullName, j+1, i-j-1 ) <> UCase( strWSH ) Then 
				WScript.Echo "ATENCION: Este script necesita ser ejecutado con " & UCase( strWSH ) & "." & vbCRLF & _
					vbCRLF & _
					"Para ejecutarlo, utilice una de esta dos opciones:" & vbCRLF & _
					vbCRLF & _
					"1.- Teclee '" & UCase( strWSH ) & " " & UCase( WScript.ScriptName ) & " [parámetros]'" & vbCRLF & _
					vbCRLF & _
					"2.- Establezca " & UCase( strWSH ) & " como Windows Scripting Host por defecto mediante la orden:" & vbCRLF & _
					vbCRLF & _
					"        '" & UCase( strWSH ) & " //H:" & UCase( strWSH ) & " //S'" & vbCRLF & _
					vbCRLF & _
					"    y posteriormente ejecute el script como" & vbCRLF & _
					vbCRLF & _
					"        '" & UCase( WScript.ScriptName ) & " [parámetros]'"
				WScript.Quit
			End If
		End If
	End If

End Sub
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
