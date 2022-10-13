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
        var Code128A = (function (_super) {
            __extends(Code128A, _super);
            function Code128A(data) {
                _super.call(this, data, false);
            }
            Code128A.prototype.encode = function () {
                var cd = "";
                var result = "";
                var filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;

                if (filteredlength > 254) {
                    filtereddata = filtereddata.substr(0, 254);
                }

                cd = this.generateCheckDigit(filtereddata);
                for (var x = 0; x < filtereddata.length; x++) {
                    var c = "";
                    c = this.translateCharacter(filtereddata.charCodeAt(x));
                    result = result + c;
                }

                this.connectcode_human_readable_text = this.html_escape(result);
                result = result + cd;

                var startc = 235;
                var stopc = 238;
                result = String.fromCharCode(startc) + result + String.fromCharCode(stopc);
                result = this.html_escape(result);
                return result;
            };

            Code128A.prototype.getCode128ACharacter = function (inputvalue) {
                if ((inputvalue <= 94) && (inputvalue >= 0)) {
                    inputvalue = inputvalue + 32;
                } else if ((inputvalue <= 106) && (inputvalue >= 95)) {
                    inputvalue = inputvalue + 100 + 32;
                } else {
                    inputvalue = -1;
                }

                return String.fromCharCode(inputvalue);
            };

            Code128A.prototype.translateCharacter = function (inputchar) {
                var returnvalue = 0;

                if ((inputchar <= 30) && (inputchar >= 0)) {
                    returnvalue = (inputchar + 96);
                } else if (inputchar == 31) {
                    returnvalue = (inputchar + 96 + 100);
                } else if ((inputchar <= 95) && (inputchar >= 32)) {
                    returnvalue = inputchar;
                } else {
                    returnvalue = -1;
                }
                return String.fromCharCode(returnvalue);
            };

            Code128A.prototype.getCode128AValue = function (inputchar) {
                var returnvalue = 0;

                if ((inputchar <= 31) && (inputchar >= 0)) {
                    returnvalue = (inputchar + 64);
                } else if ((inputchar <= 95) && (inputchar >= 32)) {
                    returnvalue = (inputchar - 32);
                } else {
                    returnvalue = -1;
                }

                return returnvalue;
            };

            Code128A.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 0 && data.charCodeAt(x) <= 95) {
                        Result = Result + data.substr(x, 1);
                    }
                }

                return Result;
            };

            Code128A.prototype.generateCheckDigit = function (data) {
                var datalength = 0;
                var Sum = 103;
                var Result = -1;
                var strResult = "";

                datalength = data.length;

                var x = 0;
                var Weight = 1;
                var num = 0;

                for (x = 0; x < data.length; x++) {
                    num = data.charCodeAt(x);
                    Sum = Sum + (this.getCode128AValue(num) * (Weight));
                    Weight = Weight + 1;
                }

                Result = Sum % 103;
                strResult = this.getCode128ACharacter(Result);
                return strResult;
            };
            return Code128A;
        })(connectcode.CCBarcode);
        connectcode.Code128A = Code128A;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=code128a.js.map
