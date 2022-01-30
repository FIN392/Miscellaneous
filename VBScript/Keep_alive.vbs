Set objWS = CreateObject("WScript.Shell") 
Do

	objWS.AppActivate "_Keep_alive.vbs - Notepad"
	objWS.SendKeys "{F5}"
	objWS.SendKeys " Hello World!"
	objWS.SendKeys "{ENTER}"

	' 5 Minutes
	WScript.Sleep 300000

Loop




