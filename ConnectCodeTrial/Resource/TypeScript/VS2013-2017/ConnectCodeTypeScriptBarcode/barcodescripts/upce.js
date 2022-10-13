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
        var UPCE = (function (_super) {
            __extends(UPCE, _super);
            function UPCE(data, hr) {
                if (typeof hr === "undefined") { hr = false; }
                _super.call(this, data, false);
                this.hr = false;
                this.hr = hr;
            }
            UPCE.prototype.encode = function () {
                var UPCEPARITYMAP = new Array(10);
                UPCEPARITYMAP[0] = new Array(2);
                UPCEPARITYMAP[1] = new Array(2);
                UPCEPARITYMAP[2] = new Array(2);
                UPCEPARITYMAP[3] = new Array(2);
                UPCEPARITYMAP[4] = new Array(2);
                UPCEPARITYMAP[5] = new Array(2);
                UPCEPARITYMAP[6] = new Array(2);
                UPCEPARITYMAP[7] = new Array(2);
                UPCEPARITYMAP[8] = new Array(2);
                UPCEPARITYMAP[9] = new Array(2);

                UPCEPARITYMAP[0][0] = new Array(6);
                UPCEPARITYMAP[0][1] = new Array(6);
                UPCEPARITYMAP[1][0] = new Array(6);
                UPCEPARITYMAP[1][1] = new Array(6);
                UPCEPARITYMAP[2][0] = new Array(6);
                UPCEPARITYMAP[2][1] = new Array(6);
                UPCEPARITYMAP[3][0] = new Array(6);
                UPCEPARITYMAP[3][1] = new Array(6);
                UPCEPARITYMAP[4][0] = new Array(6);
                UPCEPARITYMAP[4][1] = new Array(6);
                UPCEPARITYMAP[5][0] = new Array(6);
                UPCEPARITYMAP[5][1] = new Array(6);
                UPCEPARITYMAP[6][0] = new Array(6);
                UPCEPARITYMAP[6][1] = new Array(6);
                UPCEPARITYMAP[7][0] = new Array(6);
                UPCEPARITYMAP[7][1] = new Array(6);
                UPCEPARITYMAP[8][0] = new Array(6);
                UPCEPARITYMAP[8][1] = new Array(6);
                UPCEPARITYMAP[9][0] = new Array(6);
                UPCEPARITYMAP[9][1] = new Array(6);

                UPCEPARITYMAP[0][0][0] = 1;
                UPCEPARITYMAP[0][0][1] = 1;
                UPCEPARITYMAP[0][0][2] = 1;
                UPCEPARITYMAP[0][0][3] = 0;
                UPCEPARITYMAP[0][0][4] = 0;
                UPCEPARITYMAP[0][0][5] = 0;

                UPCEPARITYMAP[0][1][0] = 0;
                UPCEPARITYMAP[0][1][1] = 0;
                UPCEPARITYMAP[0][1][2] = 0;
                UPCEPARITYMAP[0][1][3] = 1;
                UPCEPARITYMAP[0][1][4] = 1;
                UPCEPARITYMAP[0][1][5] = 1;

                UPCEPARITYMAP[1][0][0] = 1;
                UPCEPARITYMAP[1][0][1] = 1;
                UPCEPARITYMAP[1][0][2] = 0;
                UPCEPARITYMAP[1][0][3] = 1;
                UPCEPARITYMAP[1][0][4] = 0;
                UPCEPARITYMAP[1][0][5] = 0;

                UPCEPARITYMAP[1][1][0] = 0;
                UPCEPARITYMAP[1][1][1] = 0;
                UPCEPARITYMAP[1][1][2] = 1;
                UPCEPARITYMAP[1][1][3] = 0;
                UPCEPARITYMAP[1][1][4] = 1;
                UPCEPARITYMAP[1][1][5] = 1;

                UPCEPARITYMAP[2][0][0] = 1;
                UPCEPARITYMAP[2][0][1] = 1;
                UPCEPARITYMAP[2][0][2] = 0;
                UPCEPARITYMAP[2][0][3] = 0;
                UPCEPARITYMAP[2][0][4] = 1;
                UPCEPARITYMAP[2][0][5] = 0;

                UPCEPARITYMAP[2][1][0] = 0;
                UPCEPARITYMAP[2][1][1] = 0;
                UPCEPARITYMAP[2][1][2] = 1;
                UPCEPARITYMAP[2][1][3] = 1;
                UPCEPARITYMAP[2][1][4] = 0;
                UPCEPARITYMAP[2][1][5] = 1;

                UPCEPARITYMAP[3][0][0] = 1;
                UPCEPARITYMAP[3][0][1] = 1;
                UPCEPARITYMAP[3][0][2] = 0;
                UPCEPARITYMAP[3][0][3] = 0;
                UPCEPARITYMAP[3][0][4] = 0;
                UPCEPARITYMAP[3][0][5] = 1;

                UPCEPARITYMAP[3][1][0] = 0;
                UPCEPARITYMAP[3][1][1] = 0;
                UPCEPARITYMAP[3][1][2] = 1;
                UPCEPARITYMAP[3][1][3] = 1;
                UPCEPARITYMAP[3][1][4] = 1;
                UPCEPARITYMAP[3][1][5] = 0;

                UPCEPARITYMAP[4][0][0] = 1;
                UPCEPARITYMAP[4][0][1] = 0;
                UPCEPARITYMAP[4][0][2] = 1;
                UPCEPARITYMAP[4][0][3] = 1;
                UPCEPARITYMAP[4][0][4] = 0;
                UPCEPARITYMAP[4][0][5] = 0;

                UPCEPARITYMAP[4][1][0] = 0;
                UPCEPARITYMAP[4][1][1] = 1;
                UPCEPARITYMAP[4][1][2] = 0;
                UPCEPARITYMAP[4][1][3] = 0;
                UPCEPARITYMAP[4][1][4] = 1;
                UPCEPARITYMAP[4][1][5] = 1;

                UPCEPARITYMAP[5][0][0] = 1;
                UPCEPARITYMAP[5][0][1] = 0;
                UPCEPARITYMAP[5][0][2] = 0;
                UPCEPARITYMAP[5][0][3] = 1;
                UPCEPARITYMAP[5][0][4] = 1;
                UPCEPARITYMAP[5][0][5] = 0;

                UPCEPARITYMAP[5][1][0] = 0;
                UPCEPARITYMAP[5][1][1] = 1;
                UPCEPARITYMAP[5][1][2] = 1;
                UPCEPARITYMAP[5][1][3] = 0;
                UPCEPARITYMAP[5][1][4] = 0;
                UPCEPARITYMAP[5][1][5] = 1;

                UPCEPARITYMAP[6][0][0] = 1;
                UPCEPARITYMAP[6][0][1] = 0;
                UPCEPARITYMAP[6][0][2] = 0;
                UPCEPARITYMAP[6][0][3] = 0;
                UPCEPARITYMAP[6][0][4] = 1;
                UPCEPARITYMAP[6][0][5] = 1;

                UPCEPARITYMAP[6][1][0] = 0;
                UPCEPARITYMAP[6][1][1] = 1;
                UPCEPARITYMAP[6][1][2] = 1;
                UPCEPARITYMAP[6][1][3] = 1;
                UPCEPARITYMAP[6][1][4] = 0;
                UPCEPARITYMAP[6][1][5] = 0;

                UPCEPARITYMAP[7][0][0] = 1;
                UPCEPARITYMAP[7][0][1] = 0;
                UPCEPARITYMAP[7][0][2] = 1;
                UPCEPARITYMAP[7][0][3] = 0;
                UPCEPARITYMAP[7][0][4] = 1;
                UPCEPARITYMAP[7][0][5] = 0;

                UPCEPARITYMAP[7][1][0] = 0;
                UPCEPARITYMAP[7][1][1] = 1;
                UPCEPARITYMAP[7][1][2] = 0;
                UPCEPARITYMAP[7][1][3] = 1;
                UPCEPARITYMAP[7][1][4] = 0;
                UPCEPARITYMAP[7][1][5] = 1;

                UPCEPARITYMAP[8][0][0] = 1;
                UPCEPARITYMAP[8][0][1] = 0;
                UPCEPARITYMAP[8][0][2] = 1;
                UPCEPARITYMAP[8][0][3] = 0;
                UPCEPARITYMAP[8][0][4] = 0;
                UPCEPARITYMAP[8][0][5] = 1;

                UPCEPARITYMAP[8][1][0] = 0;
                UPCEPARITYMAP[8][1][1] = 1;
                UPCEPARITYMAP[8][1][2] = 0;
                UPCEPARITYMAP[8][1][3] = 1;
                UPCEPARITYMAP[8][1][4] = 1;
                UPCEPARITYMAP[8][1][5] = 0;

                UPCEPARITYMAP[9][0][0] = 1;
                UPCEPARITYMAP[9][0][1] = 0;
                UPCEPARITYMAP[9][0][2] = 0;
                UPCEPARITYMAP[9][0][3] = 1;
                UPCEPARITYMAP[9][0][4] = 0;
                UPCEPARITYMAP[9][0][5] = 1;

                UPCEPARITYMAP[9][1][0] = 0;
                UPCEPARITYMAP[9][1][1] = 1;
                UPCEPARITYMAP[9][1][2] = 1;
                UPCEPARITYMAP[9][1][3] = 0;
                UPCEPARITYMAP[9][1][4] = 1;
                UPCEPARITYMAP[9][1][5] = 0;

                var upcestr = "";
                var cd = "";
                var Result = "";
                var filtereddata = this.filterInput(this.data);
                var transformdata = "";

                var filteredlength = filtereddata.length;

                if (filteredlength > 6) {
                    filtereddata = filtereddata.substr(0, 6);
                }

                if (filteredlength < 6) {
                    var addcharlength = 6 - filtereddata.length;
                    for (x = 0; x < addcharlength; x++) {
                        filtereddata = "0" + filtereddata;
                    }
                }

                var datalength = 0;
                datalength = filtereddata.length;

                var upcastr = "0";
                var lastchar = filtereddata.substr(datalength - 1, 1);

                if ((lastchar.charCodeAt(0) == 48) || (lastchar.charCodeAt(0) == 49) || (lastchar.charCodeAt(0) == 50)) {
                    upcastr = upcastr + filtereddata.substr(0, 2);
                    upcastr = upcastr + lastchar;
                    upcastr = upcastr + "0000";
                    upcastr = upcastr + filtereddata.substr(2, 3);
                } else if (lastchar.charCodeAt(0) == 51) {
                    upcastr = upcastr + filtereddata.substr(0, 3);
                    upcastr = upcastr + "00000";
                    upcastr = upcastr + filtereddata.substr(3, 2);
                } else if (lastchar.charCodeAt(0) == 52) {
                    upcastr = upcastr + filtereddata.substr(0, 4);
                    upcastr = upcastr + "00000";
                    upcastr = upcastr + filtereddata.substr(4, 1);
                } else if ((lastchar.charCodeAt(0) == 53) || (lastchar.charCodeAt(0) == 54) || (lastchar.charCodeAt(0) == 55) || (lastchar.charCodeAt(0) == 56) || (lastchar.charCodeAt(0) == 57)) {
                    upcastr = upcastr + filtereddata.substr(0, 5);
                    upcastr = upcastr + "0000";
                    upcastr = upcastr + lastchar;
                }

                filtereddata = upcastr;

                cd = this.generateCheckDigit(filtereddata);

                upcestr = upcastr;
                var productvalue = parseInt(upcastr.substr(6, 5), 10);
                if ((upcestr.substr(3, 3) == "000") || (upcestr.substr(3, 3) == "100") || (upcestr.substr(3, 3) == "200")) {
                    if ((productvalue >= 0) && (productvalue <= 999)) {
                        var thirdch = upcestr.substr(3, 1);
                        upcestr = this.DeleteSubString(upcestr, 3, 5);
                        upcestr = this.InsertSubString(upcestr, thirdch, 6);
                    } else {
                        upcestr = "000000";
                    }
                } else if (upcestr.substr(4, 2) == "00") {
                    if ((productvalue >= 0) && (productvalue <= 99)) {
                        upcestr = this.DeleteSubString(upcestr, 4, 5);
                        upcestr = this.InsertSubString(upcestr, "3", 6);
                    } else {
                        upcestr = "000000";
                    }
                } else if (upcestr.substr(5, 1) == "0") {
                    if ((productvalue >= 0) && (productvalue <= 9)) {
                        upcestr = this.DeleteSubString(upcestr, 5, 5);
                        upcestr = this.InsertSubString(upcestr, "4", 6);
                    } else {
                        upcestr = "000000";
                    }
                } else if (upcestr.substr(5, 1) != "0") {
                    if ((productvalue >= 5) && (productvalue <= 9)) {
                        upcestr = this.DeleteSubString(upcestr, 6, 4);
                    } else {
                        upcestr = "000000";
                    }
                } else {
                    upcestr = "000000";
                }

                filtereddata = upcestr;

                this.connectcode_human_readable_text = this.html_escape(filtereddata + cd);

                var parityBit = 0;
                var nschar = "0";
                var chkvalue = (cd.charCodeAt(0) - 48);

                for (var x = 1; x < 7; x++) {
                    var nsvalue = (nschar.charCodeAt(0) - 48);
                    var transformchar = filtereddata.substr(x, 1);

                    parityBit = UPCEPARITYMAP[chkvalue][nsvalue][x - 1];
                    if (parityBit == 1) {
                        var transformchar = String.fromCharCode(transformchar.charCodeAt(0) + 48 + 15);
                    }
                    transformdata = transformdata + transformchar;
                }

                if (this.hr == true) {
                    Result = String.fromCharCode(nschar.charCodeAt(0) - 15) + "{" + transformdata + "}" + String.fromCharCode(chkvalue + 48 - 15);
                } else {
                    Result = "{" + transformdata + "}";
                }
                Result = this.html_escape(Result);
                return Result;
            };

            UPCE.prototype.getUPCECharacter = function (inputdecimal) {
                return (inputdecimal + 48);
            };

            UPCE.prototype.generateCheckDigit = function (data) {
                var datalength = 0;
                var Sum = 0;
                var Result = -1;
                var strResult = "";
                var barcodechar = "";
                var barcodevalue = 0;
                var parity = 0;
                datalength = data.length;

                for (var x = 0; x < datalength; x++) {
                    barcodevalue = (data.charCodeAt(x) - 48);

                    if (parity == 0) {
                        Sum = Sum + (3 * barcodevalue);
                        parity = 1;
                    } else {
                        Sum = Sum + barcodevalue;
                        parity = 0;
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

            UPCE.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if ((data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57)) {
                        Result = Result + data.substr(x, 1);
                    }
                }
                return Result;
            };

            UPCE.prototype.Right = function (str, n) {
                if (n <= 0)
                    return "";
                else if (n > String(str).length)
                    return str;
                else {
                    var iLen = String(str).length;
                    return String(str).substring(iLen, iLen - n);
                }
            };

            UPCE.prototype.DeleteSubString = function (orgStr, start, length) {
                var fulllength = orgStr.length;
                var leftstr = "";
                var rightstr = "";
                if (start < 1) {
                    start = 1;
                }

                leftstr = orgStr.substr(0, start);
                rightstr = this.Right(orgStr, fulllength - (start + length));
                return leftstr + rightstr;
            };

            UPCE.prototype.InsertSubString = function (orgStr, insertStr, start) {
                var fulllength = orgStr.length;
                var leftstr = "";
                var rightstr = "";

                if (start < 1) {
                    start = 1;
                }

                if (start > fulllength + 1) {
                    start = fulllength + 1;
                }

                leftstr = orgStr.substr(0, start);
                rightstr = this.Right(orgStr, fulllength - start);
                return leftstr + insertStr + rightstr;
            };
            return UPCE;
        })(connectcode.CCBarcode);
        connectcode.UPCE = UPCE;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=upce.js.map
