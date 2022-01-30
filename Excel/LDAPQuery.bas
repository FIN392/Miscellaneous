''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Function name: LDAPQuery
'
' Description: Retrieve LDAP records based in a filter and a list of attributes.
'
' Input parameters:
'       String. LDAP Filter string. SEE EXAMPLES AT THE END OF THIS MODULE.
'       String. List of attributes to retrieve. SEE EXAMPLES AT THE END OF THIS MODULE.
'
' Output value:
'       Variant. Array with records.
'
' Version: 2021-02-21 by fin392@gmail.com
'
Public Function LDAPQuery( _
        ByVal strLDAPFilter As String, _
        ByVal strAttributes As String _
    ) As Variant

    Dim objADOCommand As Object
    Dim objADOConnection As Object
    Dim objRootDSE As Object
    Dim strDNSDomain As String
    Dim strBase As String
    Dim strQuery As String
    Dim objADORecordset As Object
    
    On Error GoTo Oops

    ' Setup ADO objects
    Set objADOCommand = CreateObject("ADODB.Command")
    Set objADOConnection = CreateObject("ADODB.Connection")
    objADOConnection.Provider = "ADsDSOObject"
    objADOConnection.Open "Active Directory Provider"
    Set objADOCommand.activeconnection = objADOConnection
    
    ' Search entire Active Directory domain
    Set objRootDSE = GetObject("LDAP://RootDSE")

    strDNSDomain = objRootDSE.Get("defaultNamingContext")
    strBase = "<LDAP://" & strDNSDomain & ">"

    ' Construct the LDAP syntax query
    strQuery = strBase & ";" & strLDAPFilter & ";" & strAttributes & ";subtree"
    objADOCommand.CommandText = strQuery
    objADOCommand.Properties("Page Size") = 50
    objADOCommand.Properties("Timeout") = 3000
    objADOCommand.Properties("Cache Results") = False

    ' Run the query
    Set objADORecordset = objADOCommand.Execute

    If objADORecordset.BOF Or objADORecordset.EOF Then
        ' No records returned
        LDAPQuery = Empty
    Else
        ''' THIS STEP COULD TAKE LONG TIME '''
        ' Save record set data in an array
        LDAPQuery = objADORecordset.GetRows()
        '''''''''''''''''''''''''''''''''''''
    End If

Exit Function
' Error handling
Oops:
    MsgBox Err.Description & vbCrLf & vbCrLf & " (Error: " & Err.Number & ")", vbOKOnly + vbCritical + vbDefaultButton1 + vbApplicationModal, "Oops!!!"
End Function
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' EXAMPLES
'
' Filters:
'   Only enabled accounts                      (!userAccountControl:1.2.840.113556.1.4.803:=2)
'   Accounts for country ES                    (c=ES)
'   Accounts for multiple countries            (|(c=ES)(c=PT)(c=IL)(c=FR)(c=BE))
'   Only employees and contractors             (|(employeeType=EMPLOYEE)(employeeType=CONTRACTOR))
'   Accounts with valid mail address           (mail=*.com)
'   User accounts                              (sAMAccountType=805306368)
'
' Attributes:
'   c
'   Division
'   Department
'   Title
'   displayName
'   Mail
'   telephoneNumber
'   Mobile
'   sAMAccountName
'   employeeNumber
'   employeeType
'   whenCreated
'   Manager
'   distinguishedName
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
