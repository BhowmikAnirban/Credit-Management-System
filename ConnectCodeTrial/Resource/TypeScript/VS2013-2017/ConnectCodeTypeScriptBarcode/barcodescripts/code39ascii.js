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
        var Code39ASCII = (function (_super) {
            __extends(Code39ASCII, _super);
            function Code39ASCII(data, checkDigit) {
                if (typeof checkDigit === "undefined") { checkDigit = false; }
                _super.call(this, data, checkDigit);
            }
            Code39ASCII.prototype.encode = function () {
                var result = "";
                var cd = "";
                var filtereddata = "";
                filtereddata = this.filterInput(this.data);
                var unmappedfiltereddata = filtereddata;
                var filteredlength = filtereddata.length;
                if (this.checkDigit == true) {
                    if (filteredlength > 254) {
                        filtereddata = filtereddata.substr(0, 254);
                    }
                    this.connectcode_human_readable_text = filtereddata;
                    filtereddata = this.getCode39ASCIIMappedString(filtereddata);
                    cd = this.generateCheckDigit(filtereddata);
                } else {
                    if (filteredlength > 255) {
                        filtereddata = filtereddata.substr(0, 255);
                    }
                    this.connectcode_human_readable_text = filtereddata;
                    filtereddata = this.getCode39ASCIIMappedString(filtereddata);
                }

                //this.connectcode_human_readable_text = this.html_decode(this.html_escape("*" + this.connectcode_human_readable_text + cd + "*"));
                this.connectcode_human_readable_text = this.html_escape("*" + this.connectcode_human_readable_text + cd + "*");
                result = "*" + filtereddata + cd + "*";
                result = this.html_escape(result);

                return result;
            };

            Code39ASCII.prototype.getCode39ASCIIMappedString = function (inputx) {
                var CODE39ASCIIMAP = new Array("%U", "$A", "$B", "$C", "$D", "$E", "$F", "$G", "$H", "$I", "$J", "$K", "$L", "$M", "$N", "$O", "$P", "$Q", "$R", "$S", "$T", "$U", "$V", "$W", "$X", "$Y", "$Z", "%A", "%B", "%C", "%D", "%E", " ", "/A", "/B", "/C", "/D", "/E", "/F", "/G", "/H", "/I", "/J", "/K", "/L", "-", ".", "/O", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "/Z", "%F", "%G", "%H", "%I", "%J", "%V", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "%K", "%L", "%M", "%N", "%O", "%W", "+A", "+B", "+C", "+D", "+E", "+F", "+G", "+H", "+I", "+J", "+K", "+L", "+M", "+N", "+O", "+P", "+Q", "+R", "+S", "+T", "+U", "+V", "+W", "+X", "+Y", "+Z", "%P", "%Q", "%R", "%S", "%T");
                var strResult = "";
                var datalength = inputx.length;
                for (var x = 0; x < datalength; x++) {
                    strResult = strResult + CODE39ASCIIMAP[inputx.charCodeAt(x)];
                }
                return strResult;
            };

            Code39ASCII.prototype.filterInput = function (data) {
                var result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if ((data.charCodeAt(x) >= 0) && (data.charCodeAt(x) <= 127)) {
                        result = result + data.substr(x, 1);
                    }
                }
                return result;
            };

            Code39ASCII.prototype.getCode39Character = function (inputdecimal) {
                var CODE39MAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-", ".", " ", "$", "/", "+", "%");
                return CODE39MAP[inputdecimal];
            };

            Code39ASCII.prototype.generateCheckDigit = function (data) {
                var result = "";
                var datalength = data.length;
                var sumValue = 0;
                for (var x = 0; x < datalength; x++) {
                    sumValue = sumValue + this.getCode39Value(data.substr(x, 1));
                }
                sumValue = sumValue % 43;
                return this.getCode39Character(sumValue);
            };

            Code39ASCII.prototype.getCode39Value = function (inputchar) {
                var CODE39MAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-", ".", " ", "$", "/", "+", "%");
                var rVal = -1;
                for (var i = 0; i < 43; i++) {
                    if (inputchar == CODE39MAP[i]) {
                        rVal = i;
                    }
                }
                return rVal;
            };
            return Code39ASCII;
        })(connectcode.CCBarcode);
        connectcode.Code39ASCII = Code39ASCII;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=code39ascii.js.map
