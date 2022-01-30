''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Function name: DownloadFile
'
' Description: Download a file via HTTP GET.
'
' Input parameters:
'       String. HTTP URL of file to download.
'       String. Full path name of destination.
'
' Output value:
'       Boolean. TRUE for success download.
'
' Version: 2021-02-21 by fin392@gmail.com
'
Public Function DownloadFile( _
        ByVal strSourceURL As String, _
        ByVal strDestinationFullPathName As String _
    ) As Boolean

    On Error GoTo Oops
    
    Const adTypeBinary = 1
    Const adSaveCreateOverWrite = 2
    
    Dim objWinHttpReq As Object
    Dim objStream As Object
    
    DownloadFile = False
       
    Set objWinHttpReq = CreateObject("Microsoft.XMLHTTP")
    objWinHttpReq.Open "GET", strSourceURL, False
    objWinHttpReq.Send
    
    strSourceURL = objWinHttpReq.ResponseBody
    If objWinHttpReq.Status = 200 Then
        Set objStream = CreateObject("ADODB.Stream")
        objStream.Open
        objStream.Type = adTypeBinary
        objStream.Write objWinHttpReq.ResponseBody
        objStream.SaveToFile strDestinationFullPathName, adSaveCreateOverWrite
        objStream.Close
    
        DownloadFile = True
        
    End If

    Set objWinHttpReq = Nothing
    Set objStream = Nothing


Exit Function
' Error handling
Oops:
    MsgBox Err.Description & vbCrLf & vbCrLf & " (Error: " & Err.Number & ")", vbOKOnly + vbCritical + vbDefaultButton1 + vbApplicationModal, "Oops!!!"
End Function
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
