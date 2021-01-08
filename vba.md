# Contents

    - [Snippets](#Snippets)
        - [Slice Array](#Snippets#Slice Array)
        - [Merge Charts](#Snippets#Merge Charts)
        - [Export to text file](#Snippets#Export to text file)
        - [get text alignment from cell](#Snippets#get text alignment from cell)
        - [align text](#Snippets#align text)
        - [round number to a base 2](#Snippets#round number to a base 2)
        - [maximum string length in range](#Snippets#maximum string length in range)
        - [insert zeros into empty cells](#Snippets#insert zeros into empty cells)
        - [Formats cells as scientific with base 10^3](#Snippets#Formats cells as scientific with base 10^3)
        - [vector cross product R3](#Snippets#vector cross product R3)
        - [transpose range as a reference](#Snippets#transpose range as a reference)
        - [bruteforce break of password protected sheet](#Snippets#bruteforce break of password protected sheet)
        - [decimal to binary to decimal](#Snippets#decimal to binary to decimal)
    - [CError](#CError)
    - [CExcelFunctions](#CExcelFunctions)
        - [code](#CExcelFunctions#code)
            - [header](#CExcelFunctions#code#header)
            - [global constants](#CExcelFunctions#code#global constants)
            - [global variables](#CExcelFunctions#code#global variables)
            - [external libraries](#CExcelFunctions#code#external libraries)
            - [class initialisation](#CExcelFunctions#code#class initialisation)
            - [class termination](#CExcelFunctions#code#class termination)
            - [class properties](#CExcelFunctions#code#class properties)
                - [help](#CExcelFunctions#code#class properties#help)
                - [parse module](#CExcelFunctions#code#class properties#parse module)
                - [parse procedure](#CExcelFunctions#code#class properties#parse procedure)
                - [TimerStart](#CExcelFunctions#code#class properties#TimerStart)
                - [TimerLast](#CExcelFunctions#code#class properties#TimerLast)
                - [TimerTotal](#CExcelFunctions#code#class properties#TimerTotal)
                - [GetUserName](#CExcelFunctions#code#class properties#GetUserName)
                - [GetUserProjectDir](#CExcelFunctions#code#class properties#GetUserProjectDir)
            - [functions and procedures](#CExcelFunctions#code#functions and procedures)
                - [PickFile](#CExcelFunctions#code#functions and procedures#PickFile)
                - [GetFiles](#CExcelFunctions#code#functions and procedures#GetFiles)
                - [bFileFilter](#CExcelFunctions#code#functions and procedures#bFileFilter)
                - [PickDir](#CExcelFunctions#code#functions and procedures#PickDir)
                - [GetSubDirs](#CExcelFunctions#code#functions and procedures#GetSubDirs)
                - [SaveFileAs](#CExcelFunctions#code#functions and procedures#SaveFileAs)
                - [SaveFile](#CExcelFunctions#code#functions and procedures#SaveFile)
                - [ExportChart](#CExcelFunctions#code#functions and procedures#ExportChart)
                - [quickSort](#CExcelFunctions#code#functions and procedures#quickSort)
                - [SortDictionaryByKey](#CExcelFunctions#code#functions and procedures#SortDictionaryByKey)
                - [GetColumn](#CExcelFunctions#code#functions and procedures#GetColumn)
                - [GetRow](#CExcelFunctions#code#functions and procedures#GetRow)
                - [bWorksheetExists](#CExcelFunctions#code#functions and procedures#bWorksheetExists)
                - [IsIn](#CExcelFunctions#code#functions and procedures#IsIn)
                - [RemoveDuplicates](#CExcelFunctions#code#functions and procedures#RemoveDuplicates)
                - [AlignRight](#CExcelFunctions#code#functions and procedures#AlignRight)
                - [AlignLeft](#CExcelFunctions#code#functions and procedures#AlignLeft)
                - [AlignJust](#CExcelFunctions#code#functions and procedures#AlignJust)
                - [RoundBase2](#CExcelFunctions#code#functions and procedures#RoundBase2)
                - [VBALinEst](#CExcelFunctions#code#functions and procedures#VBALinEst)
                - [GetTXTContentUNIX](#CExcelFunctions#code#functions and procedures#GetTXTContentUNIX)
                - [GetTXTContentWIN](#CExcelFunctions#code#functions and procedures#GetTXTContentWIN)
                - [StripLines](#CExcelFunctions#code#functions and procedures#StripLines)
                - [StripSpaces](#CExcelFunctions#code#functions and procedures#StripSpaces)
                - [ClearChart](#CExcelFunctions#code#functions and procedures#ClearChart)
                - [WorkStart](#CExcelFunctions#code#functions and procedures#WorkStart)
                - [WorkStop](#CExcelFunctions#code#functions and procedures#WorkStop)
                - [DeleteSheet](#CExcelFunctions#code#functions and procedures#DeleteSheet)
                - [SleepMS](#CExcelFunctions#code#functions and procedures#SleepMS)
                - [PolyInterpolate](#CExcelFunctions#code#functions and procedures#PolyInterpolate)
                - [PolyInterpolateArray](#CExcelFunctions#code#functions and procedures#PolyInterpolateArray)
                - [RaiseError](#CExcelFunctions#code#functions and procedures#RaiseError)
                - [DisplayError](#CExcelFunctions#code#functions and procedures#DisplayError)
                - [GetModuleContent](#CExcelFunctions#code#functions and procedures#GetModuleContent)
                - [GetActiveModule](#CExcelFunctions#code#functions and procedures#GetActiveModule)
                - [ClearImmediateWindow](#CExcelFunctions#code#functions and procedures#ClearImmediateWindow)
                - [bDirExists](#CExcelFunctions#code#functions and procedures#bDirExists)
                - [bFileExists](#CExcelFunctions#code#functions and procedures#bFileExists)
                - [bFileExistsWild](#CExcelFunctions#code#functions and procedures#bFileExistsWild)
                - [CreateDir](#CExcelFunctions#code#functions and procedures#CreateDir)
                - [GetAllModuleNames](#CExcelFunctions#code#functions and procedures#GetAllModuleNames)
                - [GetModuleLineNo](#CExcelFunctions#code#functions and procedures#GetModuleLineNo)
                - [BackupModules](#CExcelFunctions#code#functions and procedures#BackupModules)
                - [BackupWorkbookVBProject](#CExcelFunctions#code#functions and procedures#BackupWorkbookVBProject)
                - [GetFileNameWithExt](#CExcelFunctions#code#functions and procedures#GetFileNameWithExt)
                - [GetFileNameWithoutExt](#CExcelFunctions#code#functions and procedures#GetFileNameWithoutExt)
                - [GetDirPathFromPathFileName](#CExcelFunctions#code#functions and procedures#GetDirPathFromPathFileName)
                - [GetParentDirPathFromPath](#CExcelFunctions#code#functions and procedures#GetParentDirPathFromPath)
                - [GetDirNameFromPath](#CExcelFunctions#code#functions and procedures#GetDirNameFromPath)
                - [GetTicksMS](#CExcelFunctions#code#functions and procedures#GetTicksMS)
                - [TimerStartMS](#CExcelFunctions#code#functions and procedures#TimerStartMS)
                - [TimerLastMS](#CExcelFunctions#code#functions and procedures#TimerLastMS)
                - [TimerTotalMS](#CExcelFunctions#code#functions and procedures#TimerTotalMS)
                - [pprint](#CExcelFunctions#code#functions and procedures#pprint)
                - [arrayToString](#CExcelFunctions#code#functions and procedures#arrayToString)
                - [rangeToString](#CExcelFunctions#code#functions and procedures#rangeToString)
        - [usage](#CExcelFunctions#usage)
            - [test_CEF](#CExcelFunctions#usage#test_CEF)
            - [test_timer](#CExcelFunctions#usage#test_timer)
            - [test_CountModuleLines](#CExcelFunctions#usage#test_CountModuleLines)
            - [test_backupModules](#CExcelFunctions#usage#test_backupModules)
            - [test_paths](#CExcelFunctions#usage#test_paths)
            - [test_ticks](#CExcelFunctions#usage#test_ticks)
            - [Parse_Module](#CExcelFunctions#usage#Parse_Module)
            - [Parse_Procedure](#CExcelFunctions#usage#Parse_Procedure)
    - [CExcelProperties](#CExcelProperties)
        - [header](#CExcelProperties#header)
        - [Class_Initialize](#CExcelProperties#Class_Initialize)
        - [Class_Terminate](#CExcelProperties#Class_Terminate)
        - [RestoreCalculation Get](#CExcelProperties#RestoreCalculation Get)
        - [RestoreCalculation Let](#CExcelProperties#RestoreCalculation Let)
        - [RestoreDisplayAlerts Get](#CExcelProperties#RestoreDisplayAlerts Get)
        - [RestoreDisplayAlerts Let](#CExcelProperties#RestoreDisplayAlerts Let)
        - [RestoreEnableEvents Get](#CExcelProperties#RestoreEnableEvents Get)
        - [RestoreEnableEvents Let](#CExcelProperties#RestoreEnableEvents Let)
        - [RestoreScreenUpdating Get](#CExcelProperties#RestoreScreenUpdating Get)
        - [RestoreScreenUpdating Let](#CExcelProperties#RestoreScreenUpdating Let)
        - [RestoreEnableAnimations Get](#CExcelProperties#RestoreEnableAnimations Get)
        - [RestoreEnableAnimations Let](#CExcelProperties#RestoreEnableAnimations Let)
        - [Save](#CExcelProperties#Save)
        - [Restore](#CExcelProperties#Restore)
    - [Usage Examples](#Usage Examples)
        - [Example_Help](#Usage Examples#Example_Help)
        - [Example_Help_1](#Usage Examples#Example_Help_1)
        - [Example_All](#Usage Examples#Example_All)
        - [Example_Error](#Usage Examples#Example_Error)
        - [Example_BackupModules](#Usage Examples#Example_BackupModules)
    - [CLog](#CLog)
        - [code](#CLog#code)
        - [usage](#CLog#usage)
    - [PwerPoint](#PowerPoint)


# Snippets

## Slice Array
returns sliced array

```vba
Option Explicit

Private Function Slice(ByRef arr As Variant, ByVal s_index As Long, Optional ByVal e_index As Long = 0) As Variant
    Dim tmp As Variant
    Dim i As Long
    tmp = Array()
    
    If s_index < 0 Then
        s_index = UBound(arr) + s_index + 1
    End If
    
    If e_index < 0 Then
        e_index = UBound(arr) + e_index + 1
    ElseIf e_index > UBound(arr) Then
        e_index = UBound(arr)
    ElseIf e_index = 0 Then
        e_index = s_index
    End If
    
    ReDim tmp(e_index - s_index)
    
    For i = s_index To e_index Step 1
        tmp(i - s_index) = arr(i)
    Next
    
    Slice = tmp
End Function
```

## Merge Charts
merges all chart sheets in active Workbook into one

```vba
Private Sub Merge_Charts()
    Dim CEF As New CExcelFunctions
    Dim chts() As String
    Dim cht As Chart
    Dim i As Long
    Dim ser As Series
    
    For i = 1 To ActiveWorkbook.Charts.Count
        ReDim Preserve chts(0 To i - 1)
        chts(i - 1) = ActiveWorkbook.Charts(i).name
    Next

    Set cht = ActiveWorkbook.Charts.Add2(ActiveWorkbook.Sheets(1))
    Call CEF.ClearChart(cht)
    
    For i = LBound(chts) To UBound(chts)
        For Each ser In ActiveWorkbook.Charts(chts(i)).SeriesCollection
            With cht
                .SeriesCollection.NewSeries
                .FullSeriesCollection(.SeriesCollection.Count).name = ActiveWorkbook.Charts(chts(i)).name & "_" & ser.name
                .FullSeriesCollection(.SeriesCollection.Count).XValues = ser.XValues
                .FullSeriesCollection(.SeriesCollection.Count).values = ser.values
            End With
        Next
    Next
    
    cht.ChartType = ActiveWorkbook.Charts(chts(0)).ChartType
    cht.ChartStyle = ActiveWorkbook.Charts(chts(0)).ChartStyle
    
    With ActiveWorkbook.Charts(chts(0))
        cht.ChartType = .ChartType
       
        Call cht.SetElement(msoElementPrimaryCategoryGridLinesMajor)
        Call cht.SetElement(msoElementPrimaryValueGridLinesMajor)
        Call cht.SetElement(msoElementPrimaryValueGridLinesMinorMajor)
        Call cht.SetElement(msoElementPrimaryCategoryGridLinesMinorMajor)
        Call cht.SetElement(msoElementPrimaryValueAxisTitleAdjacentToAxis)
        Call cht.SetElement(msoElementPrimaryCategoryAxisTitleAdjacentToAxis)
        Call cht.SetElement(msoElementLegendRight)
        cht.Axes(xlCategory).MinimumScale = .Axes(xlCategory).MinimumScale
        cht.Axes(xlCategory).MaximumScale = .Axes(xlCategory).MaximumScale
        cht.Axes(xlValue).MinimumScale = .Axes(xlValue).MinimumScale
        cht.Axes(xlValue).MaximumScale = .Axes(xlValue).MaximumScale
        
        cht.ChartTitle.Caption = .ChartTitle.Caption
        
        cht.Axes(xlCategory).AxisTitle.Caption = .Axes(xlCategory).AxisTitle.Caption
        cht.Axes(xlValue).HasTitle = .Axes(xlValue).HasTitle
        cht.Axes(xlValue).AxisTitle.Caption = .Axes(xlValue).AxisTitle.Caption

        With .Legend
            cht.Legend.left = .left
            cht.Legend.width = .width
            cht.Legend.top = .top
            cht.Legend.height = .height
        End With
        cht.PlotArea.width = .PlotArea.width
    End With
End Sub
```

## Export to text file

```vba
Private Sub Export2TXT()
    Const delim As String = " "
    Const LF As String = vbLf
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim rg As Range
    Dim cl As Range
    Dim rows As Long, cols As Long
    Dim i As Long, j As Long
    Dim headerlen() As Long
    Dim align() As String
    
    Set cl = Selection
    
    Dim filename As Variant
    Dim FileNo As Long
    Dim text As String
    
    filename = Application.GetSaveAsFilename(title:="Input filename for export")
    If filename = False Then
        GoTo ExitHere
    End If
    
    Set wb = ActiveWorkbook
    Set ws = wb.ActiveSheet
    rows = ws.Cells(ws.rows.Count, 1).End(xlUp).row
    cols = ws.Cells(1, ws.columns.Count).End(xlToLeft).Column
    Set rg = ws.Cells(1, 1).Resize(rows, cols)
    
    Debug.Print rows & " " & cols
    
    ReDim headerlen(cols) As Long
    For i = 0 To UBound(headerlen) Step 1
        Set cl = rg.Resize(, 1).Offset(, i)
        headerlen(i) = RoundBase2(MaxLen(cl) + Len(delim)) - Len(delim)
    Next
    
    text = ""
    For Each cl In rg.Resize(, 1)
        For i = 0 To cols - 1 Step 1
            text = text & delim & ret_aligned(CStr(cl.Offset(, i).Value), CLng(cl.Offset(, i).HorizontalAlignment), CLng(headerlen(i)))
        Next
        text = text & LF
    Next
    
    ' Debug.Print text
    
    FileNo = FreeFile()
    Open filename For Output As #FileNo
        Print #FileNo, text;  ' write in data, file is for linux -> no carriage return
    Close #FileNo
    
ExitHere:
    On Error Resume Next
    Close #FileNo
    Set cl = Nothing
    Set rg = Nothing
    Set ws = Nothing
    Set wb = Nothing
End Sub
```

## get text alignment from cell

```vba
Private Function ret_aligned(ByVal txt As String, ByVal horAlign As Long, ByVal FieldLen As Long) As String
    Select Case horAlign
        Case xlHAlignCenter, xlHAlignCenterAcrossSelection, xlHAlignDistributed, xlHAlignFill, xlHAlignJustify
            ret_aligned = CenterAlign(txt, FieldLen)
        Case xlHAlignLeft
            ret_aligned = LeftAlign(txt, FieldLen)
        Case xlHAlignRight
            ret_aligned = RightAlign(txt, FieldLen)
        Case Else
            ret_aligned = LeftAlign(txt, FieldLen)
    End Select
End Function
```

## align text

```vba
Private Function RightAlign(txt As String, FieldLen As Long) As String
    Dim StrLen As Long
    Dim Packer As String
    
    StrLen = Len(Trim(txt))
    Packer = String(FieldLen - StrLen, " ")
    RightAlign = Packer & Trim(txt)
End Function
```

```vba
Private Function LeftAlign(txt As String, FieldLen As Long) As String
    Dim StrLen As Long
    Dim Packer As String
    
    StrLen = Len(Trim(txt))
    Packer = String(FieldLen - StrLen, " ")
    LeftAlign = Trim(txt) & Packer
End Function
```

```vba
Private Function CenterAlign(txt As String, FieldLen As Long) As String
    Dim StrLen As Long
    Dim PackerL As String
    Dim PackerR As String
    
    StrLen = Len(Trim(txt))
    If (FieldLen - StrLen) Mod 2 <> 0 Then
        PackerR = String(CLng((FieldLen - StrLen) / 2), " ")
        PackerL = String(FieldLen - StrLen - Len(PackerR), " ")
    Else
        PackerL = String((FieldLen - StrLen) / 2, " ")
        PackerR = PackerL
    End If

    CenterAlign = PackerL & Trim(txt) & PackerR
End Function
```

## round number to a base 2
rounds a number to nearest 2^n value

```vba
Private Function RoundBase2(ByRef n As Double) As Long
    RoundBase2 = CLng(2 ^ Application.WorksheetFunction.RoundUp(log(n) / log(2), 0))
End Function
```

## maximum string length in range

```vba
Private Function MaxLen(ByRef rg As Range)
    Dim length As Long
    Dim cl As Range
    length = 0
    
    For Each cl In rg
        If length < Len(cl.Value) Then length = Len(cl.Value)
    Next
    
    Set cl = Nothing
    MaxLen = length
End Function
```

## insert zeros into empty cells
```vba
Private Sub Insert_Zeros()
    Dim cl As Range
    
    For Each cl In Selection
        If cl.Value = vbNullString Then cl.Value = 0
    Next
End Sub
```

## Formats cells as scientific with base 10^3
```vba
Private Sub NumberFormat_1_0_E3()
    Dim cl As Range
    
    For Each cl In Selection
        cl.NumberFormat = "##0.0E+00;-##0.0E-00;0"
    Next
End Sub
```

## vector cross product R3
```vba
Function vCP(v1 As Variant, v2 As Variant) As Variant
    vCP = Array(v1(2) * v2(3) - v1(3) * v2(2), v1(3) * v2(1) - v1(1) * v2(3), v1(1) * v2(2) - v1(2) * v2(1))
End Function
```

## transpose range as a reference
```vba
Private Sub TransposeAddress()
    Dim rg As Range, cl As Range
    Dim tmp As Variant
    Dim i As Long, j As Long
    
    Set rg = Selection
    
    On Error GoTo ExitHere
    
    tmp = Application.InputBox("Select first target cell", "Transpose Addresses", , , , , , 8).Address
    
    If Not tmp = vbNullString Then
        Set cl = ActiveSheet.Range(tmp)
    End If
    
    For i = 1 To rg.rows.Count Step 1
        For j = 1 To rg.columns.Count Step 1
            cl.Offset(j - 1, i - 1).formula = "=" & rg.Cells(i, j).Address
        Next
    Next
ExitHere:
    On Error Resume Next
    Set cl = Nothing
    Set rg = Nothing
End Sub
```

## bruteforce break of password protected sheet
```vba
Private Sub PasswordBreaker()
    Dim stime As Double, LTime As Double, Interval As Double
    stime = Timer
    LTime = stime
    Debug.Print "[+] Time: " & LTime - stime & " s - Start of script."
    Application.ScreenUpdating = False
    
    Dim ws As Worksheet
    Set ws = ActiveSheet
    Dim i As Long, j As Long
        
    Dim comb As String
    Dim chr1() As String
    Dim chr2() As String
    Dim num As Long
    Dim tot As Long
    
    'Setup:
    num = 11
    Interval = 60   ' seconds
    
    On Error GoTo ExitHere
    
    ReDim chr1(0 To Bin2Dec(String$(num, "1")))
    ReDim chr2(0 To 126 - 32)
    
    For i = 0 To UBound(chr2) Step 1
        chr2(i) = Chr(i + 32)
    Next
    
    For i = 0 To UBound(chr2) Step 1
        comb = Dec2Bin(str(i), num)
        comb = Replace$(comb, "0", "A")
        chr1(i) = Replace$(comb, "1", "B")
    Next
    
    tot = (UBound(chr1) + 1) * (UBound(chr2) + 1)
    LTime = Timer
    Debug.Print "[+] Time: " & LTime - stime & " s - Start of bruteforce attack.."
    Debug.Print "          " & tot & " possible combinations."
    On Error Resume Next
    If ws.ProtectContents Then
        For i = 0 To UBound(chr1) Step 1
            For j = 0 To UBound(chr2) Step 1
                Call ws.Unprotect(chr1(i) & chr2(j))
                If Timer - LTime > Interval Then
                    LTime = Timer
                    num = i * (UBound(chr2) + 1) + j + 1
                    Debug.Print "[-] Time: " & LTime - stime & " " & num & "/" & tot & " [" & String$(Int(num / tot * 20), "#") & String$(20 - Int(num / tot * 20), " ") & "] Trying password: " & chr1(i) & chr2(j)
                End If
                If Not ws.ProtectContents Then
                    LTime = Timer
                    Debug.Print "[+] Time: " & LTime - stime & "s Password: " & chr1(i) & chr2(j)
                    Call MsgBox("Password: " & chr1(i) & chr2(j))
                    GoTo ExitHere
                End If
            Next
        Next
    End If
    
    On Error GoTo ExitHere
    LTime = Timer
    Debug.Print "[-] Time: " & LTime - stime & " s - Could not break password :("
    Call MsgBox("Could not detect password :(")
ExitHere:
    On Error Resume Next
    Application.ScreenUpdating = True
    Set ws = Nothing
    On Error GoTo 0
End Sub
```

## decimal to binary to decimal
binary to decimal
```vba
Function Bin2Dec(sMyBin As String) As Long
    Dim X As Integer
    Dim iLen As Integer

    iLen = Len(sMyBin) - 1
    For X = 0 To iLen
        Bin2Dec = Bin2Dec + _
          Mid(sMyBin, iLen - X + 1, 1) * 2 ^ X
    Next
End Function
```

decimal to binary
```vba
' The DecimalIn argument is limited to 79228162514264337593543950245
' (approximately 96-bits) - large numerical values must be entered
' as a String value to prevent conversion to scientific notation. Then
' optional NumberOfBits allows you to zero-fill the front of smaller
' values in order to return values up to a desired bit level.
Function Dec2Bin(ByVal DecimalIn As Variant, Optional NumberOfBits As Variant) As String
  Dec2Bin = ""
  DecimalIn = CDec(DecimalIn)
  Do While DecimalIn <> 0
    Dec2Bin = Trim$(str$(DecimalIn - 2 * Int(DecimalIn / 2))) & Dec2Bin
    DecimalIn = Int(DecimalIn / 2)
  Loop
  If Not IsMissing(NumberOfBits) Then
    If Len(Dec2Bin) > NumberOfBits Then
      Dec2Bin = "Error - Number too large for bit size"
    Else
      Dec2Bin = Right$(String$(NumberOfBits, "0") & Dec2Bin, NumberOfBits)
    End If
  End If
End Function
```


# CError
custom error handling class

```basic
Option Explicit

Private n As Long
Private s As String
Private D As String
Private l As Long
Private p As String

Public Property Get Number() As Long
    Number = n
End Property

Public Property Let Number(ByVal lNumber As Long)
    n = lNumber
End Property

Public Property Get Source() As String
    Source = s
End Property

Public Property Let Source(ByVal sSource As String)
    s = sSource
End Property

Public Property Get Description() As String
    Description = D
End Property

Public Property Let Description(ByVal sDescription As String)
    D = sDescription
End Property

Public Property Get Line() As Long
    Line = l
End Property

Public Property Let Line(ByVal lLine As Long)
    l = lLine
End Property

Public Property Get Procedure() As String
    Procedure = p
End Property

Public Property Let Procedure(ByVal sProcedure As String)
    p = sProcedure
End Property

Private Sub Class_Initialize()
    n = 0
    s = vbNullString
    D = vbNullString
    l = 0
    p = vbNullString
End Sub
```

# CExcelFunctions
custom class with most used functions

## code

### header
```vba
Option Explicit
'Class name: CExcelFunctions
'Author:     MBtech dx2tomek(8.8.2019)
'Version:    2.0 (29.8.2019)
'
'Description:
'Class wrapper for custom reusable functions for Excel VBA.
```

### global constants
```vba
'#<---------------------------------------------------------------------------------------------------------- global constants --->
Const CEXCELFUNCTIONS_DEBUG = False

Const name = "CExcelFunctions"
Const Author = "MBtech dx2tomek"
Const Version = "2.0"
Const CREATED = "8.8.2019"
Const LAST_EDIT = "29.8.2019"
Dim D As Object ' Class description
```

### global variables
```vba
'#<---------------------------------------------------------------------------------------------------------- global variables --->
Private timer_start As Double
Private timer_last As Double
Private timer_start_MS As Long
Private timer_last_MS As Long
Private ErrorAlreadyUsed As Boolean

Public Enum ModuleBackupState
    increment_version = 0
    replace_last = 1
    create_backup = 2
End Enum
```

### external libraries
```vba
'#<-------------------------------------------------------------------------------------------------------- external libraries --->
'https://bettersolutions.com/vba/macros/windows-api.htm
#If VBA7 Then
Private Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As LongPtr)
'http://allapi.mentalis.org/apilist/Sleep.shtml
Private Declare PtrSafe Function GetTickCount Lib "kernel32" () As LongPtr
'http://allapi.mentalis.org/apilist/GetTickCount.shtml, https://bettersolutions.com/vba/macros/windows-api-kernel32.htm
#Else
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function GetTickCount Lib "kernel32" () As Long
#End If
```

### class initialisation
```vba
'#<---------------------------------------------------------------------------------------------------------- class initialize --->
Private Sub Class_Initialize()
    On Error GoTo ExitHere
    ' Procedure initiates help dictionary that is called from help() function
    If CEXCELFUNCTIONS_DEBUG Then Call TimerStart
    
    Set D = CreateObject("Scripting.Dictionary")
    D("info") = Array("Class wrapper for custom reusable functions for Excel VBA.")
    D("log") = Array(Array("8.8.2019", "dx2tomek", "Class was created."), _
                     Array("8.8.2019", "dx2tomek", "Initial population of class by already made functions and procedures."), _
                     Array("9.8.2019", "dx2tomek", "Changed TimerStart from Property Get to Function."), _
                     Array("9.8.2019", "dx2tomek", "Added DeleteSheet procedure."), _
                     Array("9.8.2019", "dx2tomek", "Added GetUserName and GetUserProjectDir Properties, SleepMS procedure"), _
                     Array("14.8.2019", "dx2tomek", "Added RaiseError and DisplayError"), _
                     Array("20.8.2019", "dx2tomek", "Added GetModuleContent and GetActiveModule, ClearImmediateWindow"), _
                     Array("21.8.2019", "dx2tomek", "Added bDirExists, bFileExists, bFileExistsWild and CreateDir"), _
                     Array("21.8.2019", "dx2tomek", "Added ErrorHandling to all procedures and functions. quickSort modification - Optional arguments."), _
                     Array("21.8.2019", "dx2tomek", "Added GetAllModuleNames and GetModuleLineNo functions"), _
                     Array("22.8.2019", "dx2tomek", "Added BackupModules and BackupWorkbookVBProject, Enum ModuleBackupState"), _
                     Array("22.8.2019", "dx2tomek", "Added GetFilenameWithExt, GetFileNameWithoutExt, GetDirNameFromPathFilename, GetParentDirPathFromPath and GetDirNameFromPath"), _
                     Array("22.8.2019", "dx2tomek", "Added GetTicksMS, TimerStartMS, TimerLastMS and TimerTotalMS functions."), _
                     Array("22.8.2019", "dx2tomek", "Added pprint, arrayToString and rangeToString functions written by David Sery."), _
                     Array("22.8.2019", "dx2tomek", "Added wait_created option to CreateDir, changed its call in BackupModules"), _
                     Array("29.9.2019", "dx2tomek", "Changed help Property, added Parse_Module and Parse_Procedure, changed Error Handling to be dependent on CError class."))

    'Set d = SortDictionaryByKey(d)
    If CEXCELFUNCTIONS_DEBUG Then Debug.Print "CExcelFunctions Class Initialization took: " & TimerLast() & " seconds."
ExitHere:
    If Err.Number <> 0 Then Call RaiseError(Err.Number, Err.Source, "CExcelFunctions.Class_Initialize", Err.Description, Erl)
End Sub
```

### class termination
```vba
'#<----------------------------------------------------------------------------------------------------------- class terminate --->
Private Sub Class_Terminate()
    If ErrorAlreadyUsed Then
        Call DisplayError(Err.Source, Err.Description, "CExcelFunctions.Class_Terminate", Erl)
    End If
End Sub
```

### class properties
#### help
```vba
'#<---------------------------------------------------------------------------------------------------------- class properties --->
Public Property Get help(Optional ByVal FunctionName As String = vbNullString) As String
    '''Prints this message.
    Dim str As String
    Dim i As Long, j As Long
    Dim key As Variant, Keys As Variant
    
    Call Parse_Module(D, "CExcelFunctions")
    
    str = "Class name: " & name & vbCrLf
    str = str & "Author:     " & Author & "(" & CREATED & ")" & vbCrLf
    str = str & "Version:    " & Version & " (" & LAST_EDIT & ")" & vbCrLf
    
    str = str & vbCrLf & "Description: " & vbCrLf
    For i = LBound(D("info")) To UBound(D("info")) Step 1
        str = str & D("info")(i) & vbCrLf
    Next
    
    str = str & vbCrLf & "Log: " & vbCrLf
    For i = LBound(D("log")) To UBound(D("log")) Step 1
        str = str & Join(D("log")(i), " - ") & vbCrLf
    Next
    str = str & vbCrLf
    
    If FunctionName = vbNullString Then
        str = str & "Available Functions and Procedures:" & vbCrLf
        For Each key In D.Keys()
            If IsArray(D(key)) And key <> "info" And key <> "log" Then
                str = str & vbTab & D(key)(0) & vbCrLf
                For i = LBound(D(key)) + 1 To UBound(D(key)) Step 1
                    str = str & vbTab & vbTab & Replace(D(key)(i), vbCrLf, vbCrLf & vbTab & vbTab) & vbCrLf
                Next
            End If
        Next
    ElseIf IsIn(FunctionName, D.Keys()) Then
        key = FunctionName
        If IsArray(D(key)) And key <> "info" And key <> "log" Then
            str = str & D(key)(0) & vbCrLf
            For i = LBound(D(key)) + 1 To UBound(D(key)) Step 1
                str = str & vbTab & Replace(D(key)(i), vbCrLf, vbCrLf & vbTab) & vbCrLf
            Next
        End If
    Else
        str = "Error: " & FunctionName & " is not a name of any Function, Procedure or Property in this Class."
    End If
    help = str
End Property
```

#### parse module
```vba
Public Sub Parse_Module(ByRef dict As Object, Optional ByVal module_name As String = "CExcelFunctions")
    '''Parses module for Property, Function and Sub declaration, adds Array entries to the dictionary passed (name, declaration, comment starting with tripple '
    Dim CEF As New CExcelFunctions
    Dim mtext() As String
    Dim kwrds As Variant
    Dim i As Long
    Dim help As Object
    Dim fname As String
    Dim declaration As String
    Dim comment As String
    Dim str() As String
    
    On Error GoTo ExitHere
    
    mtext = GetModuleContent(ThisWorkbook, module_name)
    
    For i = LBound(mtext) To UBound(mtext) Step 1
        If mtext(i) Like "*Property ??? *(*" And InStr(1, mtext(i), "Private") = 0 And (InStr(1, mtext(i), Chr(34)) = 0 Or InStr(1, mtext(i), Chr(34)) > InStr(1, mtext(i), "Property")) Then
            str = Parse_Procedure(mtext, i, "Property")
            dict(str(0)) = str
        ElseIf mtext(i) Like "*Function *(*" And InStr(1, mtext(i), "Private") = 0 And (InStr(1, mtext(i), Chr(34)) = 0 Or InStr(1, mtext(i), Chr(34)) > InStr(1, mtext(i), "Function")) Then
            str = Parse_Procedure(mtext, i, "Function")
            dict(str(0)) = str
        ElseIf mtext(i) Like "*Sub *(*" And InStr(1, mtext(i), "Private") = 0 And (InStr(1, mtext(i), Chr(34)) = 0 Or InStr(1, mtext(i), Chr(34)) > InStr(1, mtext(i), "Sub")) Then
            str = Parse_Procedure(mtext, i, "Sub")
            dict(str(0)) = str
        End If
    Next
    Set dict = SortDictionaryByKey(D, xlAscending)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.Parse_Module"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### parse procedure
```vba
Public Function Parse_Procedure(ByRef module_text() As String, ByVal start_line As Long, ByVal procedure_type As String) As String()
    '''Parses procedure starting at start_line in module_text Array
    Dim fname As String
    Dim declaration As String
    Dim comment As String
    Dim retVal(2) As String
    Dim i As Long
    
    On Error GoTo ExitHere
    
    fname = Split(module_text(start_line), "(")(0)
    fname = Mid(fname, InStrRev(fname, " ") + 1)
    
    declaration = module_text(start_line)
    For i = start_line + 1 To UBound(module_text)
        If InStr(1, module_text(i), "End " & procedure_type) <> 0 Then Exit For
        If Right(RTrim(module_text(i - 1)), 1) = "_" Then
            declaration = Replace(declaration, " _", " " & LTrim(module_text(i)))
        Else
            Exit For
        End If
    Next
    If InStr(1, declaration, " '") <> 0 Then
        declaration = RTrim(Split(declaration, " '")(0))
    End If
    
    comment = ""
    For i = start_line + 1 To UBound(module_text)
        If InStr(1, module_text(i), "End " & procedure_type) <> 0 Then Exit For
        If left(LTrim(module_text(i)), 3) = "'''" Then
            comment = comment & Mid(LTrim(module_text(i)), 4) & vbCrLf
        End If
    Next
    If Len(comment) > 0 Then comment = left(comment, Len(comment) - Len(vbCrLf))
    
    retVal(0) = fname
    retVal(1) = declaration
    retVal(2) = comment
    Parse_Procedure = retVal
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.Parse_Procedure"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### TimerStart
```vba
Public Function TimerStart() As Double
    '''Starts a timer and sets last_time = start_time, returns current time in s
    timer_start = Timer()
    timer_last = timer_start
    TimerStart = timer_start
End Function
```

#### TimerLast
```vba
Public Property Get TimerLast() As Double
    '''Returns time from last measurement or TimerStart. Needs TimerStart to run first. Rewrites last_time to new time.
    Dim t As Double
    t = Timer()
    TimerLast = t - timer_last
    timer_last = t
End Property
```

#### TimerTotal
```vba
Public Property Get TimerTotal() As Double
    '''Returns time from TimerStart. Needs TimerStart to run first. Rewrites last_time to new time.
    timer_last = Timer()
    TimerTotal = timer_last - timer_start
End Property
```

#### GetUserName
```vba
Public Property Get GetUserName() As String
    '''Returns username login from Windows.
    GetUserName = Environ("UserName")
End Property
```

#### GetUserProjectDir
```vba
Public Property Get GetUserProjectDir() As String
    '''Returns project directory path of the user currently logged in.
    GetUserProjectDir = "z:\misc\MBtech\user\" & Me.GetUserName
End Property
```

### functions and procedures
#### PickFile
```vba
'#<-------------------------------------------------------------------------------------------------- functions and procedures --->
Public Function PickFile(Optional ByVal initdir As String = "", Optional ByVal filter_array As Variant = Nothing, _
                         Optional ByVal title As String = "Pick a file:") As String 'Pick a File
    '''Function wrapper for FileDialogFilePicker,
    '''Filter arrray = e.g. Array("*.res", "*.pro", "*.txt").
    On Error GoTo ExitHere
    Dim fldr As FileDialog
    Dim sItem As String
    Dim fltr As Variant
    If Not IsArray(filter_array) Then filter_array = Array("*.*")
    Set fldr = Application.FileDialog(msoFileDialogFilePicker)
    With fldr
        .title = title
        .AllowMultiSelect = False
        .Filters.Clear
        For Each fltr In filter_array
            .Filters.Add UCase(Replace(Split(CStr(fltr), ".")(1), "*", "ANY")) & " file", CStr(fltr)
        Next
        If initdir = "" Then
            .InitialFileName = Application.DefaultFilePath
        Else
            .InitialFileName = initdir
        End If
        If .Show <> -1 Then GoTo ExitHere
        sItem = .SelectedItems(1)
    End With
    PickFile = sItem
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.PickFile"
    On Error Resume Next
        Set fltr = Nothing
        Set fldr = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetFiles
```vba
Public Function GetFiles(ByVal initdir As String, Optional ByVal filter_array As Variant = Nothing) As String()
    '''Function to get all files that satisfy a filter_array criteria.,
    '''Filter arrray = e.g. Array("*.res", "*.pro", "*.txt").
    On Error GoTo ExitHere
    Dim filename As String
    Dim files() As String
    Dim i As Long
    
    If Right$(initdir, 1) <> "\" Then initdir = initdir & "\"
    
    If Not IsArray(filter_array) Then filter_array = Array("*.*")
    filename = Dir$(initdir, vbNormal)
    i = -1
    Do While filename <> ""
        If bFileFilter(filename, filter_array) Then
            i = i + 1
            ReDim Preserve files(i)
            files(i) = filename
        End If
        filename = Dir$
    Loop
    GetFiles = files
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetFiles"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### bFileFilter
```vba
Public Function bFileFilter(ByVal filename As String, Optional ByVal filter_array As Variant = Nothing) As Boolean
    '''Function to check if the extension of a file satisfies preset filter.
    '''Filter arrray = e.g. Array("*.res", "*.pro", "*.txt").
    Dim i As Long
    On Error GoTo ExitHere
    If Not IsArray(filter_array) Then filter_array = Array("*.*")
    bFileFilter = False
    For i = LBound(filter_array) To UBound(filter_array) Step 1
        If filename Like filter_array(i) Then
            bFileFilter = True
            Exit Function
        End If
    Next
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.bFileFilter"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### PickDir
```vba
Public Function PickDir(Optional ByVal initdir As String = "", Optional ByVal title As String = "Pick a directory:") As String
    '''Function wrapper for FileDialogFolderPicker
    Dim fldr As FileDialog
    Dim sItem As String
    On Error GoTo ExitHere
    Set fldr = Application.FileDialog(msoFileDialogFolderPicker)
    With fldr
        .title = title
        .AllowMultiSelect = False
        If initdir = "" Then
            .InitialFileName = Application.DefaultFilePath
        Else
            .InitialFileName = initdir
        End If
        If .Show <> -1 Then GoTo ExitHere
        sItem = .SelectedItems(1)
    End With
    PickDir = sItem
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.PickDir"
    On Error Resume Next
        Set fldr = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetSubDirs
```vba
Public Function GetSubDirs(ByVal directory As String) As String()
    '''Function to get all subdirectories of a directory
    Dim objFSO As Object
    Dim objFolders As Object
    Dim objFolder As Object
    
    Dim arrFolders() As String
    Dim FolderCount As Long
    Dim i As Long
    
    On Error GoTo ExitHere
    
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objFolders = objFSO.GetFolder(directory).SubFolders
    
    FolderCount = objFolders.Count
    
    If FolderCount > 0 Then
        ReDim arrFolders(0 To FolderCount - 1)
        i = -1
        For Each objFolder In objFolders
            i = i + 1
            arrFolders(i) = objFolder.name
        Next objFolder
    End If
    
    GetSubDirs = arrFolders
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetSubDirs"
    On Error Resume Next
        Set objFolder = Nothing
        Set objFolders = Nothing
        Set objFSO = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### SaveFileAs
```vba
Public Function SaveFileAs(Optional ByVal initdir As String = "", Optional ByVal filter_array As Variant = Nothing, _
                           Optional ByVal title As String = "Save File As:") As String
    '''Function wrapper for SaveFileAs FileDialog.
    Dim varResult As Variant
    Dim filter As String
    Dim fltr As Variant
    On Error GoTo ExitHere
    If Not IsArray(filter_array) Then filter_array = Array("*.*")
    filter = ""
    For Each fltr In filter_array
        filter = filter & UCase(Replace(Split(CStr(fltr), ".")(1), "*", "ANY")) & " file (" & fltr & ")," & CStr(fltr) & ","
    Next
    filter = left$(filter, Len(filter) - 1)
    varResult = Application.GetSaveAsFilename(initdir, filter, 1, title)
    If varResult = False Then
        SaveFileAs = ""
    Else
        SaveFileAs = varResult
    End If
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.SaveFileAs"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### SaveFile
```vba
Public Sub SaveFile(ByVal filename As String, ByVal txt As String, Optional ByVal open_in_notepad As Boolean = False)
    '''Saves a string to a file, overwrites it if it exists. filename has to contain full path.
    Dim FileNum As Long
    Dim lRetVal As Long
    
    On Error GoTo ExitHere
    
    FileNum = FreeFile()
    Open filename For Output As #FileNum
        Print #FileNum, txt;  ' write in data, file is for linux -> no carriage return
    Close #FileNum
    
    If open_in_notepad Then lRetVal = Shell("C:\WINDOWS\notepad.exe " & filename, 1)
    
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.SaveFile"
    On Error Resume Next
    Close #FileNum
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### ExportChart
```vba
Public Sub ExportChart(ByRef objCht As Chart, ByVal filename As String)
    '''Exports chart as a *.png file, the filename is overwritten. filename must contain full path.
    On Error Resume Next
    Kill filename
    Err.Clear
    On Error GoTo ExitHere
    objCht.Export filename:=filename, Filtername:=Mid$(filename, InStrRev(filename, ".") + 1)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.ExportChart"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### quickSort
```vba
Public Sub quickSort(vArray As Variant, Optional inLow As Long = -999, Optional inHi As Long = -999)
    '''Quick Sort procedure that works on vArray.
    Dim pivot   As Variant
    Dim tmpSwap As Variant
    Dim tmpLow  As Long
    Dim tmpHi   As Long
    
    On Error GoTo ExitHere
    If inLow = -999 Then inLow = LBound(vArray)
    If inHi = -999 Then inHi = UBound(vArray)
    
    tmpLow = inLow
    tmpHi = inHi
    
    pivot = vArray((inLow + inHi) \ 2)

    While (tmpLow <= tmpHi)
    While (vArray(tmpLow) < pivot And tmpLow < inHi)
        tmpLow = tmpLow + 1
    Wend
    
    While (pivot < vArray(tmpHi) And tmpHi > inLow)
        tmpHi = tmpHi - 1
    Wend
    
    If (tmpLow <= tmpHi) Then
        tmpSwap = vArray(tmpLow)
        vArray(tmpLow) = vArray(tmpHi)
        vArray(tmpHi) = tmpSwap
        tmpLow = tmpLow + 1
        tmpHi = tmpHi - 1
    End If
    Wend
    
    If (inLow < tmpHi) Then quickSort vArray, inLow, tmpHi
    If (tmpLow < inHi) Then quickSort vArray, tmpLow, inHi
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.quickSort"
    On Error Resume Next
        Set tmpSwap = Nothing
        Set pivot = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### SortDictionaryByKey
```vba
Public Function SortDictionaryByKey(ByRef dict As Object, Optional sortorder As XlSortOrder = xlAscending) As Object
    '''Sorts a created dictionary by key value. XlSortOrder = xlAscending/xlDescending.
    Dim arrList As Object
    
    On Error GoTo ExitHere
    
    Set arrList = CreateObject("System.Collections.ArrayList")
    
    ' Put keys in an ArrayList
    Dim key As Variant, coll As New Collection
    For Each key In dict
        arrList.Add key
    Next key
    
    ' Sort the keys
    arrList.Sort
    
    ' For descending order, reverse
    If sortorder = xlDescending Then
        arrList.Reverse
    End If
    
    ' Create new dictionary
    Dim dictNew As Object
    Set dictNew = CreateObject("Scripting.Dictionary")
    
    ' Read through the sorted keys and add to new dictionary
    For Each key In arrList
        dictNew.Add key, dict(key)
    Next key
    
    ' Clean up
'    Set arrList = Nothing
'    Set dict = Nothing
    
    ' Return the new dictionary
    Set SortDictionaryByKey = dictNew
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.SortDictionaryByKey"
    On Error Resume Next
        Set dict = Nothing
        Set arrList = Nothing
        Set dictNew = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetColumn
```vba
Public Function GetColumn(ByRef arr As Variant, ByVal col As Long) As Variant()
    '''Returns a new array of just one column from arr, dimensions: (1 to n, 1 to 1)
    Dim tmp() As Variant
    Dim i As Long, j As Long
    
    On Error GoTo ExitHere
    
    ReDim tmp(1 To UBound(arr) - LBound(arr) + 1, 1 To 1)
    j = 1
    For i = LBound(arr) To UBound(arr)
        tmp(j, 1) = arr(i, col)
        j = j + 1
    Next
    
    GetColumn = tmp
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetColumn"
    On Error Resume Next
        ReDim tmp(0)
        Set tmp(0) = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetRow
```vba
Public Function GetRow(ByRef arr As Variant, ByVal row As Long) As Variant()
    '''Returns a new array of just one row from arr, dimensions: (1 to 1, 1 to n)
    Dim tmp() As Variant
    Dim i As Long, j As Long
    
    On Error GoTo ExitHere
    
    ReDim tmp(1 To 1, 1 To UBound(arr, 2) - LBound(arr, 2) + 1)
    j = 1
    For i = LBound(arr, 2) To UBound(arr, 2)
        tmp(1, j) = arr(row, j)
        j = j + 1
    Next
    
    GetRow = tmp
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetRow"
    On Error Resume Next
        ReDim tmp(0)
        Set tmp(0) = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### bWorksheetExists
```vba
Public Function bWorksheetExists(ByVal wsname As String, Optional ByRef wb As Workbook = Nothing) As Boolean
    '''Tests whether a Worksheet by wsname exists in Workbook wb. Default wb is ActiveWorkbook. Returns Boolean.
    If wb Is Nothing Then Set wb = ActiveWorkbook
    On Error Resume Next
    If Len(wb.Sheets(wsname).name) = 0 Then
        bWorksheetExists = False
    Else
        bWorksheetExists = True
    End If
    Err.Clear
    On Error GoTo 0
End Function
```

#### IsIn
```vba
Public Function IsIn(ByRef valToCheck As Variant, ByRef valuesArray As Variant) As Boolean
    '''Tests whether a value is present in a one-dimensional array. Returns True.
    On Error GoTo ExitHere
    IsIn = Not InStr("*-" & Join(valuesArray, "-*-") & "-*", "*-" & valToCheck & "-*") = 0
ExitHere:
    On Error GoTo 0
End Function
```

#### RemoveDuplicates
```vba
Public Function RemoveDuplicates(ByRef data As Variant, ParamArray columns()) As Variant
    '''Function to remove duplicates from a two dimensional array, variable columns specifies the column numbers to look into.
    Dim ret(), indexes(), ids(), r As Long, c As Long
    Dim dict As Object
    
    On Error GoTo ExitHere
    
    Set dict = CreateObject("Scripting.Dictionary")
    
    If VarType(data) And vbArray Then Else Err.Raise 5, , "Argument data is not an array"

    ReDim ids(LBound(columns) To UBound(columns))

    For r = LBound(data) To UBound(data)         ' each row '
        For c = LBound(columns) To UBound(columns)   ' each column '
            ids(c) = data(r, columns(c))                ' build id for the row
        Next
        dict(Join$(ids, ChrW(-1))) = r  ' associate the row index to the id '
    Next

    indexes = dict.Items()
    ReDim ret(LBound(data) To LBound(data) + dict.Count - 1, LBound(data, 2) To UBound(data, 2))

    For c = LBound(ret, 2) To UBound(ret, 2)  ' each column '
        For r = LBound(ret) To UBound(ret)      ' each row / unique id '
            ret(r, c) = data(indexes(r - 1), c)   ' copy the value at index '
        Next
    Next

    RemoveDuplicates = ret
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.RemoveDuplicates"
    On Error Resume Next
        Set data = Nothing
        Set dict = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### AlignRight
```vba
Public Function AlignRight(ByVal str As String, ByVal FieldLen As Integer) As String
    '''Aligns a string to the Right, prepending spaces. If Len(str) > FieldLen, Error.
    Dim StrLen As Integer
    Dim Packer As String
    On Error GoTo ExitHere
    StrLen = Len(Trim(str))
    Packer = String(FieldLen - StrLen, " ")
    AlignRight = Packer & Trim(str)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.AlignRight"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### AlignLeft
```vba
Public Function AlignLeft(ByVal str As String, ByVal FieldLen As Integer) As String
    '''Aligns a string to the Left, appending spaces. If Len(str) > FieldLen, Error.
    Dim StrLen As Integer
    Dim Packer As String
    On Error GoTo ExitHere
    StrLen = Len(Trim(str))
    Packer = String(FieldLen - StrLen, " ")
    AlignLeft = Trim(str) & Packer
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.AlignLeft"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### AlignJust
```vba
Public Function AlignJust(ByVal str As String, ByVal FieldLen As Integer) As String
    '''Justifies string, adding spaces. If Len(str) > FieldLen, Error.
    Dim StrLen As Integer
    Dim PackerLeft As String
    Dim PackerRight As String
    On Error GoTo ExitHere
    StrLen = Len(Trim(str))
    PackerLeft = String(Application.WorksheetFunction.RoundUp((FieldLen - StrLen) / 2, 1#), " ")
    PackerRight = String(FieldLen - StrLen - Len(PackerLeft), " ")
    AlignJust = PackerLeft & Trim(str) & PackerRight
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.AlignJust"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### RoundBase2
```vba
Public Function RoundBase2(ByRef n As Double) As Long
    '''Rounds a number up to the closest 2^n integer. => 1 = 1, 2 = 2, 3 = 4, 5 = 8, 9 = 16
    On Error GoTo ExitHere
    RoundBase2 = CLng(2 ^ Application.WorksheetFunction.RoundUp(log(n) / log(2), 0))
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.RoundBase2"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### VBALinEst
```vba
Public Function VBALinEst(ByRef arrY() As Double, ByRef arrX() As Double, Optional ByVal order As Long = 6) As Variant
    '''Linear regression of nth order. Data lines in rows.
    Dim curve() As Double
    Dim constants As Variant
    Dim i As Long, j As Long
    Dim retVal() As Double
    
    Dim tmp As Variant
    Dim X() As Variant
    
    On Error GoTo ExitHere
    
    tmp = GetRow(arrX, 1)
    
    ReDim Preserve X(1 To order, LBound(tmp, 2) To UBound(tmp, 2))
    For i = 1 To order Step 1
        For j = LBound(tmp, 2) To UBound(tmp, 2) Step 1
            X(i, j) = tmp(1, j) ^ i
        Next
    Next
    constants = Application.WorksheetFunction.LinEst(arrY, X, True, False)
    ReDim retVal(1 To 1, LBound(tmp, 2) To UBound(tmp, 2))
    For j = LBound(tmp, 2) To UBound(tmp, 2)
        retVal(1, j) = 0
        For i = 1 To order + 1 Step 1
            retVal(1, j) = retVal(1, j) + constants(i) * X(1, j) ^ (order + 1 - i)
        Next
    Next
    
    VBALinEst = retVal
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.VBALinEst"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetTXTContentUNIX
```vba
Public Function GetTXTContentUNIX(ByVal txtfile As String) As String()
    '''Read in a txt file in UNIX format (no carriage return) an return an array of lines.
    Dim FileNum As Long
    Dim text As String
    Dim Line() As String
    
    On Error GoTo ExitHere
    
    FileNum = FreeFile()
    Open txtfile For Input As #FileNum
    Input #FileNum, text  ' read in data, file is from linux -> no carriage return
    Close #FileNum
    
    Line = Split(text, vbLf)
    GetTXTContentUNIX = Line
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetTXTContentUNIX"
    On Error Resume Next
    Close #FileNum
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetTXTContentWIN
```vba
Public Function GetTXTContentWIN(ByVal txtfile As String) As String()
    '''Read in a txt file in WIN format (with carriage return) an return an array of lines.
    Dim FileNum As Long
    Dim text As String
    Dim Line() As String
    
    On Error GoTo ExitHere
    
    FileNum = FreeFile()
    Open txtfile For Input As #FileNum
    Input #FileNum, text  ' read in data
    Close #FileNum
    
    Line = Split(text, vbCrLf)
    GetTXTContentWIN = Line
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetTXTContentWIN"
    On Error Resume Next
    Close #FileNum
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### StripLines
```vba
Public Function StripLines(ByVal lines As Variant) As String()
    '''Strips lines that are empty or contain just empty characters.
    Dim newlines() As String
    Dim tmp As String
    Dim i As Long, j As Long
    Dim nlines As Long
    Dim empty_chars As Variant
    empty_chars = Array("", " ", vbNullString, vbTab)
    
    On Error GoTo ExitHere
    ReDim newlines(LBound(lines) To UBound(lines))
    j = LBound(lines) - 1
    For i = LBound(lines) To UBound(lines)
        tmp = lines(i)
        Do While InStr(1, tmp, "  ") > 0
            tmp = Replace(tmp, "  ", " ")
        Loop
        'If Not (tmp = " " Or tmp = vbNullString Or tmp = vbTab) Then
        If Not IsIn(tmp, empty_chars) Then
            j = j + 1
            newlines(j) = lines(i)
        End If
    Next
    ReDim Preserve newlines(LBound(lines) To j)
    StripLines = newlines
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.StripLines"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### StripSpaces
```vba
Public Function StripSpaces(ByVal str As String) As String
    '''Replaces all multispaces in string with single spaces.
    On Error GoTo ExitHere
    Do While InStr(1, str, "  ") > 0
        str = Replace$(str, "  ", " ")
    Loop
    StripSpaces = Trim$(str)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.StripSpaces"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### ClearChart
```vba
Public Sub ClearChart(ByRef cht As Chart)
    '''Clears all series in a Chart.
    Dim i As Long
    On Error GoTo ExitHere
    For i = cht.FullSeriesCollection.Count To 1 Step -1
        cht.FullSeriesCollection(i).Delete
    Next
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.ClearChart"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### WorkStart
```vba
Public Sub WorkStart()
    '''Sets ScreenUpdating, EnableEvents and EnableAnimations to False, Calculation to xlCalculationManual.
    On Error GoTo ExitHere
    With Application
        .ScreenUpdating = False
        .EnableAnimations = False
        .EnableEvents = False
        .Calculation = xlCalculationManual
    End With
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.WorkStart"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### WorkStop
```vba
Public Sub WorkStop()
    '''Sets ScreenUpdating, EnableEvents and EnableAnimations to True, Calculation to xlCalculationAutomatic.
    On Error GoTo ExitHere
    With Application
        .ScreenUpdating = True
        .EnableAnimations = True
        .EnableEvents = True
        .Calculation = xlCalculationAutomatic
    End With
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.WorkStop"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### DeleteSheet
```vba
Public Sub DeleteSheet(ByRef wb As Workbook, ByVal shname As String)
    '''Deletes Sheet shname from Workbook wb if it exists.
    On Error GoTo ExitHere
    If bWorksheetExists(shname, wb) Then
        Application.DisplayAlerts = False
        wb.Sheets(shname).Delete
        Application.DisplayAlerts = True
    End If
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.DeleteSheet"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### SleepMS
```vba
Public Sub SleepMS(ByVal miliseconds As Long)
    '''Wrapper for kernel32.dll function Sleep, the running process is paused for specified time.
    On Error GoTo ExitHere
    Call Sleep(miliseconds)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.SleepMS"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### PolyInterpolate
```vba
Public Function PolyInterpolate(ByRef arrX() As Double, ByRef arrY() As Double, ByVal X As Double) As Double
    '''Polynomial interpolation of nth order, where n is the dimension of arrX and arrY - 1, arrX = X values (column array), arrY = Y values (column array), X = point to interpolate at.
    Dim mult As Double
    Dim retVal As Double
    Dim i As Long, j As Long
    On Error GoTo ExitHere
    retVal = 0#
    For i = LBound(arrY) To UBound(arrY) Step 1
        mult = 1#
        For j = LBound(arrY) To UBound(arrY) Step 1
            If i <> j Then
                mult = retVal * (X - arrX(j)) / (arrX(i) - arrX(j))
            End If
        Next
        retVal = retVal + mult * arrY(i)
    Next
    PolyInterpolate = retVal
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.PolyInterpolate"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### PolyInterpolateArray
```vba
Public Function PolyInterpolateArray(ByRef arrX As Variant, ByRef arrY As Variant, ByVal srow As Long, ByVal lrow As Long, ByVal X As Double) As Double
    '''Polynomial interpolation of (lrow - srow) - 1 order, where arrX and arrY are arrays of values (column array), srow and lrow limit the interpolation range and X = point to interpolate at.
    Dim mult As Double
    Dim retVal As Double
    Dim i As Long, j As Long
    On Error GoTo ExitHere
    retVal = 0#
    For i = srow To lrow Step 1
        mult = 1#
        For j = srow To lrow Step 1
            If i <> j Then
                mult = mult * (X - CDbl(arrX(j, 1))) / (CDbl(arrX(i, 1)) - CDbl(arrX(j, 1)))
            End If
        Next
        retVal = retVal + mult * CDbl(arrY(i, 1))
    Next
    PolyInterpolateArray = retVal
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.PolyInterpolateArray"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### RaiseError
```vba
Public Sub RaiseError(ByVal errorNo As Long, ByVal src As String, ByVal proc As String, ByVal desc As String, ByVal lineNo As Long)
    '''Reraises an error and adds line number and current procedure name.
    '''From: https://excelmacromastery.com/vba-error-handling/
    Dim sSource As String
    ' If called for the first time then add line number
    If ErrorAlreadyUsed = False Then
        ' Add error line number if present
        If lineNo <> 0 Then
            sSource = vbNewLine & "Line N°: " & lineNo & " "
        End If
        ' Add procedure to source
        sSource = sSource & vbNewLine & proc
        ErrorAlreadyUsed = True
    Else
        ' If error has already been raised simply add on procedure name
        sSource = src & vbNewLine & proc
    End If
    ' Pause the code here when debugging
    '(To Debug: "Tools->VBA Properties" from the menu.
    ' Add "Debugging=1" to the     ' "Conditional Compilation Arguments.)
#If Debugging = 1 Then
    Debug.Assert False
#End If
    ' Reraise the error so it will be caught in the caller procedure
    ' (Note: If the code stops here, make sure DisplayError has been
    ' placed in the topmost procedure)
    Err.Raise errorNo, sSource, desc
End Sub
```

#### DisplayError
```vba
' Displays the error when it reaches the topmost sub
' Note: You can add a call to logging from this sub
Public Sub DisplayError(ByVal src As String, ByVal desc As String, ByVal sProcname As String, lineNo As Long)
    '''Displays the error when it reaches the topmost sub.
    '''From: https://excelmacromastery.com/vba-error-handling/
    ' Check If the error happens in topmost sub
    If ErrorAlreadyUsed = False Then
        ' Reset string to remove "VBAProject" and add line number if it exists
        src = IIf(lineNo = 0, "", vbNewLine & "Line N°: " & lineNo)
    End If
    ' Build the final message
    Dim sMsg As String
    sMsg = "The following error occurred: " & vbNewLine & Err.Description & vbNewLine & vbNewLine & "Error Location is: "
    sMsg = sMsg & src & vbNewLine & sProcname
    ' Display the message
    MsgBox sMsg, title:="Error", Buttons:=vbCritical
    ' reset the boolean value
    ErrorAlreadyUsed = False
End Sub
```

#### GetModuleContent
```vba
Public Function GetModuleContent(ByRef wb As Workbook, ByVal moduleName As String) As String()
    '''Function that returns an array of lines of the selected module from the given workbook. Needs: Options->Trust Center->Trust Center Settings->Macro Settings->Trust access to the VBA project object model: "YES"
    Dim strModule As Variant
    On Error GoTo ExitHere
    With wb.VBProject.VBComponents(moduleName).CodeModule
        strModule = Split(.lines(1, .CountOfLines), vbCrLf)
    End With
    GetModuleContent = strModule
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetModuleContent"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetActiveModule
```vba
Public Function GetActiveModule() As String
    '''Function returns the name of the currently opened module in VB Editor. Needs: Options->Trust Center->Trust Center Settings->Macro Settings->Trust access to the VBA project object model: "YES"
    On Error GoTo ExitHere
    GetActiveModule = Application.VBE.ActiveCodePane.CodeModule.name
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetActiveModule"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### ClearImmediateWindow
```vba
Public Sub ClearImmediateWindow()
    '''Clears Immediate Window. Use with caution as it utilises Application.SendKeys.
    On Error GoTo ExitHere
    Application.VBE.Windows("Immediate").SetFocus
    Application.SendKeys "^g ^a {DEL}"
    DoEvents
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.ClearImmediateWindow"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### bDirExists
```vba
Public Function bDirExists(ByVal directory As String) As Boolean
    '''Checks if a directory exists.
    Dim oFSO As Object
    On Error GoTo ExitHere
    Set oFSO = CreateObject("Scripting.FileSystemObject")
    bDirExists = oFSO.FolderExists(directory)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.bDirExists"
    On Error Resume Next
        Set oFSO = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### bFileExists
```vba
Public Function bFileExists(ByVal filename As String) As Boolean
    '''Checks if a file exists.
    Dim oFSO As Object
    On Error GoTo ExitHere
    Set oFSO = CreateObject("Scripting.FileSystemObject")
    bFileExists = oFSO.FileExists(filename)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.bFileExists"
    On Error Resume Next
        Set oFSO = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### bFileExistsWild
```vba
Public Function bFileExistsWild(ByVal directory As String, ByVal filename As String) As Boolean
     '''Checks if a file exists, supports wildcard characters. *?~
    On Error GoTo ExitHere
    If Right(directory, 1) <> "\" Then directory = directory & "\"
    If left(filename, 1) = "\" Then filename = Mid$(filename, 2)
    bFileExistsWild = (Dir$(directory & filename, vbNormal) <> "")
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.bFileExistsWild"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### CreateDir
```vba
Public Function CreateDir(ByVal directory As String, ByVal dirname As String, Optional ByVal wait_created As Boolean = False) As Boolean
    '''Creates a directory in specified path and returns True if successful.
    On Error GoTo ExitHere
    If Not bDirExists(directory) Then GoTo ExitHere
    If Right(directory, 1) <> "\" Then directory = directory & "\"
    MkDir directory & dirname
    If wait_created Then
        Do While Not bDirExists(directory & dirname)
            Call SleepMS(10)
        Loop
    End If
    CreateDir = bDirExists(directory & dirname)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.CreateDir"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetAllModuleNames
```vba
Public Function GetAllModuleNames(ByRef wb As Workbook) As String()
    '''Function to get all class, module and form names in specified workbook.
    Dim module As Variant
    Dim strModule() As String
    Dim i As Long
    On Error GoTo ExitHere
    i = 0
    For Each module In wb.VBProject.VBComponents
        If module.Type <> 100 Then
            ReDim Preserve strModule(0 To i)
            strModule(i) = module.name
            i = i + 1
        End If
    Next
    GetAllModuleNames = strModule
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetAllModuleNames"
    On Error Resume Next
        Set module = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetModuleLineNo
```vba
Public Function GetModuleLineNo(ByRef wb As Workbook, ByVal moduleName As String) As Long
    '''Returns number of lines of specified module in specified workbook.
    Dim lngModule As Long
    On Error GoTo ExitHere
    With wb.VBProject.VBComponents(moduleName).CodeModule
        lngModule = .CountOfLines
    End With
    GetModuleLineNo = lngModule
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetModuleLineNo"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### BackupModules
```vba
Public Sub BackupModules(ByRef wb As Workbook, Optional ByVal directory As String = "", Optional module_backup As ModuleBackupState = ModuleBackupState.increment_version)
    '''Procedure to save all VBA files in specified Workbook.
    Dim bExport As Boolean
    Dim szSourceWorkbook As String
    Dim szExportPath As String
    Dim szFileName As String
    Dim szExt As String
    Dim cmpComponent As Variant ' VBIDE.VBComponent
    Dim bckpDir As String
    Dim fls() As String
    Dim i As Long

    On Error GoTo ExitHere
    If directory = "" Then directory = PickDir("Z:\misc\MBtech\user\" & Environ("USERNAME") & "\", "Pick Directory for modules and classes backup.")
    If directory = "" Then GoTo ExitHere

    '''NOTE: This workbook must be opened in Excel.
    szSourceWorkbook = wb.name
    
    If wb.VBProject.Protection = 1 Then
        MsgBox "The VBA in this workbook is protected," & vbCrLf & _
               "not possible to export the code.", vbCritical
        Exit Sub
    End If

    szExportPath = directory & "\"
    
    For Each cmpComponent In wb.VBProject.VBComponents
        
        bExport = True
        szFileName = cmpComponent.name

        'Concatenate the correct filename for export.
        Select Case cmpComponent.Type
            Case 1 'vbext_ct_StdModule
                szExt = ".bas"
                bckpDir = "module"
            Case 2 'vbext_ct_ClassModule
                szExt = ".cls"
                bckpDir = "class"
            Case 3 'vbext_ct_MSForm
                szExt = ".frm"
                bckpDir = "form"
            Case Else 'vbext_ct_Document
                szExt = ".bas"
                bckpDir = "document"
                bExport = False
        End Select
        
        If Not bDirExists(szExportPath & bckpDir) Then
            Call CreateDir(szExportPath, bckpDir, True)
        End If
        If bFileExistsWild(szExportPath & bckpDir, szFileName & "*" & szExt) Then
            fls = GetFiles(szExportPath & bckpDir, Array(szFileName & "*" & szExt))
            Call quickSort(fls)
            Select Case module_backup
            Case ModuleBackupState.increment_version
                If szFileName <> Replace(fls(UBound(fls)), szExt, vbNullString) Then
                    szFileName = Replace(fls(UBound(fls)), szExt, vbNullString)
                    szFileName = left(szFileName, InStrRev(szFileName, "_")) & CLng(Mid(szFileName, InStrRev(szFileName, "_") + 1)) + 1
                Else
                    szFileName = szFileName & "_v_1_0"
                End If
            Case ModuleBackupState.replace_last
                If szFileName <> Replace(fls(UBound(fls)), szExt, vbNullString) Then
                    szFileName = Replace(fls(UBound(fls)), szExt, vbNullString)
                End If
                Kill szExportPath & bckpDir & "\" & szFileName & szExt
            Case ModuleBackupState.create_backup
                If szFileName <> Replace(fls(UBound(fls)), szExt, vbNullString) Then
                    szFileName = Replace(fls(UBound(fls)), szExt, vbNullString)
                End If
                fls = GetFiles(szExportPath & bckpDir, Array(szFileName & szExt & ".*"))
                If Len(Join(fls)) > 0 Then
                    Call quickSort(fls)
                    i = CLng(Mid(fls(UBound(fls)), InStrRev(fls(UBound(fls)), ".") + 1)) + 1
                Else
                    i = 0
                End If
                Name szExportPath & bckpDir & "\" & szFileName & szExt As szExportPath & bckpDir & "\" & szFileName & szExt & "." & Format(i, String(Application.WorksheetFunction.Max(Len(CStr(i)), 3), "0"))
            End Select
        End If
        
        'Export the component to a text file.
        If bExport Then
            Call cmpComponent.Export(szExportPath & bckpDir & "\" & szFileName & szExt)
            
        'remove it from the project if you want
        'Call wkbSource.VBProject.VBComponents.Remove(cmpComponent)
        Else
            If cmpComponent.CodeModule.CountOfLines > 2 Then Call SaveFile(szExportPath & bckpDir & "\" & szFileName & szExt, cmpComponent.CodeModule.lines(1, cmpComponent.CodeModule.CountOfLines), True)
        End If
   
    Next cmpComponent

    'Debug.Print "Export finished."
    
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.BackupModules"
    On Error Resume Next
        Set cmpComponent = Nothing
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### BackupWorkbookVBProject
```vba
Public Sub BackupWorkbookVBProject(ByRef wb As Workbook, Optional ByVal backup_folder As String = "backup")
    '''Saves all of VBA Project in Specified Workbook as new files, old files are renamed, not overwritten.
    Dim strPath As String
    Dim strDir As String
    On Error GoTo ExitHere
    If wb.path = "" Then
        strPath = PickDir("", "Pick a directory for VBA Project backup")
    Else
        strPath = wb.path & "\" & backup_folder
        If Not bDirExists(strPath) Then
            Call CreateDir(wb.path, backup_folder, True)
        End If
    End If
    strDir = left(wb.name, InStrRev(wb.name, ".") - 1)
    If Not bDirExists(strPath & "\" & strDir) Then
        Call CreateDir(strPath, strDir, True)
    End If
    Call BackupModules(wb, strPath & "\" & strDir, ModuleBackupState.create_backup)
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.BackupWorkbookVBProject"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Sub
```

#### GetFileNameWithExt
```vba
Public Function GetFileNameWithExt(ByVal path As String) As String
    '''Return filename with extension from complete path.
    Dim pos As Integer
    On Error GoTo ExitHere
    pos = InStrRev(path, "\")
    If pos > 0 Then
        GetFileNameWithExt = Mid$(path, pos + 1, Len(path))
    Else
        GetFileNameWithExt = ""
    End If
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetFileNameWithExt"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetFileNameWithoutExt
```vba
Public Function GetFileNameWithoutExt(ByVal path As String) As String
    '''Return filename without extension from complete path.
    Dim pos As Integer
    Dim fname As String
    On Error GoTo ExitHere
    fname = GetFileNameWithExt(path)
    pos = InStrRev(fname, ".")
    If pos > 0 Then
        GetFileNameWithoutExt = left$(fname, pos - 1)
    Else
        GetFileNameWithoutExt = ""
    End If
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetFileNameWithoutExt"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetDirPathFromPathFileName
```vba
Public Function GetDirPathFromPathFileName(ByVal path As String) As String
    '''Return directory path from complete path with filename.
    Dim pos As Integer
    On Error GoTo ExitHere
    pos = InStrRev(path, "\")
    If pos > 0 Then
        GetDirPathFromPathFileName = left$(path, pos - 1)
    Else
        GetDirPathFromPathFileName = ""
    End If
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetDirPathFromPathFileName"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetParentDirPathFromPath
```vba
Public Function GetParentDirPathFromPath(ByVal path As String) As String
    '''Return parent directory path.
    Dim pos As Integer
    On Error GoTo ExitHere
    If Right$(path, 1) = "\" Then path = left$(path, Len(path) - 1)
    pos = InStrRev(path, "\")
    If pos > 0 Then
        GetParentDirPathFromPath = left$(path, pos - 1)
    Else
        GetParentDirPathFromPath = ""
    End If
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetParentDirPathFromPath"
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetDirNameFromPath
```vba
Public Function GetDirNameFromPath(ByVal path As String) As String
    '''Return directory name from path.
    Dim pos As Integer
    On Error GoTo ExitHere
    If Right$(path, 1) = "\" Then path = left$(path, Len(path) - 1)
    If InStrRev(path, ".") > InStrRev(path, "\") Then
        path = GetParentDirPathFromPath(path)
    End If
    pos = InStrRev(path, "\")
    If pos > 0 Then
        GetDirNameFromPath = Mid$(path, pos + 1)
    Else
        GetDirNameFromPath = ""
    End If
ExitHere:
    Dim e As New CError
    e.Number = Err.Number: e.Source = Err.Source: e.Description = Err.Description: e.Line = Erl: e.Procedure = "CExcelFunctions.GetDirNameFromPath"
    If Err.Number <> 0 Then Call RaiseError(Err.Number, Err.Source, "CExcelFunctions.GetDirNameFromPath", Err.Description, Erl)
    On Error GoTo 0
    If e.Number <> 0 Then Call RaiseError(e.Number, e.Source, e.Procedure, e.Description, e.Line)
End Function
```

#### GetTicksMS
```vba
Public Function GetTicksMS() As Long
    '''Returns number of miliseconds since start of Windows.
    GetTicksMS = CLng(GetTickCount())
End Function
```

#### TimerStartMS
```vba
Public Function TimerStartMS() As Long
    '''Starts a milisecond Timer.
    timer_start_MS = GetTicksMS()
    timer_last_MS = timer_start_MS
    TimerStartMS = timer_start_MS
End Function
```

#### TimerLastMS
```vba
Public Property Get TimerLastMS() As Long
    '''Returns number of miliseconds since either TimerStartMS or TimerLastMS last call.
    Dim t As Long
    t = GetTicksMS()
    TimerLastMS = t - timer_last_MS
    timer_last_MS = t
End Property
```

#### TimerTotalMS
```vba
Public Property Get TimerTotalMS() As Long
    '''Returns number of miliseconds since TimerStartMS last call.
    timer_last_MS = GetTicksMS()
    TimerTotalMS = timer_last_MS - timer_start_MS
End Property
```

#### pprint
```vba
Public Sub pprint(ParamArray aArgumentsArray() As Variant)
    '''dx2sery, Procedure to print all classic variables including arrays and ranges. Output fed to Debug.Print.
    Dim result As String, itemString As String
    Dim item As Variant
    For Each item In aArgumentsArray
        If TypeName(item) = "Range" Then
            itemString = rangeToString(item)
        ElseIf IsArray(item) Then
            itemString = arrayToString(item)
        Else
            itemString = CStr(item)
        End If
        If result = "" Then
            result = itemString
        Else
            result = result & " " & itemString
        End If
    Next item
    Debug.Print result
End Sub
```

#### arrayToString
```vba
Public Function arrayToString(ByRef arr As Variant) As String
    '''dx2sery, Function to concatenate an Array to string.
    Dim itemString As String
    Dim i As Integer
    For i = LBound(arr) To UBound(arr)
        If IsArray(arr(i)) Then
            itemString = arrayToString(arr(i))
        Else
            itemString = CStr(arr(i))
        End If
        If arrayToString = "" Then
            arrayToString = "[" & itemString
        Else
            arrayToString = arrayToString & "; " & itemString
        End If
    Next
    arrayToString = arrayToString & "]"
End Function
```

#### rangeToString
```vba
Public Function rangeToString(ByRef rng As Variant) As String
    '''dx2sery, Function to concatenate a range to string.
    Dim i As Integer, j As Integer
    Dim rowString As String
    
    rangeToString = "Range("
    For i = 1 To rng.rows.Count
        rowString = ""
        If rangeToString <> "Range(" Then  ' Not the first pass
            rangeToString = rangeToString & "; ("
        Else
            rangeToString = rangeToString & "("
        End If
        
        For j = 1 To rng.columns.Count
            If rowString = "" Then
                rowString = CStr(rng.Cells(i, j).Value)
            Else
                rowString = rowString & "; " & CStr(rng.Cells(i, j).Value)
            End If
        Next
        rangeToString = rangeToString & rowString
        rangeToString = rangeToString & ")"
    Next

    rangeToString = rangeToString & ")"
End Function
```

## usage

### test_CEF
```vba
Private Sub test_CEF()
    Dim CEF As New CExcelFunctions
    'Debug.Print CEF.help
    
    Debug.Print CEF.bFileExistsWild("z:\misc\MBtech\user\dx2tomek\scripts\VBA\backup\module\", "SST_ACCE_v_?_?.bas")
End Sub
```

### test_timer
```vba
Private Sub test_timer()
    Dim CEF As New CExcelFunctions
    Dim CP As New CExcelProperties
    Dim i As Long
    Dim str As String
    
    Call CP.Save
    With CEF
        Call .WorkStart
        Call .TimerStart
        str = vbNullString
        For i = 0 To 100
            Call .SleepMS(100)
            str = str & "Loop " & i & " took: " & .TimerLast & " seconds." & vbCrLf
        Next
        str = str & "That makes " & .TimerTotal & " seconds in total."
    End With
    Debug.Print str
End Sub
```

### test_CountModuleLines
```vba
Private Sub test_CountModuleLines()
    Dim CEF As New CExcelFunctions
    Dim modules() As String
    Dim i As Long
    Dim lines As Long
    Dim lineSum As Long
    modules = CEF.GetAllModuleNames(ThisWorkbook)
    lineSum = 0
    For i = LBound(modules) To UBound(modules)
        lines = CEF.GetModuleLineNo(ThisWorkbook, modules(i))
        Debug.Print modules(i) & vbTab & lines
        lineSum = lineSum + lines
    Next
    Debug.Print "Total:" & vbTab & CStr(lineSum)
End Sub
```

### test_backupModules
```vba
Private Sub test_backupModules()
    Dim CEF As New CExcelFunctions
    On Error GoTo ExitHere
    Call CEF.BackupWorkbookVBProject(ThisWorkbook)
    Debug.Print "Backup Finished."
ExitHere:
    If Err.Number <> 0 Then Call CEF.DisplayError(Err.Source, Err.Description, "test_backupModules", Erl)
End Sub
```

### test_paths
```vba
Private Sub test_paths()
    Dim CEF As New CExcelFunctions
    Dim path As String
    path = ThisWorkbook.FullName
    Debug.Print CEF.GetFileNameWithExt(path)
    Debug.Print CEF.GetFileNameWithoutExt(path)
    Debug.Print CEF.GetDirPathFromPathFileName(path)
    Debug.Print CEF.GetDirNameFromPath(path)
    Debug.Print CEF.GetParentDirPathFromPath(path)
    Debug.Print CEF.GetParentDirPathFromPath(CEF.GetParentDirPathFromPath(path))
End Sub
```

### test_ticks
```vba
Private Sub test_ticks()
    Dim CEF As New CExcelFunctions
    Debug.Print CEF.GetTicksMS
End Sub
```

### Parse_Module
```vba
Private Sub Parse_Module(Optional ByVal module_name As String = "CExcelFunctions")
    Dim CEF As New CExcelFunctions
    'Const MNAME = "CExcelFunctions"
    Dim mtext() As String
    Dim kwrds As Variant
    Dim i As Long
    Dim help As Object
    Dim fname As String
    Dim declaration As String
    Dim comment As String
    Dim str() As String
    
    On Error GoTo ExitHere
    
    mtext = CEF.GetModuleContent(ThisWorkbook, module_name)
    
    Set help = CreateObject("Scripting.Dictionary")
    For i = LBound(mtext) To UBound(mtext) Step 1
        If mtext(i) Like "*Property ??? *(*" And InStr(1, mtext(i), "Private") = 0 And (InStr(1, mtext(i), Chr(34)) = 0 Or InStr(1, mtext(i), Chr(34)) > InStr(1, mtext(i), "Property")) Then
            str = Parse_Procedure(mtext, i, "Property")
            help(str(0)) = str
        ElseIf mtext(i) Like "*Function *(*" And InStr(1, mtext(i), "Private") = 0 And (InStr(1, mtext(i), Chr(34)) = 0 Or InStr(1, mtext(i), Chr(34)) > InStr(1, mtext(i), "Function")) Then
            str = Parse_Procedure(mtext, i, "Function")
            help(str(0)) = str
        ElseIf mtext(i) Like "*Sub *(*" And InStr(1, mtext(i), "Private") = 0 And (InStr(1, mtext(i), Chr(34)) = 0 Or InStr(1, mtext(i), Chr(34)) > InStr(1, mtext(i), "Sub")) Then
            str = Parse_Procedure(mtext, i, "Sub")
            help(str(0)) = str
        End If
    Next
ExitHere:
    Set help = Nothing
End Sub
```

### Parse_Procedure
```vba
Private Function Parse_Procedure(ByRef module_text() As String, ByVal start_line As Long, ByVal procedure_type As String) As String()
    Dim fname As String
    Dim declaration As String
    Dim comment As String
    Dim retVal(2) As String
    Dim i As Long
    
    On Error GoTo ExitHere
    
    fname = Split(module_text(start_line), "(")(0)
    fname = Mid(fname, InStrRev(fname, " ") + 1)
    
    declaration = module_text(start_line)
    For i = start_line + 1 To UBound(module_text)
        If InStr(1, module_text(i), "End " & procedure_type) <> 0 Then Exit For
        If Right(RTrim(module_text(i - 1)), 1) = "_" Then
            declaration = Replace(declaration, " _", " " & LTrim(module_text(i)))
        Else
            Exit For
        End If
    Next
    If InStr(1, declaration, " '") <> 0 Then
        declaration = RTrim(Split(declaration, " '")(0))
    End If
    
    comment = ""
    For i = start_line + 1 To UBound(module_text)
        If InStr(1, module_text(i), "End " & procedure_type) <> 0 Then Exit For
        If left(LTrim(module_text(i)), 3) = "'''" Then
            comment = comment & Mid(LTrim(module_text(i)), 4) & vbCrLf
        End If
    Next
    If Len(comment) > 0 Then comment = left(comment, Len(comment) - Len(vbCrLf))
    
    retVal(0) = fname
    retVal(1) = declaration
    retVal(2) = comment
    Parse_Procedure = retVal
ExitHere:
    On Error Resume Next
    On Error GoTo 0
End Function
```

# CExcelProperties
save and restore excel session properties

## header
```vba
Option Explicit

'Class taken from:
' https://codereview.stackexchange.com/questions/117037/vba-class-to-persist-and-restore-excel-application-properties
Public Enum CExcelPropertiesError
    Error_AlreadyInitialized = vbObjectError + 42
End Enum

'These constants define the default restoration behaviors for the class
Private Const DEFAULT_RESTORE_CALCULATION = True
Private Const DEFAULT_RESTORE_DISPLAY_ALERTS = True
Private Const DEFAULT_RESTORE_ENABLE_EVENTS = True
Private Const DEFAULT_RESTORE_SCREEN_UPDATING = True
Private Const DEFAULT_RESTORE_ENABLE_ANIMATIONS = True

'Set this to true to ensure a persisted state is restored, even if the consumer forgets to restore
Private Const RESTORE_ON_TERMINATE = True

'Private members stored in a Type
Private this As TMembers

Private Type TMembers
  Calculation As XlCalculationState
  DisplayAlerts As Boolean
  EnableEvents As Boolean
  ScreenUpdating As Boolean
  EnableAnimations As Boolean
  RestoreCA As Boolean
  RestoreDA As Boolean
  RestoreEE As Boolean
  RestoreSU As Boolean
  RestoreEA As Boolean
  IsSaved As Boolean
  IsRestored As Boolean
End Type
```

## Class_Initialize
```vba
Private Sub Class_Initialize()
'Set the default restoration behaviours on intialize
  this.RestoreCA = DEFAULT_RESTORE_CALCULATION
  this.RestoreDA = DEFAULT_RESTORE_DISPLAY_ALERTS
  this.RestoreEE = DEFAULT_RESTORE_ENABLE_EVENTS
  this.RestoreSU = DEFAULT_RESTORE_SCREEN_UPDATING
  this.RestoreEA = DEFAULT_RESTORE_ENABLE_ANIMATIONS
End Sub
```

## Class_Terminate
```vba
Private Sub Class_Terminate()
'By default, restore the settings if we didn't do it explicitly
  If this.IsSaved And Not this.IsRestored And RESTORE_ON_TERMINATE Then
    Me.Restore
  End If
End Sub
```

## RestoreCalculation Get
```vba
Public Property Get RestoreCalculation() As Boolean
  RestoreCalculation = this.RestoreCA
End Property
```

## RestoreCalculation Let
```vba
Public Property Let RestoreCalculation(Value As Boolean)
  this.RestoreCA = Value
End Property
```

## RestoreDisplayAlerts Get
```vba
Public Property Get RestoreDisplayAlerts() As Boolean
  RestoreDisplayAlerts = this.RestoreDA
End Property
```

## RestoreDisplayAlerts Let
```vba
Public Property Let RestoreDisplayAlerts(Value As Boolean)
  this.RestoreDA = Value
End Property
```

## RestoreEnableEvents Get
```vba
Public Property Get RestoreEnableEvents() As Boolean
  RestoreEnableEvents = this.RestoreEE
End Property
```

## RestoreEnableEvents Let
```vba
Public Property Let RestoreEnableEvents(Value As Boolean)
  this.RestoreEE = Value
End Property
```

## RestoreScreenUpdating Get
```vba
Public Property Get RestoreScreenUpdating() As Boolean
  RestoreScreenUpdating = this.RestoreSU
End Property
```

## RestoreScreenUpdating Let
```vba
Public Property Let RestoreScreenUpdating(Value As Boolean)
  this.RestoreSU = Value
End Property
```

## RestoreEnableAnimations Get
```vba
Public Property Get RestoreEnableAnimations() As Boolean
  RestoreEnableAnimations = this.RestoreEA
End Property
```

## RestoreEnableAnimations Let
```vba
Public Property Let RestoreEnableAnimations(Value As Boolean)
  this.RestoreEA = Value
End Property
```

## Save
```vba
Public Sub Save()
  If Not this.IsSaved Then
    'Save all of the settings
    With Application
      this.Calculation = .Calculation
      this.DisplayAlerts = .DisplayAlerts
      this.EnableEvents = .EnableEvents
      this.ScreenUpdating = .ScreenUpdating
      this.EnableAnimations = .EnableAnimations
    End With
    this.IsSaved = True
  Else
    Err.Raise Error_AlreadyInitialized, "CExcelProperties", "Properties have already been saved."
  End If
End Sub
```

## Restore
```vba
Public Sub Restore()
  'Only restore the settings that we want restored
  '(which by default is all of them)
  With Application
    If this.RestoreCA Then
      .Calculation = this.Calculation
    End If
    If this.RestoreDA Then
      .DisplayAlerts = this.DisplayAlerts
    End If
    If this.RestoreEE Then
      .EnableEvents = this.EnableEvents
    End If
    If this.RestoreSU Then
      .ScreenUpdating = this.ScreenUpdating
    End If
    If this.RestoreEA Then
      .EnableAnimations = this.EnableAnimations
    End If
  End With
  this.IsRestored = True
End Sub
```

# Usage Examples

```vba
Option Explicit
```

## Example_Help
```vba
Private Sub Example_Help()
    Dim CEF As New CExcelFunctions
    On Error GoTo ExitHere
    Debug.Print CEF.help()
    Call CEF.SaveFile(ThisWorkbook.path & "\" & CEF.GetFileNameWithoutExt(ThisWorkbook.FullName) & "_help.txt", CEF.help(), True)
ExitHere:
    If Err.Number <> 0 Then Call CEF.DisplayError(Err.Source, Err.Description, "Example_Help", Erl)
    On Error GoTo 0
End Sub
```

## Example_Help_1
```vba
Private Sub Example_Help_1()
    Dim CEF As New CExcelFunctions
    On Error GoTo ExitHere
    Debug.Print CEF.help("BackupWorkbookVBProject")
ExitHere:
    If Err.Number <> 0 Then Call CEF.DisplayError(Err.Source, Err.Description, "Example_Help", Erl)
    On Error GoTo 0
End Sub
```

## Example_All
```vba
Private Sub Example_All()
    Dim CEF As New CExcelFunctions
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim directory As String
    Dim fls() As String
    Dim CProp As New CExcelProperties
    Dim i As Long
    
    On Error GoTo ExitHere
    CProp.Save
    
    directory = CEF.PickDir("Z:\misc\MBtech\user\" & Environ("USERNAME"), "Pick a directory to list all its fies.")
    If directory = "" Then GoTo ExitHere
    CEF.WorkStart
    CEF.TimerStart
    
    Set wb = ActiveWorkbook
    
    If CEF.bDirExists(directory) Then
        fls = CEF.GetFiles(directory, Array("*"))
        If Len(Join(fls)) > 0 Then
            Set ws = wb.Worksheets.Add(After:=wb.Sheets(wb.Sheets.Count))
            ws.name = CEF.GetDirNameFromPath(directory)
            Debug.Print "Step 1 took: " & CEF.TimerLast & " seconds,"
            For i = LBound(fls) To UBound(fls) Step 1
                ws.Cells(i - LBound(fls) + 1, 1) = fls(i)
                Call CEF.SleepMS(100)  ' Just to show timer
                Debug.Print "Loop " & i & " took " & CEF.TimerLast & " seconds,"
            Next
        End If
    End If
    Debug.Print "Whole example took " & CEF.TimerTotal & " seconds."
ExitHere:
    If Err.Number <> 0 Then Call CEF.DisplayError(Err.Source, Err.Description, "Example_All", Erl)
    On Error Resume Next
    Set ws = Nothing
    Set wb = Nothing
    Set CEF = Nothing
    Set CProp = Nothing
    On Error GoTo 0
End Sub
```

## Example_Error
```vba
Private Sub Example_Error()
    Dim CEF As New CExcelFunctions
    Dim CProp As New CExcelProperties
    Dim arr() As Long
    Dim i As Long
    
    On Error GoTo ExitHere
    
    CProp.Save
    CEF.WorkStart
    
    ReDim arr(50) As Long
    For i = LBound(arr) To UBound(arr)
        arr(i) = Rnd(i) * 100
    Next
    Call CEF.quickSort(arr, -1)
    
ExitHere:
    If Err.Number <> 0 Then Call CEF.DisplayError(Err.Source, Err.Description, "CExcelFunctions.Example_Error", Erl)
    On Error Resume Next
    Set CEF = Nothing
    Set CProp = Nothing
    On Error GoTo 0
End Sub
```

## Example_BackupModules
```vba
Private Sub Example_BackupModules()
    Dim CEF As New CExcelFunctions
    On Error GoTo ExitHere
    Call CEF.BackupWorkbookVBProject(ThisWorkbook)
    Debug.Print "Backup Done."
ExitHere:
    If Err.Number <> 0 Then Call CEF.DisplayError(Err.Source, Err.Description, "Example_backupModules", Erl)
    On Error GoTo 0
End Sub
```

# CLog

## code
```vba
Option Explicit

Private Type LogEntry
    style As LogEntryStyle
    message As String
    time As String
End Type

Enum LogEntryStyle
    lgOk = 1
    lgError = 2
    lgInfo = 4
    lgQuestion = 8
    lgNone = 16
End Enum

Private log() As LogEntry

Private Sub Class_Initialize()
    ReDim log(0)
End Sub

Private Sub Class_Terminate()
    Call PrintAll
End Sub

Public Sub AddEntry(ByVal message As String, Optional ByVal style As LogEntryStyle = lgOk)
    With log(UBound(log))
        .style = style
        .message = message
        .time = Format$(Now(), "yy\/mm\/dd HH:MM:SS")
    End With
    ReDim Preserve log(UBound(log) + 1)
End Sub

Public Sub PrintAll()
    Dim i As Long
    For i = LBound(log) To UBound(log) - 1
        Debug.Print GetStyle(log(i).style) & " " & log(i).time & " - " & log(i).message
    Next
End Sub

Private Function GetStyle(ByVal style As LogEntryStyle) As String
    Select Case style
    Case lgOk
        GetStyle = "[+]"
    Case lgError
        GetStyle = "[-]"
    Case lgInfo
        GetStyle = "[i]"
    Case lgQuestion
        GetStyle = "[?]"
    Case Else
        GetStyle = ""
    End Select
End Function
```

## usage
```vba
Private Sub test_log()
    Dim log As New CLog
    Dim i As Long
    Dim CEF As New CExcelFunctions
    
    Debug.Print CEF.help("WorkStop")
    
    For i = 1 To 100 Step 1
        Call log.AddEntry("Loop number " & CStr(i), lgOk)
        Call CEF.SleepMS(100)
    Next
    Set log = Nothing
End Sub
```


# PowerPoint
```vba
Attribute VB_Name = "AutomatePowerPoint"
Option Explicit

' DO NOT FORGET TO ADD PowerPoint Reference in Tools->References!!!

#If VBA7 Then ' Excel 2010 or later
 
    Public Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal Milliseconds As LongPtr)
 
#Else ' Excel 2007 or earlier
 
    Public Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal Milliseconds As Long)
 
#End If

Public Sub CopyAllChartsToNewPPT()
    Dim pptPresentation As PowerPoint.Presentation
    
    Dim xlsChart As Excel.Chart
    Dim xlsChtObj As Excel.ChartObject
    Dim xlsSheet As Object

    
    On Error GoTo ExitHere
    
    Set pptPresentation = CreatePPTPresentation()
    If pptPresentation Is Nothing Then GoTo ExitHere
    
    Call CopyAllChartsToPPT(pptPresentation)
    
ExitHere:
    Set xlsChart = Nothing
    Set xlsChtObj = Nothing
    Set xlsSheet = Nothing
    Set pptPresentation = Nothing
End Sub

Public Sub CopyAllChartsToActivePPT()
    Dim pptPresentation As PowerPoint.Presentation
    
    Dim xlsChart As Excel.Chart
    Dim xlsChtObj As Excel.ChartObject
    Dim xlsSheet As Object

    On Error GoTo ExitHere
    
    Set pptPresentation = GetPPTPresentation()
    If pptPresentation Is Nothing Then GoTo ExitHere
    
    Call CopyAllChartsToPPT(pptPresentation)
    
ExitHere:
    Set xlsChart = Nothing
    Set xlsChtObj = Nothing
    Set xlsSheet = Nothing
    Set pptPresentation = Nothing
End Sub


Public Sub CopySelectedChartToNewPPT()
    Dim pptPresentation As PowerPoint.Presentation
    
    If TypeName(Selection) = "ChartArea" And TypeName(ActiveChart) = "Chart" Then
        Set pptPresentation = CreatePPTPresentation()
        If pptPresentation Is Nothing Then GoTo ExitHere
        
        Call CopySelectedChartToPPT(pptPresentation)
    End If
        
ExitHere:
    Set pptPresentation = Nothing
End Sub

Public Sub CopySelectedChartToActivePPT()
    Dim pptPresentation As PowerPoint.Presentation
    
    If TypeName(Selection) = "ChartArea" And TypeName(ActiveChart) = "Chart" Then
        Set pptPresentation = GetPPTPresentation()
        If pptPresentation Is Nothing Then GoTo ExitHere
        
        Call CopySelectedChartToPPT(pptPresentation)
    End If
        
ExitHere:
    Set pptPresentation = Nothing
End Sub

Private Sub CopyAllChartsToPPT(ByRef pptPresentation As PowerPoint.Presentation)
    Dim xlsChart As Excel.Chart
    Dim xlsChtObj As Excel.ChartObject
    Dim xlsSheet As Object
    
    Dim i As Long
    
    On Error GoTo ExitHere
   
    i = pptPresentation.Application.ActiveWindow.View.Slide.SlideIndex
    For Each xlsSheet In ActiveWorkbook.Sheets
        If TypeName(xlsSheet) = "Chart" Then
            Call CopyChartToPPT(pptPresentation, xlsSheet, Array(37.75, 126.4, 884.5, 382), After:=i)
            i = i + 1
        ElseIf TypeName(xlsSheet) = "Worksheet" Then
            For Each xlsChtObj In xlsSheet.ChartObjects
                Call CopyChartToPPT(pptPresentation, xlsChtObj.Chart, Array(37.75, 126.4, 884.5, 382), After:=i)
                i = i + 1
            Next
        End If
    Next
    
    Call pptPresentation.Application.ActiveWindow.View.GotoSlide(i)
    
ExitHere:
    Set xlsChart = Nothing
    Set xlsChtObj = Nothing
    Set xlsSheet = Nothing
End Sub

Private Sub CopySelectedChartToPPT(ByRef pptPresentation As PowerPoint.Presentation)
    Dim xlsChart As Excel.Chart

    Dim i As Long
    
    If TypeName(Selection) = "ChartArea" And TypeName(ActiveChart) = "Chart" Then
        Set xlsChart = ActiveChart

        i = pptPresentation.Application.ActiveWindow.View.Slide.SlideIndex
        Call CopyChartToPPT(pptPresentation, xlsChart, Array(37.75, 126.4, 884.5, 382), After:=i)
        Call pptPresentation.Application.ActiveWindow.View.GotoSlide(i + 1)
    End If
        
ExitHere:
    Set xlsChart = Nothing
End Sub

Private Function GetPPTPresentation() As Variant
    Dim pptApp As PowerPoint.Application
    Dim pptPresentation As PowerPoint.Presentation
    
    On Error GoTo ExitHere
    Set pptApp = GetPPTApplication()
    If pptApp Is Nothing Then GoTo ExitHere
    
    Set pptPresentation = pptApp.ActivePresentation
    If pptPresentation Is Nothing Then GoTo ExitHere
    
    Set GetPPTPresentation = pptPresentation
    Set pptApp = Nothing
    
    Exit Function
    
ExitHere:
    Set pptPresentation = Nothing
    Set pptApp = Nothing
    GetPPTPresentation = Nothing
End Function

Private Function CreatePPTPresentation(Optional ByVal template As String = vbNullString, Optional ByVal delete_slides As Boolean = True) As Variant
    Dim pptApp As PowerPoint.Application
    Dim pptPresentation As PowerPoint.Presentation
    Dim i As Long
    
    On Error GoTo ExitHere
    
    If template = vbNullString Then
        template = "C:\Program Files (x86)\Microsoft Office\Vorlagen\Blank.potx"
    End If
    
    Set pptApp = GetPPTApplication()
    If pptApp Is Nothing Then Set pptApp = CreatePPTApplication()
    If pptApp Is Nothing Then GoTo ExitHere
    
    ' Set pptPresentation = pptApp.Presentations.Add(msoTrue)
    Set pptPresentation = pptApp.Presentations.Open(template, msoCTrue)
    
    If delete_slides Then
        For i = pptPresentation.Slides.Count - 1 To 2 Step -1
            pptPresentation.Slides(i).Delete
        Next
    End If
    
    Call pptApp.ActiveWindow.View.GotoSlide(1)
    
    Set CreatePPTPresentation = pptPresentation
    Set pptApp = Nothing
    
    Exit Function

ExitHere:
    On Error Resume Next
    Set pptPresentation = Nothing
    Set pptApp = Nothing
    Set CreatePPTPresentation = Nothing
End Function

Private Function GetPPTApplication() As Variant
    Dim pptApp As PowerPoint.Application
    
    On Error Resume Next
    Set pptApp = GetObject(, "PowerPoint.Application")
    On Error GoTo ExitHere
    
    If pptApp Is Nothing Then GoTo ExitHere
    
    Set GetPPTApplication = pptApp
    Exit Function
ExitHere:
    Set pptApp = Nothing
    Set GetPPTApplication = Nothing
End Function

Private Function CreatePPTApplication() As Variant
    Dim pptApp As PowerPoint.Application
    
    On Error GoTo ExitHere
    
    Set pptApp = CreateObject("PowerPoint.Application")
    If pptApp Is Nothing Then GoTo ExitHere

    If pptApp.Visible <> msoCTrue Then pptApp.Visible = msoCTrue
    If pptApp.WindowState <> ppWindowMaximized Then pptApp.WindowState = ppWindowMaximized
    
    Set GetPPTApplication = pptApp
    Exit Function
ExitHere:
    Set pptApp = Nothing
    GetPPTApplication = Nothing
End Function
                           
Private Sub CopyChartToPPT(ByRef pptPresentation As PowerPoint.Presentation, xlsChart As Excel.Chart, _
                           Optional ByRef size As Variant = Nothing, _
                           Optional ByVal After As Long = -1)
                           
    Dim pptSlide As PowerPoint.Slide
    Dim pptShape As PowerPoint.ShapeRange

    If After < 0 Then
        After = pptPresentation.Slides.Count + After + 2
    Else
        After = After + 1
    End If
    
    Set pptSlide = pptPresentation.Slides.Add(After, ppLayoutText)

    'Copy the chart and paste in Powerpoint
    xlsChart.ChartArea.Copy

    Set pptShape = pptSlide.Shapes.PasteSpecial(DataType:=ppPasteShape)
    
    'Add heading to the slide
    pptSlide.Shapes(1).TextFrame.TextRange.text = xlsChart.ChartTitle.text
    
    'Allignment of the chart
    If IsArray(size) Then
        If LBound(size) = 0 And UBound(size) = 3 Then
            With pptShape
                .LockAspectRatio = msoFalse
                .Left = size(0)
                .Top = size(1)
                .Width = size(2)
                .Height = size(3)
                .LockAspectRatio = msoTrue
            End With
        End If
    End If
    
    pptSlide.Shapes(2).Delete
    
ExitHere:
    Set pptShape = Nothing
    Set pptSlide = Nothing
End Sub
```

