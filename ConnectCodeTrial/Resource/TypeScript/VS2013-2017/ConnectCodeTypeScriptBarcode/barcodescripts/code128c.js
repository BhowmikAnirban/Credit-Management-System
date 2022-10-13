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
        var Code128C = (function (_super) {
            __extends(Code128C, _super);
            function Code128C(data) {
                _super.call(this, data, false);
            }
            Code128C.prototype.encode = function () {
                var cd = "";
                var result = "";
                var filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;

                if (filteredlength > 253) {
                    filtereddata = filtereddata.substr(0, 253);
                }

                if (filtereddata.length % 2 == 1) {
                    filtereddata = "0" + filtereddata;
                }

                this.connectcode_human_readable_text = this.html_escape(filtereddata);

                cd = this.generateCheckDigit(filtereddata);
                for (var x = 0; x < filtereddata.length; x = x + 2) {
                    var num = parseInt(filtereddata.substr(x, 2), 10);
                    result = result + this.getCode128CCharacter(num);
                }

                result = result + cd;

                var startc = 237;
                var stopc = 238;
                result = String.fromCharCode(startc) + result + String.fromCharCode(stopc);
                result = this.html_escape(result);
                return result;
            };

            Code128C.prototype.getCode128CCharacter = function (inputvalue) {
                if ((inputvalue <= 94) && (inputvalue >= 0)) {
                    inputvalue = inputvalue + 32;
                } else if ((inputvalue <= 106) && (inputvalue >= 95)) {
                    inputvalue = inputvalue + 32 + 100;
                } else {
                    inputvalue = -1;
                }
                return String.fromCharCode(inputvalue);
            };

            Code128C.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57) {
                        Result = Result + data.substr(x, 1);
                    }
                }

                return Result;
            };

            Code128C.prototype.generateCheckDigit = function (data) {
                var datalength = 0;
                var Sum = 105;
                var Result = -1;
                var strResult = "";

                datalength = data.length;

                var x = 0;
                var Weight = 1;
                var num = 0;

                for (x = 0; x < data.length; x = x + 2) {
                    num = parseInt(data.substr(x, 2), 10);
                    Sum = Sum + (num * Weight);
                    Weight = Weight + 1;
                }

                Result = Sum % 103;
                strResult = this.getCode128CCharacter(Result);
                return strResult;
            };
            return Code128C;
        })(connectcode.CCBarcode);
        connectcode.Code128C = Code128C;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=code128c.js.map
