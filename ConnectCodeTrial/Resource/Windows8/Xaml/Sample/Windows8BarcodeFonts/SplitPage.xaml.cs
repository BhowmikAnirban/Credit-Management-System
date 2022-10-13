using Windows8BarcodeFonts.Data;

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.Graphics.Display;
using Windows.UI.ViewManagement;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;
using Windows.UI.Xaml.Documents;
using Windows.UI.Text;
using System.Globalization;

// The Split Page item template is documented at http://go.microsoft.com/fwlink/?LinkId=234234

namespace Windows8BarcodeFonts
{
    /// <summary>
    /// A page that displays a group title, a list of items within the group, and details for the
    /// currently selected item.
    /// </summary>
    public sealed partial class SplitPage : Windows8BarcodeFonts.Common.LayoutAwarePage
    {
        public SplitPage()
        {
            this.InitializeComponent();
        }

        #region Page state management

        /// <summary>
        /// Populates the page with content passed during navigation.  Any saved state is also
        /// provided when recreating a page from a prior session.
        /// </summary>
        /// <param name="navigationParameter">The parameter value passed to
        /// <see cref="Frame.Navigate(Type, Object)"/> when this page was initially requested.
        /// </param>
        /// <param name="pageState">A dictionary of state preserved by this page during an earlier
        /// session.  This will be null the first time a page is visited.</param>
        protected override void LoadState(Object navigationParameter, Dictionary<String, Object> pageState)
        {
            // TODO: Create an appropriate data model for your problem domain to replace the sample data
            var group = SampleDataSource.GetGroup((String)navigationParameter);
            this.DefaultViewModel["Group"] = group;
            this.DefaultViewModel["Items"] = group.Items;

            if (pageState == null)
            {
                this.itemListView.SelectedItem = null;
                // When this is a new page, select the first item automatically unless logical page
                // navigation is being used (see the logical page navigation #region below.)
                if (!this.UsingLogicalPageNavigation() && this.itemsViewSource.View != null)
                {
                    this.itemsViewSource.View.MoveCurrentToFirst();
                }
            }
            else
            {
                // Restore the previously saved state associated with this page
                if (pageState.ContainsKey("SelectedItem") && this.itemsViewSource.View != null)
                {
                    var selectedItem = SampleDataSource.GetItem((String)pageState["SelectedItem"]);
                    this.itemsViewSource.View.MoveCurrentTo(selectedItem);
                }
            }
        }

        /// <summary>
        /// Preserves state associated with this page in case the application is suspended or the
        /// page is discarded from the navigation cache.  Values must conform to the serialization
        /// requirements of <see cref="SuspensionManager.SessionState"/>.
        /// </summary>
        /// <param name="pageState">An empty dictionary to be populated with serializable state.</param>
        protected override void SaveState(Dictionary<String, Object> pageState)
        {
            if (this.itemsViewSource.View != null)
            {
                var selectedItem = (SampleDataItem)this.itemsViewSource.View.CurrentItem;
                if (selectedItem != null) pageState["SelectedItem"] = selectedItem.UniqueId;
            }
        }

        #endregion

        #region Logical page navigation

        // Visual state management typically reflects the four application view states directly
        // (full screen landscape and portrait plus snapped and filled views.)  The split page is
        // designed so that the snapped and portrait view states each have two distinct sub-states:
        // either the item list or the details are displayed, but not both at the same time.
        //
        // This is all implemented with a single physical page that can represent two logical
        // pages.  The code below achieves this goal without making the user aware of the
        // distinction.

        /// <summary>
        /// Invoked to determine whether the page should act as one logical page or two.
        /// </summary>
        /// <param name="viewState">The view state for which the question is being posed, or null
        /// for the current view state.  This parameter is optional with null as the default
        /// value.</param>
        /// <returns>True when the view state in question is portrait or snapped, false
        /// otherwise.</returns>
        private bool UsingLogicalPageNavigation(ApplicationViewState? viewState = null)
        {
            if (viewState == null) viewState = ApplicationView.Value;
            return viewState == ApplicationViewState.FullScreenPortrait ||
                viewState == ApplicationViewState.Snapped;
        }

        /// <summary>
        /// Invoked when an item within the list is selected.
        /// </summary>
        /// <param name="sender">The GridView (or ListView when the application is Snapped)
        /// displaying the selected item.</param>
        /// <param name="e">Event data that describes how the selection was changed.</param>
        void ItemListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            // Invalidate the view state when logical page navigation is in effect, as a change
            // in selection may cause a corresponding change in the current logical page.  When
            // an item is selected this has the effect of changing from displaying the item list
            // to showing the selected item's details.  When the selection is cleared this has the
            // opposite effect.
            SampleDataItem sdi = (SampleDataItem)(((ListView)sender).SelectedItem);
            //SampleDataItem sdi= sdg.Items.
            if (sdi == null)
                return;

            //RichEditBox reb = new RichEditBox();
            //itemREB = reb;
            itemREB.Foreground = new SolidColorBrush(Windows.UI.Colors.Black);
            double fontSize = 32;
            string input = "12345678";
            string fontFamily = "/Fonts/ConnectCode39_S3_Trial.ttf#CCode39_S3_Trial";
            Net.ConnectCode.Barcode.BarcodeFonts barcode = new Net.ConnectCode.Barcode.BarcodeFonts();

            if (sdi.UniqueId == "Code 39")
            {
                fontFamily = "/Fonts/ConnectCode39_S3_Trial.ttf#CCode39_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code39;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "Code 39 ASCII")
            {
                fontFamily = "/Fonts/ConnectCode39_S3_Trial.ttf#CCode39_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code39ASCII;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "Code 128A")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code128A;
            }
            else if (sdi.UniqueId == "Code 128B")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code128B;
            }
            else if (sdi.UniqueId == "Code 128C")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code128C;
            }
            else if (sdi.UniqueId == "Code 128Auto")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code128Auto;
            }
            else if (sdi.UniqueId == "UCCEAN")
            {
                fontFamily = "/Fonts/ConnectCode128_S3_Trial.ttf#CCode128_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UCCEAN;
                input = "(01)12345678";
            }
            else if (sdi.UniqueId == "Code 93")
            {
                fontFamily = "/Fonts/ConnectCode93_S3_Trial.ttf#CCode93_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code93;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "Codabar")
            {
                fontFamily = "/Fonts/ConnectCodeCodabar_S3_Trial.ttf#CCodeCodabar_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.CodeCodabar;
                input = "A123456A";
            }
            else if (sdi.UniqueId == "I2of5")
            {
                fontFamily = "/Fonts/ConnectCodeI2of5_S3_Trial.ttf#CCodeI2of5_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.I2of5;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "ITF14")
            {
                fontFamily = "/Fonts/ConnectCodeITF_S3_Trial.ttf#CCodeITF_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.ITF14;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "Industrial2of5")
            {
                fontFamily = "/Fonts/ConnectCodeIND2of5_S3_Trial.ttf#CCodeIND2of5_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Industrial2of5;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "Modified Plessy")
            {
                fontFamily = "/Fonts/ConnectCodeMSI_S3_Trial.ttf#CCodeMSI_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.ModifiedPlessy;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "EAN13")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.No;
            }
            else if (sdi.UniqueId == "EAN13HR")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "EAN8")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN8;
                //EAN8 does not require specification of HR
                //barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.No;
            }
            else if (sdi.UniqueId == "EAN8HR")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN8;
                //EAN8 does not require specification of HR
                //barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "ISBN")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
                barcode.EANStandards = Net.ConnectCode.Barcode.BarcodeFonts.EANStandardsEnum.ISBN;
            }
            else if (sdi.UniqueId == "ISBN13")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
                barcode.EANStandards = Net.ConnectCode.Barcode.BarcodeFonts.EANStandardsEnum.ISBN13;
            }
            else if (sdi.UniqueId == "ISSN")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EAN13;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
                barcode.EANStandards = Net.ConnectCode.Barcode.BarcodeFonts.EANStandardsEnum.ISSN;
            }
            else if (sdi.UniqueId == "UPCA")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UPCA;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.No;
            }
            else if (sdi.UniqueId == "UPCAHR")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UPCA;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "UPCE")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UPCE;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.No;
            }
            else if (sdi.UniqueId == "UPCEHR")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_HRBS3_Trial.ttf#CCodeUPCEAN_HRBS3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.UPCE;
                barcode.Extended = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }
            else if (sdi.UniqueId == "EXT2")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EXT2;
                //EXT2 does not require specification of HR
            }
            else if (sdi.UniqueId == "EXT5")
            {
                fontFamily = "/Fonts/ConnectCodeUPCEAN_S3_Trial.ttf#CCodeUPCEAN_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.EXT5;
                //EXT5 does not require specification of HR
            }
            else if (sdi.UniqueId == "GS1 Databar 14")
            {
                fontFamily = "/Fonts/ConnectCodeGS1D_S3_Trial.ttf#CCodeGS1D_S3_Trial";
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.GS1Databar14;
                input = "12401234567898";
            }
            else //default to Code 39
            {
                itemREB.FontFamily = new FontFamily("/Fonts/ConnectCode39_S3_Trial.ttf#CCode39_S3_Trial");
                barcode.BarcodeType = Net.ConnectCode.Barcode.BarcodeFonts.BarcodeEnum.Code39;
                barcode.CheckDigit = Net.ConnectCode.Barcode.BarcodeFonts.YesNoEnum.Yes;
            }

            barcode.Data = input;
            barcode.encode();
            string output = barcode.EncodedData;
            string humantextoutput = barcode.HumanText;
            //string isbnissntext = barcode.EANText;
            itemREB.Document.SetText(Windows.UI.Text.TextSetOptions.None, output);
            itemREB.Document.Selection.ParagraphFormat.Alignment = Windows.UI.Text.ParagraphAlignment.Center;
            itemREB.FontFamily = new FontFamily(fontFamily);
            itemREB.FontSize = fontSize;

            if (this.UsingLogicalPageNavigation()) this.InvalidateVisualState();
        }

        /// <summary>
        /// Invoked when the page's back button is pressed.
        /// </summary>
        /// <param name="sender">The back button instance.</param>
        /// <param name="e">Event data that describes how the back button was clicked.</param>
        protected override void GoBack(object sender, RoutedEventArgs e)
        {
            if (this.UsingLogicalPageNavigation() && itemListView.SelectedItem != null)
            {
                // When logical page navigation is in effect and there's a selected item that
                // item's details are currently displayed.  Clearing the selection will return
                // to the item list.  From the user's point of view this is a logical backward
                // navigation.
                this.itemListView.SelectedItem = null;
            }
            else
            {
                // When logical page navigation is not in effect, or when there is no selected
                // item, use the default back button behavior.
                base.GoBack(sender, e);
            }
        }

        /// <summary>
        /// Invoked to determine the name of the visual state that corresponds to an application
        /// view state.
        /// </summary>
        /// <param name="viewState">The view state for which the question is being posed.</param>
        /// <returns>The name of the desired visual state.  This is the same as the name of the
        /// view state except when there is a selected item in portrait and snapped views where
        /// this additional logical page is represented by adding a suffix of _Detail.</returns>
        protected override string DetermineVisualState(ApplicationViewState viewState)
        {
            // Update the back button's enabled state when the view state changes
            var logicalPageBack = this.UsingLogicalPageNavigation(viewState) && this.itemListView.SelectedItem != null;
            var physicalPageBack = this.Frame != null && this.Frame.CanGoBack;
            this.DefaultViewModel["CanGoBack"] = logicalPageBack || physicalPageBack;

            // Determine visual states for landscape layouts based not on the view state, but
            // on the width of the window.  This page has one layout that is appropriate for
            // 1366 virtual pixels or wider, and another for narrower displays or when a snapped
            // application reduces the horizontal space available to less than 1366.
            if (viewState == ApplicationViewState.Filled ||
                viewState == ApplicationViewState.FullScreenLandscape)
            {
                var windowWidth = Window.Current.Bounds.Width;
                if (windowWidth >= 1366) return "FullScreenLandscapeOrWide";
                return "FilledOrNarrow";
            }

            // When in portrait or snapped start with the default visual state name, then add a
            // suffix when viewing details instead of the list
            var defaultStateName = base.DetermineVisualState(viewState);
            return logicalPageBack ? defaultStateName + "_Detail" : defaultStateName;
        }

        #endregion
    }
}
