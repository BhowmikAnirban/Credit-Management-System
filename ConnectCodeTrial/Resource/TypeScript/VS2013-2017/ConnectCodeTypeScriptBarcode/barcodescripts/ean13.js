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
        var EAN13 = (function (_super) {
            __extends(EAN13, _super);
            function EAN13(data, hr) {
                if (typeof hr === "undefined") { hr = false; }
                _super.call(this, data, false);
                this.hr = false;
                this.hr = hr;
            }
            EAN13.prototype.encode = function () {
                var EAN13PARITYMAP = new Array(10);
                EAN13PARITYMAP[0] = new Array(6);
                EAN13PARITYMAP[1] = new Array(6);
                EAN13PARITYMAP[2] = new Array(6);
                EAN13PARITYMAP[3] = new Array(6);
                EAN13PARITYMAP[4] = new Array(6);
                EAN13PARITYMAP[5] = new Array(6);
                EAN13PARITYMAP[6] = new Array(6);
                EAN13PARITYMAP[7] = new Array(6);
                EAN13PARITYMAP[8] = new Array(6);
                EAN13PARITYMAP[9] = new Array(6);

                EAN13PARITYMAP[0][0] = 0;
                EAN13PARITYMAP[0][1] = 0;
                EAN13PARITYMAP[0][2] = 0;
                EAN13PARITYMAP[0][3] = 0;
                EAN13PARITYMAP[0][4] = 0;
                EAN13PARITYMAP[0][5] = 0;

                EAN13PARITYMAP[1][0] = 0;
                EAN13PARITYMAP[1][1] = 0;
                EAN13PARITYMAP[1][2] = 1;
                EAN13PARITYMAP[1][3] = 0;
                EAN13PARITYMAP[1][4] = 1;
                EAN13PARITYMAP[1][5] = 1;

                EAN13PARITYMAP[2][0] = 0;
                EAN13PARITYMAP[2][1] = 0;
                EAN13PARITYMAP[2][2] = 1;
                EAN13PARITYMAP[2][3] = 1;
                EAN13PARITYMAP[2][4] = 0;
                EAN13PARITYMAP[2][5] = 1;

                EAN13PARITYMAP[3][0] = 0;
                EAN13PARITYMAP[3][1] = 0;
                EAN13PARITYMAP[3][2] = 1;
                EAN13PARITYMAP[3][3] = 1;
                EAN13PARITYMAP[3][4] = 1;
                EAN13PARITYMAP[3][5] = 0;

                EAN13PARITYMAP[4][0] = 0;
                EAN13PARITYMAP[4][1] = 1;
                EAN13PARITYMAP[4][2] = 0;
                EAN13PARITYMAP[4][3] = 0;
                EAN13PARITYMAP[4][4] = 1;
                EAN13PARITYMAP[4][5] = 1;

                EAN13PARITYMAP[5][0] = 0;
                EAN13PARITYMAP[5][1] = 1;
                EAN13PARITYMAP[5][2] = 1;
                EAN13PARITYMAP[5][3] = 0;
                EAN13PARITYMAP[5][4] = 0;
                EAN13PARITYMAP[5][5] = 1;

                EAN13PARITYMAP[6][0] = 0;
                EAN13PARITYMAP[6][1] = 1;
                EAN13PARITYMAP[6][2] = 1;
                EAN13PARITYMAP[6][3] = 1;
                EAN13PARITYMAP[6][4] = 0;
                EAN13PARITYMAP[6][5] = 0;

                EAN13PARITYMAP[7][0] = 0;
                EAN13PARITYMAP[7][1] = 1;
                EAN13PARITYMAP[7][2] = 0;
                EAN13PARITYMAP[7][3] = 1;
                EAN13PARITYMAP[7][4] = 0;
                EAN13PARITYMAP[7][5] = 1;

                EAN13PARITYMAP[8][0] = 0;
                EAN13PARITYMAP[8][1] = 1;
                EAN13PARITYMAP[8][2] = 0;
                EAN13PARITYMAP[8][3] = 1;
                EAN13PARITYMAP[8][4] = 1;
                EAN13PARITYMAP[8][5] = 0;

                EAN13PARITYMAP[9][0] = 0;
                EAN13PARITYMAP[9][1] = 1;
                EAN13PARITYMAP[9][2] = 1;
                EAN13PARITYMAP[9][3] = 0;
                EAN13PARITYMAP[9][4] = 1;
                EAN13PARITYMAP[9][5] = 0;

                var Result = "";
                var cd = "";
                var filtereddata = "";

                var transformdataleft = "";
                var transformdataright = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;

                if (filteredlength > 12) {
                    filtereddata = filtereddata.substr(0, 12);
                }

                if (filteredlength < 12) {
                    var addcharlength = 12 - filtereddata.length;
                    for (var x = 0; x < addcharlength; x++) {
                        filtereddata = "0" + filtereddata;
                    }
                }

                cd = this.generateCheckDigit(filtereddata);

                this.connectcode_human_readable_text = this.html_escape(filtereddata + cd);

                filtereddata = filtereddata + cd;
                var datalength = 0;
                datalength = filtereddata.length;

                var parityBit = 0;
                var firstdigit = 0;
                for (x = 0; x < 7; x++) {
                    if (x == 0) {
                        firstdigit = filtereddata.charCodeAt(x) - 48;
                    } else {
                        parityBit = EAN13PARITYMAP[firstdigit][x - 1];
                        if (parityBit == 0) {
                            transformdataleft = transformdataleft + filtereddata.substr(x, 1);
                        } else {
                            transformdataleft = transformdataleft + String.fromCharCode(filtereddata.charCodeAt(x) + 49 + 14);
                        }
                    }
                }

                var transformchar = "";
                for (x = 7; x < 13; x++) {
                    transformchar = String.fromCharCode(filtereddata.charCodeAt(x) + 49);
                    transformdataright = transformdataright + transformchar;
                }

                if (this.hr == true) {
                    Result = String.fromCharCode(firstdigit + "!".charCodeAt(0)) + "[" + transformdataleft + "-" + transformdataright + "]";
                } else {
                    Result = "[" + transformdataleft + "-" + transformdataright + "]";
                }
                Result = this.html_escape(Result);
                return Result;
            };

            EAN13.prototype.generateCheckDigit = function (data) {
                var datalength = 0;
                var parity = 0;
                var Sum = 0;
                var Result = -1;
                var strResult = "";
                var barcodechar = "";
                var barcodevalue = 0;

                datalength = data.length;

                for (var x = datalength - 1; x >= 0; x--) {
                    barcodevalue = (data.charCodeAt(x) - 48);
                    if ((x % 2) == 1) {
                        Sum = Sum + (3 * barcodevalue);
                    } else {
                        Sum = Sum + barcodevalue;
                    }
                }

                Result = Sum % 10;
                if (Result == 0) {
                    Result = 0;
                } else {
                    Result = 10 - Result;
                }

                strResult = String.fromCharCode(Result + 48);
                return strResult;
            };

            EAN13.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57) {
                        Result = Result + data.substr(x, 1);
                    }
                }
                return Result;
            };
            return EAN13;
        })(connectcode.CCBarcode);
        connectcode.EAN13 = EAN13;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=ean13.js.map
