''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Function name: Authentication
'
' Description: Ask user and password.
'
' Input parameters:
'       NONE.
'
' Output value:
'       Variant. Array with user and PASSWORD.
'
' Version: 2021-02-21 by fin392@gmail.com
'
Public Function Authentication()
        
    On Error GoTo Oops
    
    Dim strUserName As String
    Dim strPassword As String
    
    frm_Authentication.Show vbModal
    If frm_Authentication.Cancelled Then
        Exit Function
    Else
        strUserName = frm_Authentication.User
        strPassword = frm_Authentication.Password
    End If
    Unload frm_Authentication
    Set frm_Authentication = Nothing
    
    Authentication = Array(strUserName, strPassword)
    

Exit Function
' Error handling
Oops:
    MsgBox Err.Description & vbCrLf & vbCrLf & " (Error: " & Err.Number & ")", vbOKOnly + vbCritical + vbDefaultButton1 + vbApplicationModal, "Oops!!!"
End Function
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
