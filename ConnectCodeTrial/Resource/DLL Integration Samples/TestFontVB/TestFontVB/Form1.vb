Imports System.Runtime.InteropServices




Public Class Form1

    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Code128Auto(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Code39(ByVal instr As String, ByVal checkdigit As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_POSTNET(ByVal instr As String, ByVal checkdigit As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Code93(ByVal instr As String, ByVal checkdigit As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Codabar(ByVal instr As String, ByVal checkdigit As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Code39Ascii(ByVal instr As String, ByVal checkdigit As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_I2of5(ByVal instr As String, ByVal checkdigit As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_ITF14(ByVal instr As String, ByVal checkdigit As Integer, ByVal bearer As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Industrial2of5(ByVal instr As String, ByVal checkdigit As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_ModifiedPlessy(ByVal instr As String, ByVal checkdigit As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_EAN13(ByVal instr As String, ByVal humantext As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function RetrieveOptionalString_EAN13(ByVal instr As String, ByVal humantext As Integer, ByVal strtype As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_UPCA(ByVal instr As String, ByVal humantext As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_EAN8(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_UCCEAN(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Code128A(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Code128B(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_Code128C(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_UPCE(ByVal instr As String, ByVal humantext As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_EXT2(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function
    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_EXT5(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function


    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_GS1DataBar14(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function

    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_GS1DataBarLimited(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function

    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_GS1DataBarExpanded(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function

    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_GS1DataBarTruncated(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function

    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_GS1DataBarStacked(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function

    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_GS1DataBarStackedOmni(ByVal instr As String, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function

    <DllImport("connectcodefont.dll")> _
    Public Shared Function Encode_GS1DataBarExpandedStacked(ByVal instr As String, ByVal numSegmentsPerRow As Integer, ByVal outstr As System.Text.StringBuilder, ByVal outstrmax As Integer) As Integer

    End Function



    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        Dim inputstr As String
        Dim outputstr As System.Text.StringBuilder
        Dim barcodestr As String
        Dim fontsize As Integer
        Dim fx As Font

        inputstr = TextBox1.Text
        outputstr = New System.Text.StringBuilder(2048)
        barcodestr = ComboBox_Barcode.Text

        If (barcodestr = "Code 39") Then

            TextBox_Font.Text = "CCode39_S3_Trial"
            Encode_Code39(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Postnet") Then


            TextBox_Font.Text = "CCodePostnet_Trial"
            Encode_POSTNET(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Code 93") Then


            TextBox_Font.Text = "CCode93_S3_Trial"
            Encode_Code93(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Codabar") Then


            TextBox_Font.Text = "CCodeCodabar_S3_Trial"
            Encode_Codabar(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Code 39 Ascii") Then


            TextBox_Font.Text = "CCode39_S3_Trial"
            Encode_Code39Ascii(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "I2of5") Then


            TextBox_Font.Text = "CCodeI2of5_S3_Trial"
            Encode_I2of5(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "ITF14") Then

            TextBox_Font.Text = "CCodeITF_S3_Trial"
            Encode_ITF14(inputstr, 0, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Industrial 2of5") Then

            TextBox_Font.Text = "CCodeIND2of5_S3_Trial"
            Encode_Industrial2of5(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Modified Plessy") Then

            TextBox_Font.Text = "CCodeMSI_S3_Trial"
            Encode_ModifiedPlessy(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "EAN13") Then


            TextBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial"
            'textBox_Font.Text ="CCodeUPCEAN_S3"               
            Encode_EAN13(inputstr, 1, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "UPCA") Then


            TextBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial"
            'textBox_Font.Text = "CCodeUPCEAN_S3"
            Encode_UPCA(inputstr, 1, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "EAN8") Then


            'textBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial"
            TextBox_Font.Text = "CCodeUPCEAN_S3_Trial"
            Encode_EAN8(inputstr, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "UCCEAN") Then

            TextBox_Font.Text = "CCode128_S3_Trial"
            Encode_UCCEAN(inputstr, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Code 128 Auto") Then


            TextBox_Font.Text = "CCode128_S3_Trial"
            Encode_Code128Auto(inputstr, outputstr, outputstr.Capacity)



        ElseIf (barcodestr = "Code 128A") Then


            TextBox_Font.Text = "CCode128_S3_Trial"
            Encode_Code128A(inputstr, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Code 128B") Then


            TextBox_Font.Text = "CCode128_S3_Trial"
            Encode_Code128B(inputstr, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "Code 128C") Then


            TextBox_Font.Text = "CCode128_S3_Trial"
            Encode_Code128C(inputstr, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "UPCE") Then


            'textBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial"
            TextBox_Font.Text = "CCodeUPCEAN_S3_Trial"

            Encode_UPCE(inputstr, 0, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "EXT2") Then


            'textBox_Font.Text = "CCodeUPCEAN_HRTS3_Trial"
            TextBox_Font.Text = "CCodeUPCEAN_S3_Trial"
            Encode_EXT2(inputstr, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "EXT5") Then

            'textBox_Font.Text = "CCodeUPCEAN_HRTS3_Trial"
            TextBox_Font.Text = "CCodeUPCEAN_S3_Trial"
            Encode_EXT5(inputstr, outputstr, outputstr.Capacity)

        ElseIf (barcodestr = "GS1Databar14") Then

            TextBox_Font.Text = "CCodeGS1D_S3_Trial"
            Encode_GS1DataBar14(inputstr, outputstr, outputstr.Capacity)

        ElseIf (barcodestr = "GS1DatabarLimited") Then

            TextBox_Font.Text = "CCodeGS1D_S3_Trial"
            Encode_GS1DataBarLimited(inputstr, outputstr, outputstr.Capacity)

        ElseIf (barcodestr = "GS1DatabarExpanded") Then

            TextBox_Font.Text = "CCodeGS1D_S3_Trial"
            Encode_GS1DataBarExpanded(inputstr, outputstr, outputstr.Capacity)


        ElseIf (barcodestr = "GS1DatabarTruncated") Then

            TextBox_Font.Text = "CCodeGS1DTR_S3_Trial"
            Encode_GS1DataBarTruncated(inputstr, outputstr, outputstr.Capacity)

        ElseIf (barcodestr = "GS1DatabarStacked") Then

            TextBox_Font.Text = "CCodeGS1DST_Trial"
            Encode_GS1DataBarStacked(inputstr, outputstr, outputstr.Capacity)

        ElseIf (barcodestr = "GS1DatabarStackedOmni") Then

            TextBox_Font.Text = "CCodeGS1DSTO_Trial"
            Encode_GS1DataBarStackedOmni(inputstr, outputstr, outputstr.Capacity)

        ElseIf (barcodestr = "GS1DatabarExpandedStacked") Then

            Dim NumSegmentsPerRow As Integer
            NumSegmentsPerRow = 4
            TextBox_Font.Text = "CCodeGS1DEST_Trial"
            Encode_GS1DataBarExpandedStacked(inputstr, NumSegmentsPerRow, outputstr, outputstr.Capacity)

        End If

        TextBox2.Text = outputstr.ToString()
        RichTextBox_Output.Text = outputstr.ToString()
        RichTextBox_Output.SelectAll()


        fontsize = 24
        If (barcodestr = "Postnet") Then
            fontsize = 9
        End If

        If (barcodestr = "GS1DatabarStackedOmni") Then
            fontsize = 48
        End If

        If (barcodestr = "GS1DatabarExpandedStacked") Then
            fontsize = 48
        End If


        fx = New Font(TextBox_Font.Text, fontsize)
        RichTextBox_Output.SelectionFont = fx


    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ComboBox_Barcode.SelectedIndex = 0
        TextBox1.Text = "12345678"
    End Sub

    Private Sub ComboBox_Barcode_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ComboBox_Barcode.SelectedIndexChanged
        Dim barcodestr As String

        barcodestr = ComboBox_Barcode.Text
        If (barcodestr = "UCCEAN") Then

            TextBox1.Text = "(10)12345678"

        ElseIf (barcodestr = "GS1Databar14") Then

            TextBox1.Text = "12401234567898"

        ElseIf (barcodestr = "GS1DatabarLimited") Then

            TextBox1.Text = "15012345678907"

        ElseIf (barcodestr = "GS1DatabarExpanded") Then

            TextBox1.Text = "(01)90012345678908(3103)001750"

        ElseIf (barcodestr = "GS1DatabarTruncated") Then

            TextBox1.Text = "12401234567898"

        ElseIf (barcodestr = "GS1DatabarStacked") Then

            TextBox1.Text = "83012345678953"

        ElseIf (barcodestr = "GS1DatabarStackedOmni") Then

            TextBox1.Text = "83012345678953"

        ElseIf (barcodestr = "GS1DatabarExpandedStacked") Then

            TextBox1.Text = "(01)98898765432106(3202)012345(15)991231"

        End If


    End Sub
End Class
