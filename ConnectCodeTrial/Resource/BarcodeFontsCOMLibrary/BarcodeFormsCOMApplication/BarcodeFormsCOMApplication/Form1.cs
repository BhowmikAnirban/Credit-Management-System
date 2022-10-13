using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {

                Type comObjectType = Type.GetTypeFromProgID("ConnectCode.BarcodeFontsCOMLibrary");
                dynamic theComObject = Activator.CreateInstance(comObjectType, false);

                //or
                //Guid myGuid = new Guid("54A6DF68-D958-4D28-BDD4-8F26C367721F");
                //Type comObjectType = Type.GetTypeFromCLSID(myGuid);
                //dynamic theComObject = Activator.CreateInstance(comObjectType, false);

                string inputData = "12345678";

                string result1 = theComObject.Encode_Code128Auto(inputData);
                /*
                string result2 = theComObject.Encode_Code128A(inputData);
                string result3 = theComObject.Encode_Code128B(inputData);
                string result4 = theComObject.Encode_Code128C(inputData);
                string result5 = theComObject.Encode_Code39(inputData, 1);
                string result6 = theComObject.Encode_Code39ASCII(inputData, 1);
                string result7 = theComObject.Encode_Code93(inputData, 1);
                string result8 = theComObject.Encode_CodeCodabar(inputData);
                string result9 = theComObject.Encode_EAN13(inputData, 1); //1-Embedded Human Readable Text
                string result10 = theComObject.Encode_EAN8(inputData);
                string result11 = theComObject.Encode_EXT2(inputData);
                string result12 = theComObject.Encode_EXT5(inputData);
                string result13 = theComObject.Encode_GS1Databar14(inputData);
                string result14 = theComObject.Encode_I2of5(inputData, 1);
                string result15 = theComObject.Encode_Industrial2of5(inputData, 1);
                string result16 = theComObject.Encode_ModifiedPlessy(inputData, 1);
                string result17 = theComObject.Encode_POSTNET(inputData);
                string result18 = theComObject.Encode_UCC("(01)123456789012345678)");
                string result19 = theComObject.Encode_UPCA(inputData, 1); //1-Embedded Human Readable Text
                string result20 = theComObject.Encode_UPCE(inputData, 1); //1-Embedded Human Readable Text
                System.Diagnostics.Debug.WriteLine(result);
                */
                string result = result1;
                textBox1.Text = result;

                /*
                System.Diagnostics.Debug.WriteLine(result1);
                System.Diagnostics.Debug.WriteLine(result2);
                System.Diagnostics.Debug.WriteLine(result3);
                System.Diagnostics.Debug.WriteLine(result4);
                System.Diagnostics.Debug.WriteLine(result5);
                System.Diagnostics.Debug.WriteLine(result6);
                System.Diagnostics.Debug.WriteLine(result7);
                System.Diagnostics.Debug.WriteLine(result8);
                System.Diagnostics.Debug.WriteLine(result9);
                System.Diagnostics.Debug.WriteLine(result10);
                System.Diagnostics.Debug.WriteLine(result11);
                System.Diagnostics.Debug.WriteLine(result12);
                System.Diagnostics.Debug.WriteLine(result13);
                System.Diagnostics.Debug.WriteLine(result14);
                System.Diagnostics.Debug.WriteLine(result15);
                System.Diagnostics.Debug.WriteLine(result16);
                System.Diagnostics.Debug.WriteLine(result17);
                System.Diagnostics.Debug.WriteLine(result18);
                System.Diagnostics.Debug.WriteLine(result19);
                System.Diagnostics.Debug.WriteLine(result20);
                */
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

            }

        }
    }
}
