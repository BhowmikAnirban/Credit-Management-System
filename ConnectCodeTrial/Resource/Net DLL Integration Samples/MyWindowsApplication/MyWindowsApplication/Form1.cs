using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Net.ConnectCode.Barcode;

namespace WindowsApplication2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            BarcodeFonts barcode = new BarcodeFonts();
            barcode.BarcodeType = BarcodeFonts.BarcodeEnum.Code39;
            barcode.Data = textBox1.Text;
            barcode.CheckDigit = BarcodeFonts.YesNoEnum.No;
            if (checkBox1.Checked)
                barcode.CheckDigit = BarcodeFonts.YesNoEnum.Yes;
            barcode.encode();
            textBox2.Text = barcode.HumanText;
            textBoxOutput.Text = barcode.EncodedData;
            Font font = new Font("CCode39_S3_Trial", 24);
            textBoxOutput.Font = font;


        }
    }
}