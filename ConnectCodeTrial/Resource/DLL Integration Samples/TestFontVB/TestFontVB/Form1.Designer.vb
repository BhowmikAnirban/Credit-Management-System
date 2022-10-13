<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.TextBox1 = New System.Windows.Forms.TextBox
        Me.TextBox2 = New System.Windows.Forms.TextBox
        Me.ComboBox_Barcode = New System.Windows.Forms.ComboBox
        Me.RichTextBox_Output = New System.Windows.Forms.RichTextBox
        Me.Button1 = New System.Windows.Forms.Button
        Me.TextBox_Font = New System.Windows.Forms.TextBox
        Me.Label4 = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(28, 21)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(30, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Data"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(28, 105)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(39, 13)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "Output"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(28, 51)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(47, 13)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "Barcode"
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(93, 18)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(327, 20)
        Me.TextBox1.TabIndex = 3
        '
        'TextBox2
        '
        Me.TextBox2.Location = New System.Drawing.Point(93, 102)
        Me.TextBox2.Name = "TextBox2"
        Me.TextBox2.ReadOnly = True
        Me.TextBox2.Size = New System.Drawing.Size(327, 20)
        Me.TextBox2.TabIndex = 4
        '
        'ComboBox_Barcode
        '
        Me.ComboBox_Barcode.FormattingEnabled = True
        Me.ComboBox_Barcode.Items.AddRange(New Object() {"Code 128 Auto", "Code 128A", "Code 128B", "Code 128C", "Code 39", "Code 39 Ascii", "Code 93", "Codabar", "I2of5", "Industrial 2of5", "ITF14", "EAN13", "EAN8", "EXT2", "EXT5", "Modified Plessy", "Postnet", "UCCEAN", "UPCA", "UPCE", "GS1Databar14", "GS1DatabarLimited", "GS1DatabarExpanded", "GS1DatabarTruncated", "GS1DatabarStacked", "GS1DatabarStackedOmni", "GS1DatabarExpandedStacked"})
        Me.ComboBox_Barcode.Location = New System.Drawing.Point(93, 51)
        Me.ComboBox_Barcode.Name = "ComboBox_Barcode"
        Me.ComboBox_Barcode.Size = New System.Drawing.Size(236, 21)
        Me.ComboBox_Barcode.TabIndex = 5
        '
        'RichTextBox_Output
        '
        Me.RichTextBox_Output.Location = New System.Drawing.Point(31, 128)
        Me.RichTextBox_Output.Name = "RichTextBox_Output"
        Me.RichTextBox_Output.Size = New System.Drawing.Size(389, 96)
        Me.RichTextBox_Output.TabIndex = 6
        Me.RichTextBox_Output.Text = ""
        Me.RichTextBox_Output.WordWrap = False
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(31, 234)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 23)
        Me.Button1.TabIndex = 7
        Me.Button1.Text = "Encode"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'TextBox_Font
        '
        Me.TextBox_Font.Location = New System.Drawing.Point(93, 77)
        Me.TextBox_Font.Name = "TextBox_Font"
        Me.TextBox_Font.ReadOnly = True
        Me.TextBox_Font.Size = New System.Drawing.Size(236, 20)
        Me.TextBox_Font.TabIndex = 8
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(28, 80)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(28, 13)
        Me.Label4.TabIndex = 9
        Me.Label4.Text = "Font"
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(453, 269)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.TextBox_Font)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.RichTextBox_Output)
        Me.Controls.Add(Me.ComboBox_Barcode)
        Me.Controls.Add(Me.TextBox2)
        Me.Controls.Add(Me.TextBox1)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Name = "Form1"
        Me.Text = "Encoder Sampler VB"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents TextBox2 As System.Windows.Forms.TextBox
    Friend WithEvents ComboBox_Barcode As System.Windows.Forms.ComboBox
    Friend WithEvents RichTextBox_Output As System.Windows.Forms.RichTextBox
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents TextBox_Font As System.Windows.Forms.TextBox
    Friend WithEvents Label4 As System.Windows.Forms.Label

End Class
