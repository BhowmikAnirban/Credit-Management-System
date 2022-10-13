/*
* ConnectCode
*
* Copyright (c) 2006-2014 ConnectCode Pte Ltd (http://www.barcoderesource.com)
* All Rights Reserved.
*
* This source code is protected by International Copyright Laws. You are only allowed to modify
* and include the source in your application if you have purchased a Distribution License.
*
* http://www.barcoderesource.com
*
*/
var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
var net;
(function (net) {
    (function (connectcode) {
        var Industrial2of5 = (function (_super) {
            __extends(Industrial2of5, _super);
            function Industrial2of5(data, checkDigit) {
                if (typeof checkDigit === "undefined") { checkDigit = false; }
                _super.call(this, data, checkDigit);
            }
            Industrial2of5.prototype.encode = function () {
                var Result = "";
                var cd = "";
                var filtereddata = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (this.checkDigit == true) {
                    if (filteredlength > 254) {
                        filtereddata = filtereddata.substr(0, 254);
                    }

                    cd = this.generateCheckDigit(filtereddata);
                } else {
                    if (filteredlength > 255) {
                        filtereddata = filtereddata.substr(0, 255);
                    }
                }

                filtereddata = filtereddata + cd;

                this.connectcode_human_readable_text = this.html_escape(filtereddata);

                Result = "{" + filtereddata + "}";
                Result = this.html_escape(Result);
                return Result;
            };

            Industrial2of5.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if ((data.charCodeAt(x) >= 48) && (data.charCodeAt(x) <= 57)) {
                        Result = Result + data.substr(x, 1);
                    }
                }

                return Result;
            };

            Industrial2of5.prototype.generateCheckDigit = function (data) {
                var datalength = 0;
                var lastcharpos = 0;
                var Result = 0;
                var strResult = "";
                var barcodechar = "";
                var barcodevalue = 0;
                var toggle = 1;
                var sum = 0;

                datalength = data.length;
                lastcharpos = datalength - 1;

                for (var x = lastcharpos; x >= 0; x--) {
                    barcodevalue = data.charCodeAt(x) - 48;

                    if (toggle == 1) {
                        sum = sum + (barcodevalue * 3);
                        toggle = 0;
                    } else {
                        sum = sum + barcodevalue;
                        toggle = 1;
                    }
                }
                if ((sum % 10) == 0) {
                    Result = 48;
                } else {
                    Result = (10 - (sum % 10)) + 48;
                }

                strResult = String.fromCharCode(Result);
                return strResult;
            };
            return Industrial2of5;
        })(connectcode.CCBarcode);
        connectcode.Industrial2of5 = Industrial2of5;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=industrial2of5.js.map
