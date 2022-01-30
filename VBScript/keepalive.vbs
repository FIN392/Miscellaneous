Option Explicit 
 
' Script to prevent the computer from going into sleep mode 
' Enter runtime in minutes from user input or command line 
' Example: wscript.exe keepalive.vbs 20 
' Script can be terminated by running it a second time 
' By Jorgen Bigom 
Dim objWMIService, colItems, objItem, runtime, objArgs, objShell, i 
Set objShell = WScript.CreateObject("WScript.Shell") 
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2") 
 
' Get instances of keepalive.vbs running under wscript.exe or cscript.exe 
Set colItems = objWMIService.ExecQuery ("Select * from Win32_Process Where Name = 'wscript.exe' Or Name = 'cscript.exe' And CommandLine like '%keepalive.vbs%'") 
If colItems.count > 1 Then 
    objShell.Popup "Keepalive script terminated", 5 
' Get all instances of keepalive.vbs and terminate them 
    Set colItems = objWMIService.ExecQuery ("Select * from Win32_Process Where CommandLine like '%keepalive.vbs%'") 
    For Each objItem in colItems 
        objItem.Terminate 
    Next 
    Wscript.Quit 
End If 
Set objWMIService = Nothing: Set colItems = Nothing 
 
' # ' Get runtime from command line or user input 
' # Set objArgs = WScript.Arguments 
' # If objArgs.Count Then 
' #     runtime = objArgs(0) 
' # Else 
' #     runtime = InputBox("Enter run time in minutes:", "Keep Alive Script") 
' # End If 
' # If IsNumeric(runtime) Then 
' #     runtime = Cint(runtime) 
' # Else 
' #     Wscript.Quit 
' # End If 
' # If runtime < 1 Then    Wscript.Quit 
 
' Keepalive loop 
' # 'For i = 1 To runtime * 2 
objShell.Popup "Keepalive script initiated", 5 
Do
    objShell.SendKeys "{NUMLOCK}{NUMLOCK}" 
    ' # 10 minutes pause
    Wscript.Sleep 600000
Loop
' # 'Next