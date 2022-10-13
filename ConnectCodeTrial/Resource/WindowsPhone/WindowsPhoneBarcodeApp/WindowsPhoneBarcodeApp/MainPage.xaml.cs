using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Shell;
using WindowsPhoneBarcodeApp.Resources;
using Net.ConnectCode.Barcode;

namespace WindowsPhoneBarcodeApp
{
    public partial class MainPage : PhoneApplicationPage
    {
        // Constructor
        public MainPage()
        {
            InitializeComponent();

            // Sample code to localize the ApplicationBar
            //BuildLocalizedApplicationBar();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            BarcodeFonts barcode = new BarcodeFonts();
            barcode.BarcodeType = BarcodeFonts.BarcodeEnum.Code39;
            barcode.CheckDigit = BarcodeFonts.YesNoEnum.No;
            if (checkBox1.IsChecked==true)
                barcode.CheckDigit = BarcodeFonts.YesNoEnum.Yes;

            string fontFamily = "/Fonts/ConnectCode39_S3_Trial.ttf#CCode39_S3_Trial";
            string input = "12345678";
            string barcodeType = ((ListBoxItem) listBox.SelectedItem).Content.ToString();

            if (barcodeType == "Code 39")
            {
                fontFamily = "/Fonts/ConnectCode39_S3_Trial.ttf#CCode39_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code39;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "Code 39 ASCII")
            {
                fontFamily = "/Fonts/ConnectCode39_S3_Trial.ttf#CCode39_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code39ASCII;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "Code 128A")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code128A;
            }
            else if (barcodeType == "Code 128B")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code128B;
            }
            else if (barcodeType == "Code 128C")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code128C;
            }
            else if (barcodeType == "Code 128Auto")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code128Auto;
            }
            else if (barcodeType == "UCCEAN")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UCCEAN;
            }
            else if (barcodeType == "Code 93")
            {
                fontFamily = "/Fonts/ConnectCode93_S3_Trial.ttf#CCode93_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code93;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "Codabar")
            {
                fontFamily = "/Fonts/ConnectCodeCodabar_S3_Trial.ttf#CCodeCodabar_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.CodeCodabar;
            }
            else if (barcodeType == "I2of5")
            {
                fontFamily = "/Fonts/ConnectCodeI2of5_S3_Trial.ttf#CCodeI2of5_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.I2of5;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "ITF14")
            {
                fontFamily = "/Fonts/ConnectCodeITF_S3_Trial.ttf#CCodeITF_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.ITF14;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "Industrial2of5")
            {
                fontFamily = "/Fonts/ConnectCodeIND2of5_S3_Trial.ttf#CCodeIND2of5_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Industrial2of5;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "Modified Plessy")
            {
                fontFamily = "/Fonts/ConnectCodeMSI_S3_Trial.ttf#CCodeMSI_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.ModifiedPlessy;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "EAN13")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.No;
            }
            else if (barcodeType == "EAN13 - Human Readable")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "EAN8")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN8;
                //EAN8 does not require specification of HR
                //barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.No;
            }
            else if (barcodeType == "EAN8 - Human Readable")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN8;
                //EAN8 does not require specification of HR
                //barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "ISBN")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
                barcode.EANStandards = Net.ConnectCode.Barcode.BarcodeFonts.EANStandardsEnum.ISBN;
            }
            else if (barcodeType == "ISBN13")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
                barcode.EANStandards = Net.ConnectCode.Barcode.BarcodeFonts.EANStandardsEnum.ISBN13;
            }
            else if (barcodeType == "ISSN")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
                barcode.EANStandards = Net.ConnectCode.Barcode.BarcodeFonts.EANStandardsEnum.ISSN;
            }
            else if (barcodeType == "UPCA")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UPCA;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.No;
            }
            else if (barcodeType == "UPCA - Human Readable")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UPCA;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "UPCE")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UPCE;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.No;
            }
            else if (barcodeType == "UPCE - Human Readable")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UPCE;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (barcodeType == "EXT2")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EXT2;
                //EXT2 does not require specification of HR
            }
            else if (barcodeType == "EXT5")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EXT5;
                //EXT5 does not require specification of HR
            }
            else if (barcodeType == "GS1 Databar 14")
            {
                fontFamily = "/Fonts/ConnectCodeGS1D_S3_Trial.ttf#CCodeGS1D_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.GS1Databar14;
            }
            else //default to Code 39
            {
                fontFamily = "/Fonts/ConnectCode39_S3_Trial.ttf#CCode39_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code39;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }

            barcode.Data = input;
            textBoxOutput.FontFamily = new System.Windows.Media.FontFamily(fontFamily);
            textBoxOutput.FontSize = 36;
            barcode.encode();
            textBoxOutput.Text = barcode.EncodedData;

            //string humanText = barcode.HumanText;
            //string eanText = barcode.EANText;
           
        }

        private void listBox_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
        {
            string input = "12345678";
            if (listBox == null)
                return;
            string barcodeType = ((ListBoxItem)listBox.SelectedItem).Content.ToString();
            if (barcodeType == "UCCEAN")
            {
                input = "(01)12345678";
            }
            else if (barcodeType == "Codabar")
            {
                input = "A123456A";
            }
            else if (barcodeType == "GS1 Databar 14")
            {
                input = "12401234567898";
            }

            textBox1.Text = input;

        }

        // Sample code for building a localized ApplicationBar
        //private void BuildLocalizedApplicationBar()
        //{
        //    // Set the page's ApplicationBar to a new instance of ApplicationBar.
        //    ApplicationBar = new ApplicationBar();

        //    // Create a new button and set the text value to the localized string from AppResources.
        //    ApplicationBarIconButton appBarButton = new ApplicationBarIconButton(new Uri("/Assets/AppBar/appbar.add.rest.png", UriKind.Relative));
        //    appBarButton.Text = AppResources.AppBarButtonText;
        //    ApplicationBar.Buttons.Add(appBarButton);

        //    // Create a new menu item with the localized string from AppResources.
        //    ApplicationBarMenuItem appBarMenuItem = new ApplicationBarMenuItem(AppResources.AppBarMenuItemText);
        //    ApplicationBar.MenuItems.Add(appBarMenuItem);
        //}
    }
}