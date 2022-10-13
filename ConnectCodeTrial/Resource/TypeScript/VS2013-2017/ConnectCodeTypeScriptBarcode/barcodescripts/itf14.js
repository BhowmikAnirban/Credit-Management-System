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
        var ITF14 = (function (_super) {
            __extends(ITF14, _super);
            function ITF14(data, checkDigit, itfRectangle) {
                if (typeof checkDigit === "undefined") { checkDigit = false; }
                if (typeof itfRectangle === "undefined") { itfRectangle = false; }
                _super.call(this, data, checkDigit);
                this.itfRectangle = false;
                this.itfRectangle = itfRectangle;
            }
            ITF14.prototype.encode = function () {
                var Result = "";
                var cd = "";
                var filtereddata = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (this.checkDigit == true) {
                    if (filteredlength > 253) {
                        filtereddata = filtereddata.substr(0, 253);
                    }

                    if (filtereddata.length % 2 == 0) {
                        filtereddata = "0" + filtereddata;
                    }

                    cd = this.generateCheckDigit(filtereddata);
                } else {
                    if (filteredlength > 254) {
                        filtereddata = filtereddata.substr(0, 254);
                    }
                    if (filtereddata.length % 2 == 1) {
                        filtereddata = "0" + filtereddata;
                    }
                }
                filtereddata = filtereddata + cd;

                this.connectcode_human_readable_text = this.html_escape(filtereddata);

                var num = 0;
                for (var x = 0; x < filtereddata.length; x = x + 2) {
                    num = parseInt(filtereddata.substr(x, 2), 10);
                    Result = Result + this.getI2of5Character(num);
                }

                if (this.itfRectangle == true) {
                    var startITF = String.fromCharCode(124);
                    var stopITF = String.fromCharCode(126);
                    Result = startITF + Result + stopITF;
                } else {
                    Result = "{" + Result + "}";
                }
                Result = this.html_escape(Result);
                return Result;
            };

            ITF14.prototype.getI2of5Character = function (inputvalue) {
                if ((inputvalue <= 90) && (inputvalue >= 0)) {
                    inputvalue = inputvalue + 32;
                } else if ((inputvalue <= 99) && (inputvalue >= 91)) {
                    inputvalue = inputvalue + 100;
                } else {
                    inputvalue = -1;
                }
                return String.fromCharCode(inputvalue);
            };

            ITF14.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if ((data.charCodeAt(x) >= 48) && (data.charCodeAt(x) <= 57)) {
                        Result = Result + data.substr(x, 1);
                    }
                }

                return Result;
            };

            ITF14.prototype.generateCheckDigit = function (data) {
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
            return ITF14;
        })(connectcode.CCBarcode);
        connectcode.ITF14 = ITF14;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=itf14.js.map
