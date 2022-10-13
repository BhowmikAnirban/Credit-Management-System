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
        var EXT2 = (function (_super) {
            __extends(EXT2, _super);
            function EXT2(data) {
                _super.call(this, data, false);
            }
            EXT2.prototype.encode = function () {
                var EXT2PARITYMAP = new Array(4);
                EXT2PARITYMAP[0] = new Array(2);
                EXT2PARITYMAP[1] = new Array(2);
                EXT2PARITYMAP[2] = new Array(2);
                EXT2PARITYMAP[3] = new Array(2);

                EXT2PARITYMAP[0][0] = 0;
                EXT2PARITYMAP[0][1] = 0;

                EXT2PARITYMAP[1][0] = 0;
                EXT2PARITYMAP[1][1] = 1;

                EXT2PARITYMAP[2][0] = 1;
                EXT2PARITYMAP[2][1] = 0;

                EXT2PARITYMAP[3][0] = 1;
                EXT2PARITYMAP[3][1] = 1;

                var Result = "";
                var cd = "";
                var filtereddata = "";

                var transformdataleft = "";
                var transformdataright = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;

                if (filteredlength > 2) {
                    filtereddata = filtereddata.substr(0, 2);
                }

                if (filteredlength < 2) {
                    var addcharlength = 2 - filtereddata.length;
                    for (var x = 0; x < addcharlength; x++) {
                        filtereddata = "0" + filtereddata;
                    }
                }

                this.connectcode_human_readable_text = this.html_escape(filtereddata);

                var Sum = 0;
                var value1 = 0;
                var Value2 = 0;
                var parityindex = 0;
                value1 = (filtereddata.charCodeAt(0) - 48) * 10;
                Value2 = (filtereddata.charCodeAt(1) - 48);
                Sum = value1 + Value2;
                var parityindex = Sum % 4;

                var datalength = 0;
                datalength = filtereddata.length;

                var parityBit = 0;
                parityBit = EXT2PARITYMAP[parityindex][0];

                if (parityBit == 0) {
                    transformdataleft = transformdataleft + filtereddata.substr(0, 1);
                } else {
                    transformdataleft = transformdataleft + String.fromCharCode(filtereddata.charCodeAt(0) + 49 + 14);
                }

                parityBit = EXT2PARITYMAP[parityindex][1];
                if (parityBit == 0) {
                    transformdataright = transformdataright + filtereddata.substr(1, 1);
                } else {
                    transformdataright = transformdataright + String.fromCharCode(filtereddata.charCodeAt(1) + 49 + 14);
                }

                Result = "<" + transformdataleft + "+" + transformdataright;
                Result = this.html_escape(Result);
                return Result;
            };

            EXT2.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57) {
                        Result = Result + data.substr(x, 1);
                    }
                }
                return Result;
            };
            return EXT2;
        })(connectcode.CCBarcode);
        connectcode.EXT2 = EXT2;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=ext2.js.map
