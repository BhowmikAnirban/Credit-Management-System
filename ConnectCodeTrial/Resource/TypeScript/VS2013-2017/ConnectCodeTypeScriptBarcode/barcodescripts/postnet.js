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
        var POSTNET = (function (_super) {
            __extends(POSTNET, _super);
            function POSTNET(data) {
                _super.call(this, data, false);
            }
            POSTNET.prototype.encode = function () {
                var Result = "";
                var cd = "";
                var filtereddata = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (filteredlength > 11) {
                    filtereddata = filtereddata.substr(0, 11);
                }
                cd = this.generateCheckDigit(filtereddata);

                this.connectcode_human_readable_text = this.html_escape(filtereddata + cd);

                Result = "{" + filtereddata + cd + "}";
                Result = this.html_escape(Result);
                return Result;
            };

            POSTNET.prototype.getPOSTNETCharacter = function (inputdecimal) {
                return inputdecimal + 48;
            };

            POSTNET.prototype.getPOSTNETValue = function (inputdecimal) {
                return inputdecimal - 48;
            };

            POSTNET.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57) {
                        Result = Result + data.substr(x, 1);
                    }
                }
                return Result;
            };

            POSTNET.prototype.generateCheckDigit = function (data) {
                var datalength = 0;
                var Sumx = 0;
                var result = -1;
                var strResult = "";
                var barcodechar = "";

                datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    Sumx = Sumx + this.getPOSTNETValue(data.charCodeAt(x));
                }

                result = Sumx % 10;
                if (result != 0) {
                    result = (10 - result);
                }

                strResult = result.toString();

                return strResult;
            };
            return POSTNET;
        })(connectcode.CCBarcode);
        connectcode.POSTNET = POSTNET;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=postnet.js.map
