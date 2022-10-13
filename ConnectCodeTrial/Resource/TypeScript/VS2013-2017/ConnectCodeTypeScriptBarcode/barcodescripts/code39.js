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
        var Code39 = (function (_super) {
            __extends(Code39, _super);
            function Code39(data, checkDigit) {
                if (typeof checkDigit === "undefined") { checkDigit = false; }
                _super.call(this, data, checkDigit);
            }
            Code39.prototype.encode = function () {
                var result = "";
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
                result = "*" + filtereddata + cd + "*";
                result = this.html_escape(result);
                this.connectcode_human_readable_text = this.html_escape("*" + filtereddata + cd + "*");
                return result;
            };

            Code39.prototype.filterInput = function (data) {
                var result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if (this.getCode39Value(data.substr(x, 1)) != -1) {
                        result = result + data.substr(x, 1);
                    }
                }
                return result;
            };

            Code39.prototype.getCode39Character = function (inputdecimal) {
                var CODE39MAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-", ".", " ", "$", "/", "+", "%");
                return CODE39MAP[inputdecimal];
            };

            Code39.prototype.generateCheckDigit = function (data) {
                var result = "";
                var datalength = data.length;
                var sumValue = 0;
                for (var x = 0; x < datalength; x++) {
                    sumValue = sumValue + this.getCode39Value(data.substr(x, 1));
                }
                sumValue = sumValue % 43;
                return this.getCode39Character(sumValue);
            };

            Code39.prototype.getCode39Value = function (inputchar) {
                var CODE39MAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-", ".", " ", "$", "/", "+", "%");
                var rVal = -1;
                for (var i = 0; i < 43; i++) {
                    if (inputchar == CODE39MAP[i]) {
                        rVal = i;
                    }
                }
                return rVal;
            };
            return Code39;
        })(connectcode.CCBarcode);
        connectcode.Code39 = Code39;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=code39.js.map
