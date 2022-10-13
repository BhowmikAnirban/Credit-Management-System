(function () {
    "use strict";

    var appViewState = Windows.UI.ViewManagement.ApplicationViewState;
    var binding = WinJS.Binding;
    var nav = WinJS.Navigation;
    var ui = WinJS.UI;
    var utils = WinJS.Utilities;

    ui.Pages.define("/pages/split/split.html", {

        /// <field type="WinJS.Binding.List" />
        _items: null,
        _group: null,
        _itemSelectionIndex: -1,

        // This function is called whenever a user navigates to this page. It
        // populates the page elements with the app's data.
        ready: function (element, options) {
            var listView = element.querySelector(".itemlist").winControl;

            // Store information about the group and selection that this page will
            // display.
            this._group = (options && options.groupKey) ? Data.resolveGroupReference(options.groupKey) : Data.groups.getAt(0);
            this._items = Data.getItemsFromGroup(this._group);
            this._itemSelectionIndex = (options && "selectedIndex" in options) ? options.selectedIndex : -1;

            element.querySelector("header[role=banner] .pagetitle").textContent = this._group.title;

            // Set up the ListView.
            listView.itemDataSource = this._items.dataSource;
            listView.itemTemplate = element.querySelector(".itemtemplate");
            listView.onselectionchanged = this._selectionChanged.bind(this);
            listView.layout = new ui.ListLayout();

            this._updateVisibility();
            if (this._isSingleColumn()) {
                if (this._itemSelectionIndex >= 0) {
                    // For single-column detail view, load the article.
                    binding.processAll(element.querySelector(".articlesection"), this._items.getAt(this._itemSelectionIndex));
                }
            } else {
                if (nav.canGoBack && nav.history.backStack[nav.history.backStack.length - 1].location === "/pages/split/split.html") {
                    // Clean up the backstack to handle a user snapping, navigating
                    // away, unsnapping, and then returning to this page.
                    nav.history.backStack.pop();
                }
                // If this page has a selectionIndex, make that selection
                // appear in the ListView.
                listView.selection.set(Math.max(this._itemSelectionIndex, 0));
            }
        },

        unload: function () {
            this._items.dispose();
        },

        // This function updates the page layout in response to viewState changes.
        updateLayout: function (element, viewState, lastViewState) {
            /// <param name="element" domElement="true" />

            var listView = element.querySelector(".itemlist").winControl;
            var firstVisible = listView.indexOfFirstVisible;
            this._updateVisibility();

            var handler = function (e) {
                listView.removeEventListener("contentanimating", handler, false);
                e.preventDefault();
            }

            if (this._isSingleColumn()) {
                listView.selection.clear();
                if (this._itemSelectionIndex >= 0) {
                    // If the app has snapped into a single-column detail view,
                    // add the single-column list view to the backstack.
                    nav.history.current.state = {
                        groupKey: this._group.key,
                        selectedIndex: this._itemSelectionIndex
                    };
                    nav.history.backStack.push({
                        location: "/pages/split/split.html",
                        state: { groupKey: this._group.key }
                    });
                    element.querySelector(".articlesection").focus();
                } else {
                    listView.addEventListener("contentanimating", handler, false);
                    if (firstVisible >= 0 && listView.itemDataSource.list.length > 0) {
                        listView.indexOfFirstVisible = firstVisible;
                    }
                    listView.forceLayout();
                }
            } else {
                // If the app has unsnapped into the two-column view, remove any
                // splitPage instances that got added to the backstack.
                if (nav.canGoBack && nav.history.backStack[nav.history.backStack.length - 1].location === "/pages/split/split.html") {
                    nav.history.backStack.pop();
                }
                if (viewState !== lastViewState) {
                    listView.addEventListener("contentanimating", handler, false);
                    if (firstVisible >= 0 && listView.itemDataSource.list.length > 0) {
                        listView.indexOfFirstVisible = firstVisible;
                    }
                    listView.forceLayout();
                }

                listView.selection.set(this._itemSelectionIndex >= 0 ? this._itemSelectionIndex : Math.max(firstVisible, 0));
            }
        },

        // This function checks if the list and details columns should be displayed
        // on separate pages instead of side-by-side.
        _isSingleColumn: function () {
            var viewState = Windows.UI.ViewManagement.ApplicationView.value;
            return (viewState === appViewState.snapped || viewState === appViewState.fullScreenPortrait);
        },

        _selectionChanged: function (args) {
            var listView = document.body.querySelector(".itemlist").winControl;
            var details;
            // By default, the selection is restriced to a single item.
            listView.selection.getItems().done(function updateDetails(items) {
                if (items.length > 0) {
                    this._itemSelectionIndex = items[0].index;
                    if (this._isSingleColumn()) {
                        // If snapped or portrait, navigate to a new page containing the
                        // selected item's details.
                        nav.navigate("/pages/split/split.html", { groupKey: this._group.key, selectedIndex: this._itemSelectionIndex });
                    } else {
                        // If fullscreen or filled, update the details column with new data.
                        details = document.querySelector(".articlesection");
                        
                        var barcodeData = "12345678";
                        var fontFamily = "CCode39_S3_Trial";
                        if (this._itemSelectionIndex == 0)
                        {
                            barcodeData=Code39.ConnectCode_Encode_Code39(barcodeData,1);
                            fontFamily = "CCode39_S3_Trial";                            
                        }
                        else if (this._itemSelectionIndex == 1) {
                            barcodeData = Code39ASCII.ConnectCode_Encode_Code39ASCII(barcodeData, 1);
                            fontFamily = "CCode39_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 2) {
                            barcodeData = Code93.ConnectCode_Encode_Code93(barcodeData, 1);
                            fontFamily = "CCode93_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 3) {
                            barcodeData = "A123456A";
                            barcodeData = Codabar.ConnectCode_Encode_Codabar(barcodeData, 1);
                            fontFamily = "CCodeCodabar_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 4) {
                            barcodeData = Code128A.ConnectCode_Encode_Code128A(barcodeData);
                            fontFamily = "CCode128_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 5) {
                            barcodeData = Code128B.ConnectCode_Encode_Code128B(barcodeData);
                            fontFamily = "CCode128_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 6) {
                            barcodeData = Code128C.ConnectCode_Encode_Code128C(barcodeData);
                            fontFamily = "CCode128_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 7) {
                            barcodeData = Code128Auto.ConnectCode_Encode_Code128Auto(barcodeData);
                            fontFamily = "CCode128_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 8) {
                            barcodeData = "(10)12345678";
                            barcodeData = UCCEAN.ConnectCode_Encode_UCCEAN(barcodeData);
                            fontFamily = "CCode128_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 9) {
                            barcodeData = I2of5.ConnectCode_Encode_I2OF5(barcodeData, 1);
                            fontFamily = "CCodeI2of5_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 10) {
                            barcodeData = ITF14.ConnectCode_Encode_ITF14(barcodeData,1,0);
                            fontFamily = "CCodeITF_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 11) {
                            barcodeData = Industrial2of5.ConnectCode_Encode_Industrial2OF5(barcodeData, 1);
                            fontFamily = "CCodeIND2of5_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 12) {
                            barcodeData = ModifiedPlessy.ConnectCode_Encode_ModifiedPlessy(barcodeData, 1);
                            fontFamily = "CCodeMSI_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 13) {
                            //HR Off
                            barcodeData = EAN13.ConnectCode_Encode_EAN13(barcodeData, 0);
                            fontFamily = "CCodeUPCEAN_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 14) {
                            //HR On
                            barcodeData = EAN13.ConnectCode_Encode_EAN13(barcodeData, 1);
                            fontFamily = "CCodeUPCEAN_HRBS3_Trial";
                        }
                        else if (this._itemSelectionIndex == 15) {
                            //HR Off, Paramater not required
                            barcodeData = EAN8.ConnectCode_Encode_EAN8(barcodeData);
                            fontFamily = "CCodeUPCEAN_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 16) {
                            //HR On, PArameter not required
                            barcodeData = EAN8.ConnectCode_Encode_EAN8(barcodeData);
                            fontFamily = "CCodeUPCEAN_HRBS3_Trial";
                        }
                        else if (this._itemSelectionIndex == 17) {
                            //HR Off
                            barcodeData = UPCA.ConnectCode_Encode_UPCA(barcodeData,0);
                            fontFamily = "CCodeUPCEAN_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 18) {
                            //HR On
                            barcodeData = UPCA.ConnectCode_Encode_UPCA(barcodeData, 1);
                            fontFamily = "CCodeUPCEAN_HRBS3_Trial";
                        }
                        else if (this._itemSelectionIndex == 19) {
                            //HR Off
                            barcodeData = UPCE.ConnectCode_Encode_UPCE(barcodeData,0);
                            fontFamily = "CCodeUPCEAN_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 20) {
                            //HR On
                            barcodeData = UPCE.ConnectCode_Encode_UPCE(barcodeData, 1);
                            fontFamily = "CCodeUPCEAN_HRBS3_Trial";
                        }
                        else if (this._itemSelectionIndex == 21) {
                            barcodeData = "12";
                            //HR supported through change of fonts, Parameter not required
                            barcodeData = EXT2.ConnectCode_Encode_EXT2(barcodeData);
                            fontFamily = "CCodeUPCEAN_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 22) {
                            barcodeData = "12345";
                            //HR supported through change of fonts, Parameter not required
                            barcodeData = EXT5.ConnectCode_Encode_EXT5(barcodeData);
                            fontFamily = "CCodeUPCEAN_S3_Trial";
                        }
                        else if (this._itemSelectionIndex == 23) {
                            barcodeData = "12401234567898";
                            //HR supported through change of fonts, Parameter not required
                            barcodeData = GS1Databar14.ConnectCode_Encode_GS1Databar14(barcodeData,0);
                            fontFamily = "CCodeGS1D_S3_Trial";
                        }

                        document.querySelector(".barcode").textContent = barcodeData;
                        document.getElementById("barcodeOutput").style.fontFamily = fontFamily;

                        binding.processAll(details, items[0].data);
                        details.scrollTop = 0;
                    }
                }
            }.bind(this));
        },

        // This function toggles visibility of the two columns based on the current
        // view state and item selection.
        _updateVisibility: function () {
            var oldPrimary = document.querySelector(".primarycolumn");
            if (oldPrimary) {
                utils.removeClass(oldPrimary, "primarycolumn");
            }
            if (this._isSingleColumn()) {
                if (this._itemSelectionIndex >= 0) {
                    utils.addClass(document.querySelector(".articlesection"), "primarycolumn");
                    document.querySelector(".articlesection").focus();
                } else {
                    utils.addClass(document.querySelector(".itemlistsection"), "primarycolumn");
                    document.querySelector(".itemlist").focus();
                }
            } else {
                document.querySelector(".itemlist").focus();
            }
        }
    });
})();
