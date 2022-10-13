namespace TestFont
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.richTextBox_Output = new System.Windows.Forms.RichTextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.comboBox_Barcode = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.textBox_Font = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(34, 282);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 0;
            this.button1.Text = "Encode";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(34, 22);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(354, 20);
            this.textBox1.TabIndex = 1;
            // 
            // textBox2
            // 
            this.textBox2.Location = new System.Drawing.Point(35, 141);
            this.textBox2.Name = "textBox2";
            this.textBox2.ReadOnly = true;
            this.textBox2.Size = new System.Drawing.Size(354, 20);
            this.textBox2.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(32, 4);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(30, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Data";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(32, 125);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(39, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Output";
            // 
            // richTextBox_Output
            // 
            this.richTextBox_Output.Location = new System.Drawing.Point(34, 167);
            this.richTextBox_Output.Name = "richTextBox_Output";
            this.richTextBox_Output.Size = new System.Drawing.Size(354, 108);
            this.richTextBox_Output.TabIndex = 5;
            this.richTextBox_Output.Text = "";
            this.richTextBox_Output.WordWrap = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(32, 55);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(47, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Barcode";
            // 
            // comboBox_Barcode
            // 
            this.comboBox_Barcode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_Barcode.FormattingEnabled = true;
            this.comboBox_Barcode.Items.AddRange(new object[] {
            "Code 128 Auto",
            "Code 128A",
            "Code 128B",
            "Code 128C",
            "Code 39",
            "Code 39 Ascii",
            "Code 93",
            "Codabar",
            "I2of5",
            "Industrial 2of5",
            "ITF14",
            "EAN13",
            "EAN8",
            "EXT2",
            "EXT5",
            "Modified Plessy",
            "Postnet",
            "UCCEAN",
            "UPCA",
            "UPCE",
            "GS1Databar14",
            "GS1DatabarLimited",
            "GS1DatabarExpanded",
            "GS1DatabarTruncated",
            "GS1DatabarStacked",
            "GS1DatabarStackedOmni",
            "GS1DatabarExpandedStacked"
            });
            this.comboBox_Barcode.Location = new System.Drawing.Point(91, 52);
            this.comboBox_Barcode.Name = "comboBox_Barcode";
            this.comboBox_Barcode.Size = new System.Drawing.Size(175, 21);
            this.comboBox_Barcode.TabIndex = 7;
            this.comboBox_Barcode.SelectedIndexChanged += new System.EventHandler(this.comboBox_Barcode_selchange);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(31, 91);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(28, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "Font";
            // 
            // textBox_Font
            // 
            this.textBox_Font.Location = new System.Drawing.Point(91, 88);
            this.textBox_Font.Name = "textBox_Font";
            this.textBox_Font.ReadOnly = true;
            this.textBox_Font.Size = new System.Drawing.Size(175, 20);
            this.textBox_Font.TabIndex = 9;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(454, 320);
            this.Controls.Add(this.textBox_Font);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.comboBox_Barcode);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.richTextBox_Output);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.button1);
            this.Name = "Form1";
            this.Text = "Encoder Sample";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.RichTextBox richTextBox_Output;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox comboBox_Barcode;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textBox_Font;
    }
}

