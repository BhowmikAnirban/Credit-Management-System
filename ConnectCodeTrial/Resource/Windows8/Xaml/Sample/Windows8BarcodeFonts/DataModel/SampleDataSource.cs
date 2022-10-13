using System;
using System.Linq;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using Windows.ApplicationModel.Resources.Core;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Media.Imaging;
using System.Collections.Specialized;

// The data model defined by this file serves as a representative example of a strongly-typed
// model that supports notification when members are added, removed, or modified.  The property
// names chosen coincide with data bindings in the standard item templates.
//
// Applications may use this model as a starting point and build on it, or discard it entirely and
// replace it with something appropriate to their needs.

namespace Windows8BarcodeFonts.Data
{
    /// <summary>
    /// Base class for <see cref="SampleDataItem"/> and <see cref="SampleDataGroup"/> that
    /// defines properties common to both.
    /// </summary>
    [Windows.Foundation.Metadata.WebHostHidden]
    public abstract class SampleDataCommon : Windows8BarcodeFonts.Common.BindableBase
    {
        private static Uri _baseUri = new Uri("ms-appx:///");

        public SampleDataCommon(String uniqueId, String title, String subtitle, String description)
        {
            this._uniqueId = uniqueId;
            this._title = title;
            this._subtitle = subtitle;
            this._description = description;
        }

        public SampleDataCommon(String uniqueId, String title, String input, String checkDigit, String humanReadable, String fontName, String fontSize, String description)
        {
            this._uniqueId = uniqueId;
            this._title = title;
            this._input = input;
            this._checkDigit = checkDigit;
            this._humanReadable = humanReadable;
            this._fontName = fontName;
            this._fontSize = fontSize;

            this._description = description;
        }

        private string _uniqueId = string.Empty;
        public string UniqueId
        {
            get { return this._uniqueId; }
            set { this.SetProperty(ref this._uniqueId, value); }
        }

        private string _title = string.Empty;
        public string Title
        {
            get { return this._title; }
            set { this.SetProperty(ref this._title, value); }
        }

        private string _subtitle = string.Empty;
        public string Subtitle
        {
            get { return this._subtitle; }
            set { this.SetProperty(ref this._subtitle, value); }
        }

        private string _input = string.Empty;
        public string Input
        {
            get { return this._input; }
            set { this.SetProperty(ref this._input, value); }
        }

        private string _checkDigit = string.Empty;
        public string CheckDigit
        {
            get { return this._checkDigit; }
            set { this.SetProperty(ref this._checkDigit, value); }
        }

        private string _humanReadable = string.Empty;
        public string HumanReadable
        {
            get { return this._humanReadable; }
            set { this.SetProperty(ref this._humanReadable, value); }
        }

        private string _fontName = string.Empty;
        public string FontName
        {
            get { return this._fontName; }
            set { this.SetProperty(ref this._fontName, value); }
        }

        private string _fontSize = string.Empty;
        public string FontSize
        {
            get { return this._fontSize; }
            set { this.SetProperty(ref this._fontSize, value); }
        }

        private string _description = string.Empty;
        public string Description
        {
            get { return this._description; }
            set { this.SetProperty(ref this._description, value); }
        }

        private ImageSource _image = null;
        private String _imagePath = null;
        public ImageSource Image
        {
            get
            {
                if (this._image == null && this._imagePath != null)
                {
                    this._image = new BitmapImage(new Uri(SampleDataCommon._baseUri, this._imagePath));
                }
                return this._image;
            }

            set
            {
                this._imagePath = null;
                this.SetProperty(ref this._image, value);
            }
        }

        public void SetImage(String path)
        {
            this._image = null;
            this._imagePath = path;
            this.OnPropertyChanged("Image");
        }

        public override string ToString()
        {
            return this.Title;
        }
    }

    /// <summary>
    /// Generic item data model.
    /// </summary>
    public class SampleDataItem : SampleDataCommon
    {
        public SampleDataItem(String uniqueId, String title, String subtitle, String description, String content, SampleDataGroup group)
            : base(uniqueId, title, subtitle, description)
        {
            this._content = content;
            this._group = group;
        }

        public SampleDataItem(String uniqueId, String title, String input, String checkDigit, String humanReadable, String fontName, String fontSize, String description, String content, SampleDataGroup group)
            : base(uniqueId, title, input, checkDigit, humanReadable, fontName, fontSize, description)
        {
            this._content = content;
            this._group = group;
        }

        private string _content = string.Empty;
        public string Content
        {
            get { return this._content; }
            set { this.SetProperty(ref this._content, value); }
        }

        private SampleDataGroup _group;
        public SampleDataGroup Group
        {
            get { return this._group; }
            set { this.SetProperty(ref this._group, value); }
        }
    }

    /// <summary>
    /// Generic group data model.
    /// </summary>
    public class SampleDataGroup : SampleDataCommon
    {
        public SampleDataGroup(String uniqueId, String title, String subtitle, String description)
            : base(uniqueId, title, subtitle, description)
        {
            Items.CollectionChanged += ItemsCollectionChanged;
        }

        private void ItemsCollectionChanged(object sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
        {
            // Provides a subset of the full items collection to bind to from a GroupedItemsPage
            // for two reasons: GridView will not virtualize large items collections, and it
            // improves the user experience when browsing through groups with large numbers of
            // items.
            //
            // A maximum of 12 items are displayed because it results in filled grid columns
            // whether there are 1, 2, 3, 4, or 6 rows displayed

            switch (e.Action)
            {
                case NotifyCollectionChangedAction.Add:
                    if (e.NewStartingIndex < 12)
                    {
                        TopItems.Insert(e.NewStartingIndex,Items[e.NewStartingIndex]);
                        if (TopItems.Count > 12)
                        {
                            TopItems.RemoveAt(12);
                        }
                    }
                    break;
                case NotifyCollectionChangedAction.Move:
                    if (e.OldStartingIndex < 12 && e.NewStartingIndex < 12)
                    {
                        TopItems.Move(e.OldStartingIndex, e.NewStartingIndex);
                    }
                    else if (e.OldStartingIndex < 12)
                    {
                        TopItems.RemoveAt(e.OldStartingIndex);
                        TopItems.Add(Items[11]);
                    }
                    else if (e.NewStartingIndex < 12)
                    {
                        TopItems.Insert(e.NewStartingIndex, Items[e.NewStartingIndex]);
                        TopItems.RemoveAt(12);
                    }
                    break;
                case NotifyCollectionChangedAction.Remove:
                    if (e.OldStartingIndex < 12)
                    {
                        TopItems.RemoveAt(e.OldStartingIndex);
                        if (Items.Count >= 12)
                        {
                            TopItems.Add(Items[11]);
                        }
                    }
                    break;
                case NotifyCollectionChangedAction.Replace:
                    if (e.OldStartingIndex < 12)
                    {
                        TopItems[e.OldStartingIndex] = Items[e.OldStartingIndex];
                    }
                    break;
                case NotifyCollectionChangedAction.Reset:
                    TopItems.Clear();
                    while (TopItems.Count < Items.Count && TopItems.Count < 12)
                    {
                        TopItems.Add(Items[TopItems.Count]);
                    }
                    break;
            }
        }

        private ObservableCollection<SampleDataItem> _items = new ObservableCollection<SampleDataItem>();
        public ObservableCollection<SampleDataItem> Items
        {
            get { return this._items; }
        }

        private ObservableCollection<SampleDataItem> _topItem = new ObservableCollection<SampleDataItem>();
        public ObservableCollection<SampleDataItem> TopItems
        {
            get {return this._topItem; }
        }
    }

    /// <summary>
    /// Creates a collection of groups and items with hard-coded content.
    /// 
    /// SampleDataSource initializes with placeholder data rather than live production
    /// data so that sample data is provided at both design-time and run-time.
    /// </summary>
    public sealed class SampleDataSource
    {
        private static SampleDataSource _sampleDataSource = new SampleDataSource();

        private ObservableCollection<SampleDataGroup> _allGroups = new ObservableCollection<SampleDataGroup>();
        public ObservableCollection<SampleDataGroup> AllGroups
        {
            get { return this._allGroups; }
        }

        public static IEnumerable<SampleDataGroup> GetGroups(string uniqueId)
        {
            if (!uniqueId.Equals("AllGroups")) throw new ArgumentException("Only 'AllGroups' is supported as a collection of groups");
            
            return _sampleDataSource.AllGroups;
        }

        public static SampleDataGroup GetGroup(string uniqueId)
        {
            // Simple linear search is acceptable for small data sets
            var matches = _sampleDataSource.AllGroups.Where((group) => group.UniqueId.Equals(uniqueId));
            if (matches.Count() == 1) return matches.First();
            return null;
        }

        public static SampleDataItem GetItem(string uniqueId)
        {
            // Simple linear search is acceptable for small data sets
            var matches = _sampleDataSource.AllGroups.SelectMany(group => group.Items).Where((item) => item.UniqueId.Equals(uniqueId));
            if (matches.Count() == 1) return matches.First();
            return null;
        }

        public SampleDataSource()
        {
            String ITEM_CONTENT = String.Format("Item Content: {0}\n\n{0}\n\n{0}\n\n{0}\n\n{0}\n\n{0}\n\n{0}",
                        "Curabitur class aliquam vestibulum nam curae maecenas sed integer cras phasellus suspendisse quisque donec dis praesent accumsan bibendum pellentesque condimentum adipiscing etiam consequat vivamus dictumst aliquam duis convallis scelerisque est parturient ullamcorper aliquet fusce suspendisse nunc hac eleifend amet blandit facilisi condimentum commodo scelerisque faucibus aenean ullamcorper ante mauris dignissim consectetuer nullam lorem vestibulum habitant conubia elementum pellentesque morbi facilisis arcu sollicitudin diam cubilia aptent vestibulum auctor eget dapibus pellentesque inceptos leo egestas interdum nulla consectetuer suspendisse adipiscing pellentesque proin lobortis sollicitudin augue elit mus congue fermentum parturient fringilla euismod feugiat");

            var group1 = new SampleDataGroup("Group-1",
                    "Barcodes",
                    "Group Subtitle: 1",
                    "Group Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus tempor scelerisque lorem in vehicula. Aliquam tincidunt, lacus ut sagittis tristique, turpis massa volutpat augue, eu rutrum ligula ante a ante");
            group1.Items.Add(new SampleDataItem("Code 39",
                    "Code 39",
                    "Input : 12345678",
                    "Check Digit : 1 (On)",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCode39_S3_Trial",
                    "Font Size : 32",
                    "Code 39 barcode is one of the earliest and most widely used barcode. It is a variable length barcode, which means that you will be able to encode any number of characters in the barcode. It supports alphanumeric characters and is used in a wide variety of applications.",
                    "Fonts with varying height supported :\n\nConnectCode39_S1.ttf#CCode39_S1\nConnectCode39_S2.ttf#CCode39_S2\nConnectCode39_S3.ttf#CCode39_S3\nConnectCode39_S4.ttf#CCode39_S4\nConnectCode39_S5.ttf#CCode39_S5\nConnectCode39_S6.ttf#CCode39_S6\nConnectCode39_S7.ttf#CCode39_S7\nConnectCode39_HS3.ttf#CCode39_HS3 - Embedded Human Readable Text",
                    group1));
            group1.Items.Add(new SampleDataItem("Code 39 ASCII",
                    "Code 39 ASCII",
                    "Input : 12345678",
                    "Check Digit : 1 (On)",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCode39_S3_Trial",
                    "Font Size : 32",
                    "Code 39 barcode is one of the earliest and most widely used barcode. It is a variable length barcode, which means that you will be able to encode any number of characters in the barcode. It supports alphanumeric characters and is used in a wide variety of applications.\n\nAlthough the Code 39 barcode only supports 43 characters, it is possible to employ a substitution mechanism based on industry specifications to encode all the 128 ASCII characters. The Code 39 barcode that employs this mechanism is known as the Code 39 Extended barcode or Code 39 ASCII barcode. ",
                    "Fonts with varying height supported :\n\nConnectCode39_S1.ttf#CCode39_S1\nConnectCode39_S2.ttf#CCode39_S2\nConnectCode39_S3.ttf#CCode39_S3\nConnectCode39_S4.ttf#CCode39_S4\nConnectCode39_S5.ttf#CCode39_S5\nConnectCode39_S6.ttf#CCode39_S6\nConnectCode39_S7.ttf#CCode39_S7\nConnectCode39_HS3.ttf#CCode39_HS3 - Embedded Human Readable Text",
                    group1));            
            group1.Items.Add(new SampleDataItem("Code 128A",
                    "Code 128A",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCode128_S3_Trial",
                    "Font Size : 32",
                    "Code 128 is one of the most popular modern barcodes. It is a very high density barcode supporting alphanumeric characters. This barcode is used as the basis for many other barcodes like UCC/EAN, HIBC(Health Industry Barcode) and the Blood Bank Industry barcode. \n\nOther than being high density, this barcode supports the ASCII character set. And is thus increasingly adopted in many different applications. This barcode has 106 unique representations and supports the Full ASCII by using a multiple character set mechanism. \n\nCharacter Set supported :\n\nCode128 Auto - Support Code 128 A/B/C characters. Automatically switch between the different code sets and performs characters optimization \nCode128A - ASCII without lowercase characters\nCode128B - ASCII without the initial ASCII special characters\nCode128C - Numeric",
                    "Fonts with varying height supported :\n\nConnectCode128_S1.ttf#CCode128_S1\nConnectCode128_S2.ttf#CCode128_S2\nConnectCode128_S3.ttf#CCode128_S3\nConnectCode128_S4.ttf#CCode128_S4\nConnectCode128_S5.ttf#CCode128_S5\nConnectCode128_S6.ttf#CCode128_S6\nConnectCode128_S7.ttf#CCode128_S7\nConnectCode128B_HS3.ttf#CCode128B_HS3 - Embedded Human Readable Text Font for Code128B",
                    group1));
            group1.Items.Add(new SampleDataItem("Code 128B",
                    "Code 128B",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCode128_S3_Trial",
                    "Font Size : 32",
                    "Code 128 is one of the most popular modern barcodes. It is a very high density barcode supporting alphanumeric characters. This barcode is used as the basis for many other barcodes like UCC/EAN, HIBC(Health Industry Barcode) and the Blood Bank Industry barcode. \n\nOther than being high density, this barcode supports the ASCII character set. And is thus increasingly adopted in many different applications. This barcode has 106 unique representations and supports the Full ASCII by using a multiple character set mechanism. \n\nCharacter Set supported :\n\nCode128 Auto - Support Code 128 A/B/C characters. Automatically switch between the different code sets and performs characters optimization \nCode128A - ASCII without lowercase characters\nCode128B - ASCII without the initial ASCII special characters\nCode128C - Numeric",
                    "Fonts with varying height supported :\n\nConnectCode128_S1.ttf#CCode128_S1\nConnectCode128_S2.ttf#CCode128_S2\nConnectCode128_S3.ttf#CCode128_S3\nConnectCode128_S4.ttf#CCode128_S4\nConnectCode128_S5.ttf#CCode128_S5\nConnectCode128_S6.ttf#CCode128_S6\nConnectCode128_S7.ttf#CCode128_S7\nConnectCode128B_HS3.ttf#CCode128B_HS3 - Embedded Human Readable Text Font for Code128B",
                    group1));
            group1.Items.Add(new SampleDataItem("Code 128C",
                    "Code 128C",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCode128_S3_Trial",
                    "Font Size : 32",
                    "Code 128 is one of the most popular modern barcodes. It is a very high density barcode supporting alphanumeric characters. This barcode is used as the basis for many other barcodes like UCC/EAN, HIBC(Health Industry Barcode) and the Blood Bank Industry barcode. \n\nOther than being high density, this barcode supports the ASCII character set. And is thus increasingly adopted in many different applications. This barcode has 106 unique representations and supports the Full ASCII by using a multiple character set mechanism. \n\nCharacter Set supported :\n\nCode128 Auto - Support Code 128 A/B/C characters. Automatically switch between the different code sets and performs characters optimization \nCode128A - ASCII without lowercase characters\nCode128B - ASCII without the initial ASCII special characters\nCode128C - Numeric",
                    "Fonts with varying height supported :\n\nConnectCode128_S1.ttf#CCode128_S1\nConnectCode128_S2.ttf#CCode128_S2\nConnectCode128_S3.ttf#CCode128_S3\nConnectCode128_S4.ttf#CCode128_S4\nConnectCode128_S5.ttf#CCode128_S5\nConnectCode128_S6.ttf#CCode128_S6\nConnectCode128_S7.ttf#CCode128_S7\nConnectCode128B_HS3.ttf#CCode128B_HS3 - Embedded Human Readable Text Font for Code128B",
                    group1));
            group1.Items.Add(new SampleDataItem("Code 128Auto",
                    "Code 128Auto",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCode128_S3_Trial",
                    "Font Size : 32",
                    "Code 128 is one of the most popular modern barcodes. It is a very high density barcode supporting alphanumeric characters. This barcode is used as the basis for many other barcodes like UCC/EAN, HIBC(Health Industry Barcode) and the Blood Bank Industry barcode. \n\nOther than being high density, this barcode supports the ASCII character set. And is thus increasingly adopted in many different applications. This barcode has 106 unique representations and supports the Full ASCII by using a multiple character set mechanism. \n\nCharacter Set supported :\n\nCode128 Auto - Support Code 128 A/B/C characters. Automatically switch between the different code sets and performs characters optimization \nCode128A - ASCII without lowercase characters\nCode128B - ASCII without the initial ASCII special characters\nCode128C - Numeric",
                    "Fonts with varying height supported :\n\nConnectCode128_S1.ttf#CCode128_S1\nConnectCode128_S2.ttf#CCode128_S2\nConnectCode128_S3.ttf#CCode128_S3\nConnectCode128_S4.ttf#CCode128_S4\nConnectCode128_S5.ttf#CCode128_S5\nConnectCode128_S6.ttf#CCode128_S6\nConnectCode128_S7.ttf#CCode128_S7\nConnectCode128B_HS3.ttf#CCode128B_HS3 - Embedded Human Readable Text Font for Code128B",
                    group1));
            group1.Items.Add(new SampleDataItem("UCCEAN",
                    "UCCEAN / GS1 128",
                    "Input : (10)12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCode128_S3_Trial",
                    "Font Size : 32",
                    "UCC EAN is an international barcode format used widely by many different companies. It uses a list of Application Identifiers (AI) for identifying the structure and format of the data in the barcode. For example, AI 00 is used for identifying a 18 digits Serial Shipping Container Code. \n\nThe UCC/EAN uses the Code 128 barcode font and specifically the Code 128 Auto character set. ",
                    "Fonts with varying height supported :\n\nConnectCode128_S1.ttf#CCode128_S1\nConnectCode128_S2.ttf#CCode128_S2\nConnectCode128_S3.ttf#CCode128_S3\nConnectCode128_S4.ttf#CCode128_S4\nConnectCode128_S5.ttf#CCode128_S5\nConnectCode128_S6.ttf#CCode128_S6\nConnectCode128_S7.ttf#CCode128_S7",
                    group1));
            group1.Items.Add(new SampleDataItem("Code 93",
                    "Code 93",
                    "Input : 12345678",
                    "Check Digit : 1 (On)",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCode93_S3_Trial",
                    "Font Size : 32",
                    "Code 93 is a high density barcode that contains two check characters called the C and K check characters. The regular Code 93 barcode supports 47 characters as below. \n\nNumerics '0'..'9'\nUppercase Alphabets 'A'..'Z'\nPunctuations ' ','$','%','+','-','.','/'\n\nThis barcode can also be extended using four shift characters to uniquely represent all the 128 ASCII characters. ConnectCode Code 93 barcode font/encoder supports both the basic and extended version of the barcode. ",
                    "Fonts with varying height supported :\n\nConnectCode93_S1.ttf#CCode93_S1\nConnectCode93_S2.ttf#CCode93_S2\nConnectCode93_S3.ttf#CCode93_S3\nConnectCode93_S4.ttf#CCode93_S4\nConnectCode93_S5.ttf#CCode93_S5\nConnectCode93_S6.ttf#CCode93_S6\nConnectCode93_S7.ttf#CCode93_S7",
                    group1));
            group1.Items.Add(new SampleDataItem("Codabar",
                    "Codabar",
                    "Input : A123456A",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCodeCodabar_S3_Trial",
                    "Font Size : 32",
                    "Codabar is a barcode that is commonly used in blood banks and libraries applications. It supports 16 characters and uses the characters 'A', 'B', 'C', 'D' as start and stop characters. This barcode is also sometimes called Rationalized Codabar or USS-Codabar.",
                    "Fonts with varying height supported :\n\nConnectCodeCodabar_S1.ttf#CCodeCodabar_S1\nConnectCodeCodabar_S2.ttf#CCodeCodabar_S2\nConnectCodeCodabar_S3.ttf#CCodeCodabar_S3\nConnectCodeCodabar_S4.ttf#CCodeCodabar_S4\nConnectCodeCodabar_S5.ttf#CCodeCodabar_S5\nConnectCodeCodabar_S6.ttf#CCodeCodabar_S6\nConnectCodeCodabar_S7.ttf#CCodeCodabar_S7",
                    group1));
            group1.Items.Add(new SampleDataItem("I2of5",
                    "I2of5",
                    "Input : 12345678",
                    "Check Digit : 1 (On)",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCodeI2of5_S3_Trial",
                    "Font Size : 32",
                    "I2of5 (Interleaved 2 of 5) is a widely used, high density barcode supporting numeric characters. The data to be encoded must contain even number of digits as each two digit numbers is uniquely represented by a set of bars and spaces in the barcode. The character '0' may be added to the beginning if the data does not contain an even number of digits.",
                    "Fonts with varying height supported :\n\nConnectCodeI2of5_S1.ttf#CCodeI2of5_S1\nConnectCodeI2of5_S2.ttf#CCodeI2of5_S2\nConnectCodeI2of5_S3.ttf#CCodeI2of5_S3\nConnectCodeI2of5_S4.ttf#CCodeI2of5_S4\nConnectCodeI2of5_S5.ttf#CCodeI2of5_S5\nConnectCodeI2of5_S6.ttf#CCodeI2of5_S6\nConnectCodeI2of5_S7.ttf#CCodeI2of5_S7\nConnectCodeI2of5_HS3.ttf#CCodeI2of5_HS3 - Embedded Human Readable Text",
                    group1));
            group1.Items.Add(new SampleDataItem("ITF14",
                    "ITF14",
                    "Input : 12345678",
                    "Check Digit : 1 (On)",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCodeITF_S3_Trial",
                    "Font Size : 32",
                    "The ITF14 is a 14 digits barcode used to mark the external containers of products with a EAN identifier. It is based on the I2of5 barcode. ITF14 barcodes usually contain a top and bottom bar (sometimes rectangle) called the Bearers bar. The purpose of the Bearers bar is to make sure that the barcode is read completely.",
                    "Fonts with varying height supported :\n\nConnectCodeITF_S1.ttf#CCodeITF_S1\nConnectCodeITF_S2.ttf#CCodeITF_S2\nConnectCodeITF_S3.ttf#CCodeITF_S3\nConnectCodeITF_S4.ttf#CCodeITF_S4\nConnectCodeITF_S5.ttf#CCodeITF_S5\nConnectCodeITF_S6.ttf#CCodeITF_S6\nConnectCodeITF_S7.ttf#CCodeITF_S7",
                    group1));
            group1.Items.Add(new SampleDataItem("Industrial2of5",
                    "Industrial2of5",
                    "Input : 12345678",
                    "Check Digit : 1 (On)",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCodeIND2of5_S3_Trial",
                    "Font Size : 32",
                    "The Industrial 2of5 barcode is used for encoding numbers. It is called 2of5 because the barcode is always encoded with 2 wide bars and 3 narrow bars (total of 5 bars). Each of the bars is separated by a narrow space.",
                    "Fonts with varying height supported :\n\nConnectCodeIND2of5_S1.ttf#CCodeIND2of5_S1\nConnectCodeIND2of5_S2.ttf#CCodeIND2of5_S2\nConnectCodeIND2of5_S3.ttf#CCodeIND2of5_S3\nConnectCodeIND2of5_S4.ttf#CCodeIND2of5_S4\nConnectCodeIND2of5_S5.ttf#CCodeIND2of5_S5\nConnectCodeIND2of5_S6.ttf#CCodeIND2of5_S6\nConnectCodeIND2of5_S7.ttf#CCodeIND2of5_S7",
                    group1));
            group1.Items.Add(new SampleDataItem("Modified Plessy",
                    "Modified Plessy",
                    "Input : 12345678",
                    "Check Digit : 1 (On)",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCodeMSI_S3_Trial",
                    "Font Size : 32",
                    "The Modified Plessy (MSI) barcode is used for encoding numbers and is typically used warehouses for the control of inventory. This symbology is developed by MSI Data Corporation. ",
                    "Fonts with varying height supported :\n\nConnectCodeMSI_S1.ttf#CCodeMSI_S1\nConnectCodeMSI_S2.ttf#CCodeMSI_S2\nConnectCodeMSI_S3.ttf#CCodeMSI_S3\nConnectCodeMSI_S4.ttf#CCodeMSI_S4\nConnectCodeMSI_S5.ttf#CCodeMSI_S5\nConnectCodeMSI_S6.ttf#CCodeMSI_S6\nConnectCodeMSI_S7.ttf#CCodeMSI_S7",
                    group1));
            group1.Items.Add(new SampleDataItem("EAN13",
                    "EAN13 (European Article Numbering)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 0 (Off)",
                    "Font Name : CCodeUPCEAN_S3_Trial",
                    "Font Size : 32",
                    "13 digits European Article Numbering barcode. This barcode is used to identify each product with a unique code internationally. It consists of a 2 digits Country Code, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit. The ISBN(International Standard Book Number) barcode and ISSN (International Standard Serial Number) barcode uses EAN13 as the underlying barcode. For ISBN, the 13 digits starts with 978(or 979. Sunrise 2005 Compliance) while for ISSN it starts with 977.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("EAN13HR",
                    "EAN13 (with Embedded Text)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 1 (On)",
                    "Font Name : CCodeUPCEAN_HRBS3_Trial",
                    "Font Size : 32",
                    "13 digits European Article Numbering barcode. This barcode is used to identify each product with a unique code internationally. It consists of a 2 digits Country Code, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit. The ISBN(International Standard Book Number) barcode and ISSN (International Standard Serial Number) barcode uses EAN13 as the underlying barcode. For ISBN, the 13 digits starts with 978(or 979. Sunrise 2005 Compliance) while for ISSN it starts with 977.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("EAN8",
                    "EAN8 (European Article Numbering)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 0 (Off)",
                    "Font Name : CCodeUPCEAN_S3_Trial",
                    "Font Size : 32",
                    "8 digits European Article Numbering barcode. It consists of 2 digits Country Code, 5 digits Product Code and 1 Check Digit.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("EAN8HR",
                    "EAN8 (with Embedded Text)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 1 (On)",
                    "Font Name : CCodeUPCEAN_HRBS3_Trial",
                    "Font Size : 32",
                    "8 digits European Article Numbering barcode. It consists of 2 digits Country Code, 5 digits Product Code and 1 Check Digit.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("ISBN",
                    "ISBN (International Standard Book Number)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 1 (On)",
                    "Font Name : CCodeUPCEAN_HRBS3_Trial",
                    "Font Size : 32",
                    "13 digits European Article Numbering barcode. This barcode is used to identify each product with a unique code internationally. It consists of a 2 digits Country Code, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit. The ISBN(International Standard Book Number) barcode and ISSN (International Standard Serial Number) barcode uses EAN13 as the underlying barcode. For ISBN, the 13 digits starts with 978(or 979. Sunrise 2005 Compliance) while for ISSN it starts with 977.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("ISBN13",
                    "ISBN13 (International Standard Book Number 13)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 1 (On)",
                    "Font Name : CCodeUPCEAN_HRBS3_Trial",
                    "Font Size : 32",
                    "13 digits European Article Numbering barcode. This barcode is used to identify each product with a unique code internationally. It consists of a 2 digits Country Code, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit. The ISBN(International Standard Book Number) barcode and ISSN (International Standard Serial Number) barcode uses EAN13 as the underlying barcode. For ISBN, the 13 digits starts with 978(or 979. Sunrise 2005 Compliance) while for ISSN it starts with 977.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("ISSN",
                    "ISSN (International Standard Serial Number)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 1 (On)",
                    "Font Name : CCodeUPCEAN_HRBS3_Trial",
                    "Font Size : 32",
                    "13 digits European Article Numbering barcode. This barcode is used to identify each product with a unique code internationally. It consists of a 2 digits Country Code, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit. The ISBN(International Standard Book Number) barcode and ISSN (International Standard Serial Number) barcode uses EAN13 as the underlying barcode. For ISBN, the 13 digits starts with 978(or 979. Sunrise 2005 Compliance) while for ISSN it starts with 977.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("UPCA",
                    "UPCA (Universal Product Code)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 0 (Off)",
                    "Font Name : CCodeUPCEAN_S3_Trial",
                    "Font Size : 32",
                    "12 digits Universal Product Code. This barcode is used to identify each product with a unique code. It consists of a 1 digit Numbering System, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("UPCAHR",
                    "UPCA (with Embedded Text)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 1 (On)",
                    "Font Name : CCodeUPCEAN_S3_Trial",
                    "Font Size : 32",
                    "12 digits Universal Product Code. This barcode is used to identify each product with a unique code. It consists of a 1 digit Numbering System, 5 digits Manufacturer's code, 5 digits Product Code and 1 Check Digit.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("UPCE",
                    "UPCE (Universal Product Code)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 0 (Off)",
                    "Font Name : CCodeUPCEAN_S3_Trial",
                    "Font Size : 32",
                    "A 6 digits condensed version of UPCA. This barcode is typically used on items where space is a constraint.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("UPCEHR",
                    "UPCE (with Embedded Text)",
                    "Input : 12345678",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 1 (On)",
                    "Font Name : CCodeUPCEAN_S3_Trial",
                    "Font Size : 32",
                    "A 6 digits condensed version of UPCA. This barcode is typically used on items where space is a constraint.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("EXT2",
                    "EXT2",
                    "Input : 12",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 0 (Off)",
                    "Font Name : CCodeUPCEAN_S3_Trial",
                    "Font Size : 32",
                    "Extension 2 barcode. To indicate issue number of magazines.",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("EXT5",
                    "EXT5",
                    "Input : 12345",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : 0 (Off)",
                    "Font Name : CCodeUPCEAN_S3_Trial",
                    "Font Size : 32",
                    "Extension 5 barcode. To indicate suggested retail price of books and magazines. Typically used with ISBN(International Standard Book Number).",
                    "Fonts with varying height supported :\n\nConnectCodeUPCEAN_S1.ttf#CCodeUPCEAN_S1\nConnectCodeUPCEAN_S2.ttf#CCodeUPCEAN_S2\nConnectCodeUPCEAN_S3.ttf#CCodeUPCEAN_S3\nConnectCodeUPCEAN_S4.ttf#CCodeUPCEAN_S4\nConnectCodeUPCEAN_S5.ttf#CCodeUPCEAN_S5\nConnectCodeUPCEAN_S6.ttf#CCodeUPCEAN_S6\nConnectCodeUPCEAN_S7.ttf#CCodeUPCEAN_S7\n\nFonts with Text at the Bottom of the barcode :\n\nConnectCodeUPCEAN_HRBS1.ttf#CCodeUPCEAN_HRBS1\nConnectCodeUPCEAN_HRBS2.ttf#CCodeUPCEAN_HRBS2\nConnectCodeUPCEAN_HRBS3.ttf#CCodeUPCEAN_HRBS3\nConnectCodeUPCEAN_HRBS4.ttf#CCodeUPCEAN_HRBS4\nConnectCodeUPCEAN_HRBS5.ttf#CCodeUPCEAN_HRBS5\nConnectCodeUPCEAN_HRBS6.ttf#CCodeUPCEAN_HRBS6\nConnectCodeUPCEAN_HRBS7.ttf#CCodeUPCEAN_HRBS7\n\nFonts with Text at the Top of the barcode :\n\nConnectCodeUPCEAN_HRTS1.ttf#CCodeUPCEAN_HRTS1\nConnectCodeUPCEAN_HRTS2.ttf#CCodeUPCEAN_HRTS2\nConnectCodeUPCEAN_HRTS3.ttf#CCodeUPCEAN_HRTS3",
                    group1));
            group1.Items.Add(new SampleDataItem("GS1 Databar 14",
                    "GS1 Databar 14",
                    "Input : 12401234567898",
                    "Check Digit : N.A.",
                    "Embedded Human Readable Text : N.A.",
                    "Font Name : CCodeGS1D_S3_Trial",
                    "Font Size : 32",
                    "The GS1 Databar is a family of barcodes based on the ISO/IEC 24724:2006 specifications to be used with the UCC/EAN system. The barcode is intended for encoding the identification numbers of items and their supplementary data. It is more compact and can carry more information than the current EAN/UPC barcode and is thus capable of identifying small items more easily. \n\nAs the EAN/UCC system is defined in a consistent manner around the world, it is extremely useful for the identification of trade items.\n\nGS1 Databar 14 (formerly Reduced Space Symbology RSS14) - Encodes the 14 digits EAN/UCC item identification. ",
                    "Fonts with varying height supported :\n\nConnectCodeGS1D_S1.ttf#CCodeGS1D_S1\nConnectCodeGS1D_S2.ttf#CCodeGS1D_S2\nConnectCodeGS1D_S3.ttf#CCodeGS1D_S3\nConnectCodeGS1D_S4.ttf#CCodeGS1D_S4\nConnectCodeGS1D_S5.ttf#CCodeGS1D_S5\nConnectCodeGS1D_S6.ttf#CCodeGS1D_S6\nConnectCodeGS1D_S7.ttf#CCodeGS1D_S7",
                    group1));
            this.AllGroups.Add(group1);

        }
    }
}
