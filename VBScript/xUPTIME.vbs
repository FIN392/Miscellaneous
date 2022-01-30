''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' GIS Spain ''
'
' StartUpNotification.cmd
' -----------------------
'
' Description
' -----------
' This script display last 10 boot and shutdown events.
'
' Other files required
' --------------------
' (none)
'
' Release history
' ---------------
' 2012/05/01 - FIN392 - Initial release.
'
strComputer = "."

dtmLastShutdown = "-"
dtmLastBoot = "-"

' Query Event Log
Set objWMIService = GetObject( "winmgmts:" _
	& "{impersonationLevel=impersonate}!\\" _
	& strComputer & "\root\cimv2" )
Set colLoggedEvents = objWMIService.ExecQuery _
	( "select * from Win32_NTLogEvent " & _
		"where Logfile = 'System' and ( EventCode = '6005' or EventCode = '6006' )" )

' Header
Wscript.Echo "Date and time (UTC)  Event     Comment"
'Wscript.Echo "-------------------  --------  -------------------------"

' Event counter
i = 1

' Events loop
For Each objEvent in colLoggedEvents
	' Only last 10 events
	If i > 10 Then
		Exit For
	End If
	If objEvent.EventCode = "6006" Then
		' Shutdown event
		strLine = dtm2strDateTime( objEvent.TimeWritten ) & "  Shutdown  "
		If dtmLastBoot <> "-" Then
			strLine = strLine & "Downtime: " & SecondsToTime( DateDiff( "s", dtm2strDateTime( objEvent.TimeWritten ), dtm2strDateTime( dtmLastBoot ) ) )
		End If
		dtmLastShutdown = objEvent.TimeWritten
	Else
		' Boot event
		strLine = dtm2strDateTime( objEvent.TimeWritten ) & "  Boot      "
		If dtmLastShutdown <> "-" Then
			strLine = strLine & "Uptime: " & SecondsToTime( DateDiff( "s", dtm2strDateTime( objEvent.TimeWritten ), dtm2strDateTime( dtmLastShutdown ) ) )
		End If
		dtmLastBoot = objEvent.TimeWritten
	End If
	Wscript.Echo strLine
	i = i + 1
Next

' Convert "yyyymmddhhmmss.000000-000" to "yyyy/mm/dd hh:mm:ss"
Function dtm2strDateTime( dtmEventDate )
	dtm2strDateTime = _
		Left( dtmEventDate, 4 ) & "/" & _
		Mid( dtmEventDate, 5, 2 ) & "/" & _
		Mid( dtmEventDate, 7, 2 ) & " " & _
		Mid( dtmEventDate, 9, 2 ) & ":" & _
		Mid( dtmEventDate, 11, 2 ) & ":" & _
		Mid( dtmEventDate, 13, 2 )
End Function

' Convert seconds to "..d ..h ..m ..s"
Function SecondsToTime( intSeconds )
	days = intSeconds \ 86400
	intSeconds = intSeconds Mod 86400
	hours = intSeconds \ 3600
	intSeconds = intSeconds Mod 3600
	minutes = intSeconds \ 60
	seconds = intSeconds Mod 60
	SecondsToTime = days & "d " & hours & "h " & minutes & "m " & seconds & "s"
End Function
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' GIS Spain ''