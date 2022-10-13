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
        var Codabar = (function (_super) {
            __extends(Codabar, _super);
            function Codabar(data) {
                _super.call(this, data, false);
            }
            Codabar.prototype.encode = function () {
                var result = "";
                var cd = "";
                var filtereddata = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (filteredlength > 255) {
                    filtereddata = filtereddata.substr(0, 255);
                }
                result = filtereddata;
                result = this.html_escape(result);
                this.connectcode_human_readable_text = result;
                return result;
            };

            Codabar.prototype.getCodeCodabarValue = function (inputchar) {
                var CODECODABARMAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "-", ".", "$", "/", "+", ":");

                var RVal = -1;
                for (var i = 0; i < 20; i++) {
                    if (inputchar == CODECODABARMAP[i]) {
                        RVal = i;
                    }
                }
                return RVal;
            };

            Codabar.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = this.data.length;
                for (var x = 0; x < datalength; x++) {
                    if (this.getCodeCodabarValue(this.data.substr(x, 1)) != -1) {
                        Result = Result + this.data.substr(x, 1);
                    }
                }
                return Result;
            };
            return Codabar;
        })(connectcode.CCBarcode);
        connectcode.Codabar = Codabar;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=codabar.js.map
