'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' EUOps ''
'
' Test_of_VBS_out_on_Excel
'
' Create a Excel file with information from each server within the input file.
'
' 2013/11/09 - FIN392 - Initial version.
'
Option Explicit
Dim aColTitle, aColFormat, sTitle, sFileName, strMsgBoxText, objFSO, objFile
Dim strData, objExcel, objWorkbook, objWorksheet, iRow, iCol, objRange

' Report title
sTitle = "EXAMPLE OF REPORT"

' Columns titles
aColTitle = Array( _
	"Server name", _
	"Wrap text", _
	"Text", _
	"Number", _
	"Currency", _
	"Date", _
	"Time" _
)

' Columns formats
aColFormat = Array( _
	"General", _
	"Wrap text", _
	"Text", _
	"Number", _
	"Currency", _
	"Date", _
	"Time" _
)

' Syntax checking
sFileName = "/?"
On Error Resume Next
sFileName = WScript.Arguments.Item( 0 )
On Error Goto 0
If sFileName = "/?" Then
	strMsgBoxText = "This script create a Excel file with local accounts " & _
		"on each server within the input file." & chr(13) & _
		"" & chr(13) & _
		"Please, drag and drop a file with list of servers to evaluate " & _
		"over this script's icon."
	MsgBox strMsgBoxText, 0, Wscript.ScriptName
	WScript.Quit( 1 )
End If

' Does the file exists?
Set objFSO = createobject( "Scripting.FileSystemObject" )
If Not objFSO.FileExists( sFileName ) Then
	MsgBox "The file specified could not be found.", 0, Wscript.ScriptName
	WScript.Quit( 2 )
End If

' Create Excel worksheet
Set objExcel = CreateObject( "Excel.Application" )
objExcel.Visible = True
Set objWorkbook = objExcel.Workbooks.Add
Set objWorksheet = objWorkbook.Worksheets( 1 )
objWorksheet.Name = "Report"

' Warning
objWorksheet.Shapes.AddTextbox( 1, 50, 50, 200, 50 ).TextFrame.Characters.Text = _
		"Wait until the file is fully created."  & chr(13) & "..."
objWorksheet.Shapes( 1 ).TextFrame.Characters.Font.Size = 12
objWorksheet.Shapes( 1 ).TextFrame.Characters.Font.Color = &H0000FF&
objWorksheet.Shapes( 1 ).TextFrame.HorizontalAlignment = -4108
objWorksheet.Shapes( 1 ).TextFrame.VerticalAlignment = -4108

' Set bold and underline for first row (headers)
objExcel.Range( "1:1" ).Select
objExcel.Selection.Font.Bold = True
objExcel.Selection.Font.Underline = True

' Set titles on first row (headers)
For iCol = 1 To UBound( aColTitle ) + 1
	objExcel.Cells( 1, iCol ).Value = aColTitle( iCol - 1 )
Next
iRow = 2

' Open input file for reading
Set objFile = objFSO.openTextFile( sFileName, 1 )
strData = ""
' Loop per line in file
Do Until objFile.atEndOfStream
	' Read line
	strData = objFile.readLine

	' Show in the box the servername
	objWorksheet.Shapes( 1 ).TextFrame.Characters.Text = _
		"Wait until the file is fully created."  & chr(13) & "Evaluating " & _
		strData & "..."
		
	' Call subrutine
	Call GetServerInfo( strData )
Loop

' Columns format
For iCol = 1 To UBound( aColFormat ) + 1
	Set objRange = objWorksheet.Columns( iCol )
	objRange.VerticalAlignment = -4160
	Select Case aColFormat( iCol - 1 )
	Case "General"
		objRange.NumberFormat = "General"
	Case "Wrap text"
		objRange.NumberFormat = "@"
		objRange.WrapText = True
		objRange.ColumnWidth = 60
	Case "Text"
		objRange.NumberFormat = "@"
	Case "Number"
		objRange.NumberFormat = "#,##0.00"
	Case "Currency"
		objRange.Style = "Currency"
	Case "Date"
		objRange.NumberFormat = "yyyy-mmm-dd"
	Case "Time"
		objRange.NumberFormat = "hh:mm:ss AM/PM"
	Case else
		objRange.NumberFormat = "General"
	End Select
Next

' Remove Warning
objWorksheet.Shapes( 1 ).Delete

' Select all
Set objRange = objWorksheet.Columns( "A:" & Chr( 65 + UBound( aColFormat ) ) )
' AutoFilter
objRange.AutoFilter 
' Column width auto fit
objRange.EntireColumn.Autofit()
' Row 1 freezed
objWorksheet.Application.ActiveWindow.SplitRow = 1
objWorksheet.Application.ActiveWindow.FreezePanes = True

' Print options
objWorksheet.Application.PrintCommunication = False
With objWorksheet.Application.ActiveWindow.ActiveSheet.PageSetup
	.PrintTitleRows = "1:1"
	.PrintTitleColumns = ""
End With
objWorksheet.Application.PrintCommunication = True
objWorksheet.Application.ActiveWindow.ActiveSheet.PageSetup.PrintArea = ""
objWorksheet.Application.PrintCommunication = False
With objWorksheet.Application.ActiveWindow.ActiveSheet.PageSetup
	.LeftHeader = ""
	.CenterHeader = "&14" & sTitle & "   "
	.RightHeader = ""
	.LeftFooter = "ACME Internal Use Only"
	.CenterFooter = ""
	.RightFooter = "Page &P of &N    "
	.LeftMargin = 30
	.RightMargin = 30
	.TopMargin = 30
	.BottomMargin = 30
	.HeaderMargin = 10
	.FooterMargin = 10
	.PrintHeadings = False
	.PrintGridlines = False
	.PrintQuality = 1200
	.CenterHorizontally = False
	.CenterVertically = False
	.Orientation = 2 'xlLandscape
	.Draft = False
	.PaperSize = 9 'xlPaperA4
	.FirstPageNumber = -4105 'xlAutomatic
	.Order = 1 'xlDownThenOver
	.BlackAndWhite = False
	.Zoom = False
	.FitToPagesWide = 1
	.FitToPagesTall = 0
	.PrintErrors = 0 'xlPrintErrorsDisplayed
	.OddAndEvenPagesHeaderFooter = False
	.DifferentFirstPageHeaderFooter = False
	.ScaleWithDocHeaderFooter = True
	.AlignMarginsHeaderFooter = True
	.EvenPage.LeftHeader.Text = ""
	.EvenPage.CenterHeader.Text = ""
	.EvenPage.RightHeader.Text = ""
	.EvenPage.LeftFooter.Text = ""
	.EvenPage.CenterFooter.Text = ""
	.EvenPage.RightFooter.Text = ""
	.FirstPage.LeftHeader.Text = ""
	.FirstPage.CenterHeader.Text = ""
	.FirstPage.RightHeader.Text = ""
	.FirstPage.LeftFooter.Text = ""
	.FirstPage.CenterFooter.Text = ""
	.FirstPage.RightFooter.Text = ""
End With
objWorksheet.Application.PrintCommunication = True

' Activate and view 
objExcel.Range( "A1" ).Select
objWorksheet.Activate
objExcel.Visible = True

' Save before close warning
strMsgBoxText = "Excel worksheet created." & chr( 13 ) & _
	"" & chr( 13 ) & _
	"Save it before closing Excel."
MsgBox strMsgBoxText, 0, Wscript.ScriptName

' Close input file, clean objects and exit
objFile.close
Set objFile = Nothing
Set objFSO = Nothing
WScript.Quit( 0 )

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Get server info
'
Sub GetServerInfo( strServer )
Dim objWMIService, colAccounts, objAccount

	On Error Resume Next
'	Set objWMIService = GetObject( "winmgmts:\\" & strServer & "\root\cimv2" )
'	If  Err.Number <> 0 Then
'		objExcel.Cells( iRow, 1 ).Value = strServer
'		objExcel.Cells( iRow, 1 ).Font.Color = &H0000FF&
'		objExcel.Cells( iRow, 2 ).Value = "Error: " & Err.Number & " - " & Err.Description
'		objExcel.Cells( iRow, 2 ).Font.Color = &H0000FF&
'		iRow = iRow + 1
'		Err.Clear
'		Exit Sub
'	End If	
'	Set colAccounts = objWMIService.ExecQuery _
'		( "Select * From Win32_UserAccount Where LocalAccount = TRUE" )
'	For Each objAccount in colAccounts

	' Test values
	For i = 0 To 5
		objExcel.Cells( iRow, 1 ).Value = strServer
		objExcel.Cells( iRow, 2 ).Value = "Error: 462 - The remote server machine does not exist or is unavailable"
		objExcel.Cells( iRow, 3 ).Value = "This is a text example"
		objExcel.Cells( iRow, 4 ).Value = 123456.789
		objExcel.Cells( iRow, 5 ).Value = 123456.789
		objExcel.Cells( iRow, 6 ).Value = "01/02/2013"
		objExcel.Cells( iRow, 7 ).Value = "12:34:56"
		
		iRow = iRow + 1
	Next
	On Error Goto 0

End Sub
'
' End of script
'
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' EUOps ''
