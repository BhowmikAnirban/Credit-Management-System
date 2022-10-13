using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;


namespace TestFont
{
    public partial class Form1 : Form
    {

        [DllImport("connectcodefont.dll", EntryPoint="Encode_Code128Auto")]
        public static extern int Encode_Code128Auto(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Code39")]
        public static extern int Encode_Code39(String instr, int checkdigit, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_POSTNET")]        
        public static extern int Encode_POSTNET(String instr, int checkdigit, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Code93")]        
        public static extern int Encode_Code93(String instr, int checkdigit, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Codabar")]        
        public static extern int Encode_Codabar(String instr, int checkdigit, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Code39Ascii")]        
        public static extern int Encode_Code39Ascii(String instr, int checkdigit, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_I2of5")]        
        public static extern int Encode_I2of5(String instr, int checkdigit, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_ITF14")]        
        public static extern int Encode_ITF14(String instr, int checkdigit, int bearer, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Industrial2of5")]        
        public static extern int Encode_Industrial2of5(String instr, int checkdigit, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_ModifiedPlessy")]        
        public static extern int Encode_ModifiedPlessy(String instr, int checkdigit, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_EAN13")]        
        public static extern int Encode_EAN13(String instr, int humantext, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "RetrieveOptionalString_EAN13")]        
        public static extern int RetrieveOptionalString_EAN13(String instr, int humantext, int strtype, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_UPCA")]        
        public static extern int Encode_UPCA(String instr, int humantext, StringBuilder outstr, int outstrmax);
	    [DllImport("connectcodefont.dll", EntryPoint = "Encode_EAN8")]        
        public static extern int Encode_EAN8(String instr, StringBuilder outstr, int outstrmax);
	    [DllImport("connectcodefont.dll", EntryPoint = "Encode_UCCEAN")]        
        public static extern int Encode_UCCEAN(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Code128A")]        
        public static extern int Encode_Code128A(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Code128B")]        
        public static extern int Encode_Code128B(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Code128C")]        
        public static extern int Encode_Code128C(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_UPCE")]        
        public static extern int Encode_UPCE(String instr, int humantext, StringBuilder outstr, int outstrmax);
	    [DllImport("connectcodefont.dll", EntryPoint = "Encode_EXT2")]        
        public static extern int Encode_EXT2(String instr, StringBuilder outstr, int outstrmax);
	    [DllImport("connectcodefont.dll", EntryPoint = "Encode_EXT5")]        
        public static extern int Encode_EXT5(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_GS1DataBar14")]
        public static extern int Encode_GS1DataBar14(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_GS1DataBarLimited")]
        public static extern int Encode_GS1DataBarLimited(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_GS1DataBarExpanded")]
        public static extern int Encode_GS1DataBarExpanded(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_GS1DataBarTruncated")]
        public static extern int Encode_GS1DataBarTruncated(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_GS1DataBarStacked")]
        public static extern int Encode_GS1DataBarStacked(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_GS1DataBarStackedOmni")]
        public static extern int Encode_GS1DataBarStackedOmni(String instr, StringBuilder outstr, int outstrmax);
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_GS1DataBarExpandedStacked")]
        public static extern int Encode_GS1DataBarExpandedStacked(String instr, int numSegmentsPerRow, StringBuilder outstr, int outstrmax);


        public Form1()
        {
            InitializeComponent();

            comboBox_Barcode.SelectedIndex = 0;
            textBox1.Text = "12345678";



        }

        private void button1_Click(object sender, EventArgs e)
        {

            String inputstr = textBox1.Text;            
            StringBuilder outputstr = new StringBuilder(2048);
            String barcodestr = comboBox_Barcode.Text;

            //MessageBox.Show(barcodestr);


            if (barcodestr == "Code 39")
            {

                textBox_Font.Text = "CCode39_S3_Trial";
                Encode_Code39(inputstr, 0, outputstr, outputstr.Capacity);
                
            }
            else if (barcodestr == "Postnet")
            {

                textBox_Font.Text = "CCodePostnet_Trial";
                Encode_POSTNET(inputstr, 0, outputstr, outputstr.Capacity);
                
            }
            else if (barcodestr == "Code 93")
            {

                textBox_Font.Text = "CCode93_S3_Trial";
                Encode_Code93(inputstr, 0, outputstr, outputstr.Capacity);                
                
            }
            else if (barcodestr == "Codabar")
            {

                textBox_Font.Text = "CCodeCodabar_S3_Trial";
                Encode_Codabar(inputstr, 0, outputstr, outputstr.Capacity);                                

            }
            else if (barcodestr == "Code 39 Ascii")
            {

                textBox_Font.Text = "CCode39_S3_Trial";
                Encode_Code39Ascii(inputstr, 0, outputstr, outputstr.Capacity);                                                

            }
            else if (barcodestr == "I2of5")
            {

                textBox_Font.Text = "CCodeI2of5_S3_Trial";
                Encode_I2of5(inputstr, 0, outputstr, outputstr.Capacity);                                                                    
                
            }
            else if (barcodestr == "ITF14")
            {
                textBox_Font.Text = "CCodeITF_S3_Trial";
                Encode_ITF14(inputstr, 0, 0, outputstr, outputstr.Capacity);    

            }
            else if (barcodestr == "Industrial 2of5")
            {
                textBox_Font.Text = "CCodeIND2of5_S3_Trial";
                Encode_Industrial2of5(inputstr, 0, outputstr, outputstr.Capacity);                    

            }
            else if (barcodestr == "Modified Plessy")
            {
                textBox_Font.Text = "CCodeMSI_S3_Trial";
                Encode_ModifiedPlessy(inputstr, 0, outputstr, outputstr.Capacity);                    
                
            }
            else if (barcodestr == "EAN13")
            {

                textBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial";
                //textBox_Font.Text ="CCodeUPCEAN_S3_Trial";               
                Encode_EAN13(inputstr, 1,outputstr, outputstr.Capacity);  

            }
            else if (barcodestr == "UPCA")
            {

                textBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial";
                //textBox_Font.Text = "CCodeUPCEAN_S3_Trial";
                Encode_UPCA(inputstr, 1, outputstr, outputstr.Capacity);  
                
            }
            else if (barcodestr == "EAN8")
            {
                
                //textBox_Font.Text = "CCodeUPCEAN_HRBS3";
                textBox_Font.Text = "CCodeUPCEAN_S3_Trial";
                Encode_EAN8(inputstr, outputstr, outputstr.Capacity);  
                
            }
            else if (barcodestr == "UCCEAN")
            {
                textBox_Font.Text = "CCode128_S3_Trial";
                Encode_UCCEAN(inputstr, outputstr, outputstr.Capacity);  
                
            }
            else if (barcodestr == "Code 128 Auto")
            {

                textBox_Font.Text = "CCode128_S3_Trial";
                Encode_Code128Auto(inputstr, outputstr, outputstr.Capacity);

                
            }
            else if (barcodestr == "Code 128A")
            {

                textBox_Font.Text = "CCode128_S3_Trial";
                Encode_Code128A(inputstr, outputstr, outputstr.Capacity);
                
            }
            else if (barcodestr == "Code 128B")
            {

                textBox_Font.Text = "CCode128_S3_Trial";
                Encode_Code128B(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Code 128C")
            {

                textBox_Font.Text = "CCode128_S3_Trial";
                Encode_Code128C(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "UPCE")
            {

                //textBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial";
                textBox_Font.Text = "CCodeUPCEAN_S3_Trial";

                Encode_UPCE(inputstr, 0, outputstr, outputstr.Capacity);               
                                
            }
            else if (barcodestr == "EXT2")
            {

                textBox_Font.Text = "CCodeUPCEAN_HRTS3_Trial";                
                //textBox_Font.Text = "CCodeUPCEAN_S3";
                Encode_EXT2(inputstr, outputstr, outputstr.Capacity);               
                
            }
            else if (barcodestr == "EXT5")
            {
                textBox_Font.Text = "CCodeUPCEAN_HRTS3_Trial";
                //textBox_Font.Text = "CCodeUPCEAN_S3";
                Encode_EXT5(inputstr, outputstr, outputstr.Capacity);               

            }
            else if (barcodestr == "GS1Databar14")
            {
                textBox_Font.Text = "CCodeGS1D_S3_Trial";
                
                Encode_GS1DataBar14(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarLimited")
            {
                textBox_Font.Text = "CCodeGS1D_S3_Trial";                
                Encode_GS1DataBarLimited(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarExpanded")
            {
                textBox_Font.Text = "CCodeGS1D_S3_Trial";                
                Encode_GS1DataBarExpanded(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarTruncated")
            {
                textBox_Font.Text = "CCodeGS1DTR_S3_Trial";                
                Encode_GS1DataBarTruncated(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarStacked")
            {
                textBox_Font.Text = "CCodeGS1DST_Trial";
                Encode_GS1DataBarStacked(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarStackedOmni")
            {
                textBox_Font.Text = "CCodeGS1DSTO_Trial";
                Encode_GS1DataBarStackedOmni(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarExpandedStacked")
            {
                int NumSegmentsPerRow = 4;
                textBox_Font.Text = "CCodeGS1DEST_Trial";
                Encode_GS1DataBarExpandedStacked(inputstr, NumSegmentsPerRow, outputstr, outputstr.Capacity);

            }

            textBox2.Text = outputstr.ToString();
            richTextBox_Output.Text = outputstr.ToString();
            richTextBox_Output.SelectAll();

            int fontsize = 24;
            if (barcodestr == "Postnet")
                fontsize = 9;

            if (barcodestr == "GS1DatabarStackedOmni")
                fontsize = 48;

            if (barcodestr == "GS1DatabarExpandedStacked")
                fontsize = 48;

            Font fx = new Font(textBox_Font.Text,fontsize);   
            richTextBox_Output.SelectionFont = fx;


        }

        private void comboBox_Barcode_selchange(object sender, EventArgs e)
        {

            String barcodestr = comboBox_Barcode.Text;
            if (barcodestr == "UCCEAN")
                textBox1.Text = "(10)12345678";
            else if (barcodestr == "GS1Databar14")
            {
                textBox1.Text = "12401234567898";
            }
            else if (barcodestr == "GS1DatabarLimited")
            {
                textBox1.Text = "15012345678907";
            }
            else if (barcodestr == "GS1DatabarExpanded")
            {
                textBox1.Text =  "(01)90012345678908(3103)001750";
            }
            else if (barcodestr == "GS1DatabarTruncated")
            {
                textBox1.Text = "12401234567898";
            }
            else if (barcodestr == "GS1DatabarStacked")
            {
                textBox1.Text = "83012345678953";
            }
            else if (barcodestr == "GS1DatabarStackedOmni")
            {
                textBox1.Text = "83012345678953";
            }
            else if (barcodestr == "GS1DatabarExpandedStacked")
            {
                textBox1.Text = "(01)98898765432106(3202)012345(15)991231";
            }

            

        }
    }
}