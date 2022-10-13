using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Runtime.InteropServices;


namespace TestFont_WPF
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>

    public partial class Window1 : System.Windows.Window
    {
        [DllImport("connectcodefont.dll", EntryPoint = "Encode_Code128Auto")]
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

        
        
       
        public Window1()
        {
            InitializeComponent();

            
            TextBox_Data.Text = "12345678";

            ComboBox_Barcode.Items.Add("Code 128 Auto");
            ComboBox_Barcode.Items.Add("Code 128A");
            ComboBox_Barcode.Items.Add("Code 128B");
            ComboBox_Barcode.Items.Add("Code 128C");
            ComboBox_Barcode.Items.Add("Code 39");
            ComboBox_Barcode.Items.Add("Code 39 Ascii");
            ComboBox_Barcode.Items.Add("Code 93");
            ComboBox_Barcode.Items.Add("Codabar");
            ComboBox_Barcode.Items.Add("I2of5");
            ComboBox_Barcode.Items.Add("Industrial 2of5");
            ComboBox_Barcode.Items.Add("ITF14");
            ComboBox_Barcode.Items.Add("EAN13");
            ComboBox_Barcode.Items.Add("EAN8");
            ComboBox_Barcode.Items.Add("EXT2");
            ComboBox_Barcode.Items.Add("EXT5");
            ComboBox_Barcode.Items.Add("Modified Plessy");
            ComboBox_Barcode.Items.Add("Postnet");
            ComboBox_Barcode.Items.Add("UCCEAN");
            ComboBox_Barcode.Items.Add("UPCA");
            ComboBox_Barcode.Items.Add("UPCE");
            ComboBox_Barcode.Items.Add("GS1Databar14");
            ComboBox_Barcode.Items.Add("GS1DatabarLimited");
            ComboBox_Barcode.Items.Add("GS1DatabarExpanded");
            ComboBox_Barcode.Items.Add("GS1DatabarTruncated");
            ComboBox_Barcode.Items.Add("GS1DatabarStacked");
            ComboBox_Barcode.Items.Add("GS1DatabarStackedOmni");
            ComboBox_Barcode.Items.Add("GS1DatabarExpandedStacked");
            ComboBox_Barcode.SelectedIndex = 0;

            richTextBox1.Document.PageWidth = 3000;
        }

        private void Encode(object sender, EventArgs e)
        {
            String inputstr = TextBox_Data.Text;
            StringBuilder outputstr = new StringBuilder(2048);
            String barcodestr = ComboBox_Barcode.Text;

    
            if (barcodestr == "Code 39")
            {

                TextBox_Font.Text = "CCode39_S3_Trial";
                Encode_Code39(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Postnet")
            {

                TextBox_Font.Text = "CCodePostnet_Trial";
                Encode_POSTNET(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Code 93")
            {

                TextBox_Font.Text = "CCode93_S3_Trial";
                Encode_Code93(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Codabar")
            {

                TextBox_Font.Text = "CCodeCodabar_S3_Trial";
                Encode_Codabar(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Code 39 Ascii")
            {

                TextBox_Font.Text = "CCode39_S3_Trial";
                Encode_Code39Ascii(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "I2of5")
            {

                TextBox_Font.Text = "CCodeI2of5_S3_Trial";
                Encode_I2of5(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "ITF14")
            {
                TextBox_Font.Text = "CCodeITF_S3_Trial";
                Encode_ITF14(inputstr, 0, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Industrial 2of5")
            {
                TextBox_Font.Text = "CCodeIND2of5_S3_Trial";
                Encode_Industrial2of5(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Modified Plessy")
            {
                TextBox_Font.Text = "CCodeMSI_S3_Trial";
                Encode_ModifiedPlessy(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "EAN13")
            {

                TextBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial";
                //textBox_Font.Text ="CCodeUPCEAN_S3";               
                Encode_EAN13(inputstr, 1, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "UPCA")
            {

                TextBox_Font.Text = "CCodeUPCEAN_HRBS3_Trial";
                //textBox_Font.Text = "CCodeUPCEAN_S3";
                Encode_UPCA(inputstr, 1, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "EAN8")
            {

                //textBox_Font.Text = "CCodeUPCEAN_HRBS3";
                TextBox_Font.Text = "CCodeUPCEAN_S3_Trial";
                Encode_EAN8(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "UCCEAN")
            {
                TextBox_Font.Text = "CCode128_S3_Trial";
                Encode_UCCEAN(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Code 128 Auto")
            {

                TextBox_Font.Text = "CCode128_S3_Trial";
                Encode_Code128Auto(inputstr, outputstr, outputstr.Capacity);


            }
            else if (barcodestr == "Code 128A")
            {

                TextBox_Font.Text = "CCode128_S3_Trial";
                Encode_Code128A(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Code 128B")
            {

                TextBox_Font.Text = "CCode128_S3_Trial";
                Encode_Code128B(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "Code 128C")
            {

                TextBox_Font.Text = "CCode128_S3_Trial";
                Encode_Code128C(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "UPCE")
            {

                //textBox_Font.Text = "CCodeUPCEAN_HRBS3";
                TextBox_Font.Text = "CCodeUPCEAN_S3_Trial";
                Encode_UPCE(inputstr, 0, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "EXT2")
            {

                TextBox_Font.Text = "CCodeUPCEAN_HRTS3_Trial";
                //TextBox_Font.Text = "CCodeUPCEAN_S3_Trial";
                Encode_EXT2(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "EXT5")
            {
                TextBox_Font.Text = "CCodeUPCEAN_HRTS3_Trial";
                //TextBox_Font.Text = "CCodeUPCEAN_S3_Trial";
                Encode_EXT5(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1Databar14")
            {
                TextBox_Font.Text = "CCodeGS1D_S3_Trial";
                Encode_GS1DataBar14(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarLimited")
            {
                TextBox_Font.Text = "CCodeGS1D_S3_Trial";
                Encode_GS1DataBarLimited(inputstr, outputstr, outputstr.Capacity);
            }
            else if (barcodestr == "GS1DatabarExpanded")
            {
                TextBox_Font.Text = "CCodeGS1D_S3_Trial";
                Encode_GS1DataBarExpanded(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarTruncated")
            {
                TextBox_Font.Text = "CCodeGS1DTR_S3_Trial";
                Encode_GS1DataBarTruncated(inputstr, outputstr, outputstr.Capacity);
            }
            else if (barcodestr == "GS1DatabarStacked")
            {
                TextBox_Font.Text = "CCodeGS1DST_Trial";
                Encode_GS1DataBarStacked(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarStackedOmni")
            {
                TextBox_Font.Text = "CCodeGS1DSTO_Trial";
                Encode_GS1DataBarStackedOmni(inputstr, outputstr, outputstr.Capacity);

            }
            else if (barcodestr == "GS1DatabarExpandedStacked")
            {
                int NumSegmentsPerRow = 4;
                TextBox_Font.Text = "CCodeGS1DEST_Trial";
                Encode_GS1DataBarExpandedStacked(inputstr, NumSegmentsPerRow, outputstr, outputstr.Capacity);

            }
             

            Textbox_Output.Text = outputstr.ToString();

            Run run = new Run(outputstr.ToString());
            richTextBox1.Document.Blocks.Clear();
            richTextBox1.Document.Blocks.Add(new Paragraph(run));            
            richTextBox1.SelectAll();

            int fontsize = 24;
            if (barcodestr == "Postnet")
                fontsize = 9;

            if (barcodestr == "GS1DatabarStackedOmni")
                fontsize = 48;

            if (barcodestr == "GS1DatabarExpandedStacked")
                fontsize = 48;

            TextRange range = richTextBox1.Selection;
            range.ApplyPropertyValue(TextElement.FontFamilyProperty, TextBox_Font.Text);
            range.ApplyPropertyValue(TextElement.FontSizeProperty, fontsize * 96.0d / 72.0d);


        }

        private void BarcodeSelChange(object sender, EventArgs e)
        {

            String barcodestr = (String) ComboBox_Barcode.SelectedItem;
            if (barcodestr == "UCCEAN")
                TextBox_Data.Text = "(10)12345678";
            else if (barcodestr == "GS1Databar14")
            {
                TextBox_Data.Text = "12401234567898";
            }
            else if (barcodestr == "GS1DatabarLimited")
            {
                TextBox_Data.Text = "15012345678907";
            }
            else if (barcodestr == "GS1DatabarExpanded")
            {
                TextBox_Data.Text ="(01)90012345678908(3103)001750";
            }
            else if (barcodestr == "GS1DatabarTruncated")
            {
                TextBox_Data.Text ="12401234567898";
            }
            else if (barcodestr == "GS1DatabarStacked")
            {
                TextBox_Data.Text = "83012345678953";
            }
            else if (barcodestr == "GS1DatabarStackedOmni")
            {
                TextBox_Data.Text = "83012345678953";
            }
            else if (barcodestr == "GS1DatabarExpandedStacked")
            {
                TextBox_Data.Text = "(01)98898765432106(3202)012345(15)991231";
            }


        }

    }
}