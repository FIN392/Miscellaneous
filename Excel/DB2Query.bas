''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Function name: DB2Query
'
' Description: Retrieve DB2 records based in a SQL sentence.
'
' Dependency: IBM Client Access OLE DB provider (connection strings "IBMDA400").
'
' Input parameters:
'       String. iSeries server name.
'       String. iSeries user account name.
'       String. iSeries password.
'       String. SQL Sentence.
'       Boolean. (Optional). Add fields names in first record. Default true.
'
' Output value:
'       Variant. Array with records.
'
' Version: 2021-02-21 by fin392@gmail.com
'
Public Function DB2Query( _
        ByVal strServer As String, _
        ByVal strUserName As String, _
        ByVal strPassword As String, _
        ByVal strSQLSentence As String, _
        Optional ByVal blnHeaders As Boolean = True _
    ) As Variant
    
    On Error GoTo Oops
    
    Dim objConn As Object       ' ADODB Connection object
    Dim objRS As Object         ' ADODB Recordset object
    Dim strConnect As String    ' ADODB Connection string
    Dim arrDATA As Variant      ' Array for returned data
    Dim i, j As Long            ' Loops counters
    
    ' Open ADODB connection
    Set objConn = CreateObject("ADODB.Connection")
    Set objRS = CreateObject("ADODB.Recordset")
    strConnect = _
        "Provider=IBMDA400;" & _
        "Data Source=" & strServer & ";" & _
        "User Id=" & strUserName & ";" & _
        "Password=" & strPassword
    objConn.ConnectionString = strConnect
    objConn.Open
    Set objRS = objConn.Execute(strSQLSentence)
    
    ' Get records and copy in array variable
    If objRS.BOF And objRS.EOF Then
        DB2Query = Empty
        Exit Function
    Else
        arrDATA = objRS.GetRows()
    End If

    ' Add headers
    If blnHeaders Then
        ' Add one extra line to array
        ReDim Preserve arrDATA(UBound(arrDATA, 1), UBound(arrDATA, 2) + 1)
        ' Move data 1 line down
        For i = 0 To UBound(arrDATA, 1)
            For j = UBound(arrDATA, 2) To 1 Step -1
                arrDATA(i, j) = arrDATA(i, j - 1)
            Next
        Next
        ' Add fields names in line 0
        For i = 0 To objRS.Fields.Count - 1
            arrDATA(i, 0) = objRS.Fields(i).Name
        Next
    End If

    DB2Query = arrDATA
    
    ' Close ADODB connection
    objConn.Close
    Set objConn = Nothing

Exit Function
' Error handling
Oops:
    MsgBox Err.Description & vbCrLf & vbCrLf & " (Error: " & Err.Number & ")", vbOKOnly + vbCritical + vbDefaultButton1 + vbApplicationModal, "Oops!!!"
End Function
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
