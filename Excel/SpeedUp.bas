''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Sub name: SpeedUp
'
' Description: Speed up VBA code execution by disabling some options.
'
' Input parameters:
'       Boolean. TRUE disable options and FALSE enable again.
'
' Output value:
'       NONE.
'
' Version: 2021-02-21 by fin392@gmail.com
'
Public Sub SpeedUp( _
        ByVal blnDisable As Boolean _
    )

    With Application
        .Calculation = IIf(blnDisable, xlCalculationManual, xlCalculationAutomatic)
        .ScreenUpdating = Not blnDisable
        .DisplayStatusBar = Not blnDisable
        .EnableEvents = Not blnDisable
    End With

End Sub
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
