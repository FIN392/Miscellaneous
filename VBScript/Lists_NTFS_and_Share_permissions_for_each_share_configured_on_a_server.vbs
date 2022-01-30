Option Explicit

' WMI Constants

Const WBEM_RETURN_IMMEDIATELY = &h10
Const WBEM_FORWARD_ONLY = &h20

' Constants and storage arrays for security settings

' GetSecurityDescriptor Return values

Dim objReturnCodes : Set objReturnCodes = CreateObject("Scripting.Dictionary")
Const SUCCESS = 0
Const ACCESS_DENIED = 2
Const UNKNOWN_FAILURE = 8
Const PRIVILEGE_MISSING = 9
Const INVALID_PARAMETER = 21

' Security Descriptor Control Flags

Dim objControlFlags : Set objControlFlags = CreateObject("Scripting.Dictionary")
objControlFlags.Add 32768, "SelfRelative"
objControlFlags.Add 16384, "RMControlValid"
objControlFlags.Add 8192, "SystemAclProtected"
objControlFlags.Add 4096, "DiscretionaryAclProtected"
objControlFlags.Add 2048, "SystemAclAutoInherited"
objControlFlags.Add 1024, "DiscretionaryAclAutoInherited"
objControlFlags.Add 512, "SystemAclAutoInheritRequired"
objControlFlags.Add 256, "DiscretionaryAclAutoInheritRequired"
objControlFlags.Add 32, "SystemAclDefaulted"
objControlFlags.Add 16, "SystemAclPresent"
objControlFlags.Add 8, "DiscretionaryAclDefaulted"
objControlFlags.Add 4, "DiscretionaryAclPresent"
objControlFlags.Add 2, "GroupDefaulted"
objControlFlags.Add 1, "OwnerDefaulted"

' ACE Access Right

Dim objAccessRights : Set objAccessRights = CreateObject("Scripting.Dictionary")
objAccessRights.Add 2032127, "FullControl"
objAccessRights.Add 1048576, "Synchronize"
objAccessRights.Add 524288, "TakeOwnership"
objAccessRights.Add 262144, "ChangePermissions"
objAccessRights.Add 197055, "Modify"
objAccessRights.Add 131241, "ReadAndExecute"
objAccessRights.Add 131209, "Read"
objAccessRights.Add 131072, "ReadPermissions"
objAccessRights.Add 65536, "Delete"
objAccessRights.Add 278, "Write"
objAccessRights.Add 256, "WriteAttributes"
objAccessRights.Add 128, "ReadAttributes"
objAccessRights.Add 64, "DeleteSubdirectoriesAndFiles"
objAccessRights.Add 32, "ExecuteFile"
objAccessRights.Add 16, "WriteExtendedAttributes"
objAccessRights.Add 8, "ReadExtendedAttributes"
objAccessRights.Add 4, "AppendData"
objAccessRights.Add 2, "CreateFiles"
objAccessRights.Add 1, "ReadData"

' ACE Types

Dim objAceTypes : Set objAceTypes = CreateObject("Scripting.Dictionary")
objAceTypes.Add 0, "Allow"
objAceTypes.Add 1, "Deny"
objAceTypes.Add 2, "Audit"

' ACE Flags

Dim objAceFlags : Set objAceFlags = CreateObject("Scripting.Dictionary")
objAceFlags.Add 128, "FailedAccess"
objAceFlags.Add 64, "SuccessfulAccess"
objAceFlags.Add 16, "Inherited"
objAceFlags.Add 8, "InheritOnly"
objAceFlags.Add 4, "NoPropagateInherit"
objAceFlags.Add 2, "ContainerInherit"
objAceFlags.Add 1, "ObjectInherit"

Sub ReadNTFSSecurity(objWMI, strPath)
	WScript.Echo "	Displaying NTFS Security"

	Dim objSecuritySettings : Set objSecuritySettings = _
		objWMI.Get("Win32_LogicalFileSecuritySetting='" & strPath & "'")
	Dim objSD : objSecuritySettings.GetSecurityDescriptor objSD

	Dim strDomain : strDomain = objSD.Owner.Domain
	If strDomain <> "" Then strDomain = strDomain & "\"
	WScript.Echo "	Owner: " & strDomain & objSD.Owner.Name
	WScript.Echo "	Owner SID: " & objSD.Owner.SIDString

	WScript.Echo "	Basic Control Flags Value: " & objSD.ControlFlags
	WScript.Echo "	Control Flags:"

	DisplayValues objSD.ControlFlags, objControlFlags

	WScript.Echo

	Dim objACE

	' Display the DACL

	WScript.Echo "	Discretionary Access Control List:"
	For Each objACE in objSD.DACL
		DisplayACE objACE
	Next

	' Display the SACL (if there is one)

	If Not IsNull(objSD.SACL) Then
		WScript.Echo "	System Access Control List:"
		For Each objACE in objSD.SACL
			DisplayACE objACE
		Next
	End If
End Sub

Sub ReadShareSecurity(objWMI, strName)
	WScript.Echo "	Displaying Share Security"

	Dim objSecuritySettings : Set objSecuritySettings = _
		objWMI.Get("Win32_LogicalShareSecuritySetting='" & strName & "'")

	Dim objSD : objSecuritySettings.GetSecurityDescriptor objSD

	WScript.Echo "	Basic Control Flags Value: " & objSD.ControlFlags
	WScript.Echo "	Control Flags:"

	DisplayValues objSD.ControlFlags, objControlFlags

	WScript.Echo

	Dim objACE

	' Display the DACL

	WScript.Echo "	Discretionary Access Control List:"
	For Each objACE in objSD.DACL
		DisplayACE objACE
	Next
End Sub

Sub DisplayValues(dblValues, objSecurityEnumeration)

	Dim dblValue
	For Each dblValue in objSecurityEnumeration
		If dblValues >= dblValue Then
			WScript.Echo "			" & objSecurityEnumeration(dblValue)
			dblValues = dblValues - dblValue
		End If
	Next
End Sub

Sub DisplayACE(objACE)

	Dim strDomain : strDomain = objAce.Trustee.Domain
	If strDomain <> "" Then strDomain = strDomain & "\"
	WScript.Echo "		Trustee: " & UCase(strDomain & objAce.Trustee.Name)
	WScript.Echo "		SID: " & objAce.Trustee.SIDString

	WScript.Echo "		Basic Access Mask Value: " & objACE.AccessMask

	WScript.Echo "		Access Rights: "
	DisplayValues objACE.AccessMask, objAccessRights

	WScript.Echo "		Type: " & objAceTypes(objACE.AceType)

	WScript.Echo "		Basic ACE Flags Value: " & objACE.AceFlags

	WScript.Echo "		ACE Flags: "
	DisplayValues objACE.AceFlags, objAceFlags
	WScript.Echo
End Sub

'
' Main Code
'

' The system to execute this script against
Dim strComputer : strComputer = "."

' Connect to WMI
Dim objWMI : Set objWMI = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")

' Return all of the shares (Type = 0 means File Shares only, exclude
' are Administrative, Printer, etc)
Dim colItems : Set colItems = _
	objWMI.ExecQuery("SELECT * FROM Win32_Share WHERE Type='0'", "WQL", _
	WBEM_RETURN_IMMEDIATELY + WBEM_FORWARD_ONLY)

Dim objItem
For Each objItem in colItems
	WScript.Echo
	WScript.Echo "Security for " & objItem.Path & _
		" (Shared as " & objItem.Name & ")"

	ReadNTFSSecurity objWMI, objItem.Path
	ReadShareSecurity objWMI, objItem.Name
Next