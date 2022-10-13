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
var net;
(function (net) {
    (function (connectcode) {
        var CCBarcode = (function () {
            function CCBarcode(data, checkDigit) {
                this.newline = "<br>";
                //\\ and \" is treated as 1 char so it need not be unescape
                this.data = this.html_decode(data);
                this.checkDigit = checkDigit;
                this.connectcode_human_readable_text = "";
            }
            CCBarcode.prototype.encode = function () {
                return this.data;
            };

            CCBarcode.prototype.overrideNewLine = function (nl) {
                this.newline = nl;
            };

            CCBarcode.prototype.generateCheckDigit = function (data) {
                return "";
            };

            CCBarcode.prototype.getHRText = function () {
                return this.connectcode_human_readable_text;
            };

            CCBarcode.prototype.filterInput = function (data) {
                return data;
            };

            CCBarcode.prototype.html_escape = function (data) {
                var result = "";
                for (var x = 0; x < data.length; x++) {
                    result = result + "&#" + data.charCodeAt(x).toString() + ";";
                }
                return result;
            };

            CCBarcode.prototype.html_decode = function (str) {
                var ta = document.createElement("textarea");
                ta.innerHTML = str.replace(/</g, "&lt;").replace(/>/g, "&gt;"); //so if have a < must replace
                return ta.value;
            };

            CCBarcode.prototype.lengthExceeded2D = function () {
                return 0;
            };
            return CCBarcode;
        })();
        connectcode.CCBarcode = CCBarcode;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=barcode.js.map
