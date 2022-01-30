Include "library\IniFileClass.vbs"

' Inicializa un objeto IniFile
Set oConfigfile = new IniFile

' Nombre del fichero INI
oConfigfile.Filename = "qwe.ini"

' Añade claves al fichero INI
oConfigfile.Section = "Seccion 1"
oConfigfile.Key = "Clave 1"
oConfigfile.Value = "VALOR 1.1"

oConfigfile.Section = "Seccion 1"
oConfigfile.Key = "Clave 2"
oConfigfile.Value = "VALOR 1.2"

oConfigfile.Section = "Seccion 2"
oConfigfile.Key = "Clave 1"
oConfigfile.Value = "VALOR 2.1"

oConfigfile.Section = "Seccion 2"
oConfigfile.Key = "Clave 2"
oConfigfile.Value = "VALOR 2.2"

' Lee claves del fichero INI
oConfigfile.Section = "Seccion 1"
oConfigfile.Key = "Clave 1"
WScript.echo oConfigfile.Value

oConfigfile.Section = "Seccion 2"
oConfigfile.Key = "Clave 2"
WScript.echo oConfigfile.Value

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
