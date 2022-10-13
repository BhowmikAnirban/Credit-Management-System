/*
 * ConnectCode
 *
 * Copyright (c) 2006-2012 ConnectCode Pte Ltd (http://www.barcoderesource.com)
 * All Rights Reserved.
 *
 * This source code is protected by International Copyright Laws. You are only allowed to modify
 * and include the source in your application if you have purchased a Distribution License.
 *
 * http://www.barcoderesource.com
 *
 */
var EXT5 = new function () {

    var connectcode_human_readable_text = "";
    this.ConnectCode_Encode_EXT5 = function (data) {
        var EXT5PARITYMAP = new Array(10);
        EXT5PARITYMAP[0] = new Array(5);
        EXT5PARITYMAP[1] = new Array(5);
        EXT5PARITYMAP[2] = new Array(5);
        EXT5PARITYMAP[3] = new Array(5);
        EXT5PARITYMAP[4] = new Array(5);
        EXT5PARITYMAP[5] = new Array(5);
        EXT5PARITYMAP[6] = new Array(5);
        EXT5PARITYMAP[7] = new Array(5);
        EXT5PARITYMAP[8] = new Array(5);
        EXT5PARITYMAP[9] = new Array(5);

        EXT5PARITYMAP[0][0] = 1;
        EXT5PARITYMAP[0][1] = 1;
        EXT5PARITYMAP[0][2] = 0;
        EXT5PARITYMAP[0][3] = 0;
        EXT5PARITYMAP[0][4] = 0;

        EXT5PARITYMAP[1][0] = 1;
        EXT5PARITYMAP[1][1] = 0;
        EXT5PARITYMAP[1][2] = 1;
        EXT5PARITYMAP[1][3] = 0;
        EXT5PARITYMAP[1][4] = 0;

        EXT5PARITYMAP[2][0] = 1;
        EXT5PARITYMAP[2][1] = 0;
        EXT5PARITYMAP[2][2] = 0;
        EXT5PARITYMAP[2][3] = 1;
        EXT5PARITYMAP[2][4] = 0;

        EXT5PARITYMAP[3][0] = 1;
        EXT5PARITYMAP[3][1] = 0;
        EXT5PARITYMAP[3][2] = 0;
        EXT5PARITYMAP[3][3] = 0;
        EXT5PARITYMAP[3][4] = 1;

        EXT5PARITYMAP[4][0] = 0;
        EXT5PARITYMAP[4][1] = 1;
        EXT5PARITYMAP[4][2] = 1;
        EXT5PARITYMAP[4][3] = 0;
        EXT5PARITYMAP[4][4] = 0;

        EXT5PARITYMAP[5][0] = 0;
        EXT5PARITYMAP[5][1] = 0;
        EXT5PARITYMAP[5][2] = 1;
        EXT5PARITYMAP[5][3] = 1;
        EXT5PARITYMAP[5][4] = 0;

        EXT5PARITYMAP[6][0] = 0;
        EXT5PARITYMAP[6][1] = 0;
        EXT5PARITYMAP[6][2] = 0;
        EXT5PARITYMAP[6][3] = 1;
        EXT5PARITYMAP[6][4] = 1;

        EXT5PARITYMAP[7][0] = 0;
        EXT5PARITYMAP[7][1] = 1;
        EXT5PARITYMAP[7][2] = 0;
        EXT5PARITYMAP[7][3] = 1;
        EXT5PARITYMAP[7][4] = 0;

        EXT5PARITYMAP[8][0] = 0;
        EXT5PARITYMAP[8][1] = 1;
        EXT5PARITYMAP[8][2] = 0;
        EXT5PARITYMAP[8][3] = 0;
        EXT5PARITYMAP[8][4] = 1;

        EXT5PARITYMAP[9][0] = 0;
        EXT5PARITYMAP[9][1] = 0;
        EXT5PARITYMAP[9][2] = 1;
        EXT5PARITYMAP[9][3] = 0;
        EXT5PARITYMAP[9][4] = 1;

        var Result = "";
        var cd = "";
        var filtereddata = "";

        transformdata = "";
        filtereddata = filterInput(data);
        filteredlength = filtereddata.length;

        if (filteredlength > 5) {
            filtereddata = filtereddata.substr(0, 5);
        }

        if (filteredlength < 5) {
            addcharlength = 5 - filtereddata.length;
            for (x = 0; x < addcharlength; x++) {
                filtereddata = "0" + filtereddata;
            }
        }

        connectcode_human_readable_text = html_escape(filtereddata);

        var Sum = 0;
        var datalength = 0;
        datalength = filtereddata.length;

        var barcodechar = "";
        var barcodevalue = 0;
        for (x = datalength - 1; x >= 0; x--) {

            barcodevalue = filtereddata.charCodeAt(x);

            if (x % 2 == 0) {
                Sum = Sum + (3 * (barcodevalue - 48));
            }
            else {
                Sum = Sum + (9 * (barcodevalue - 48));
            }
        }

        chk = Sum % 10;

        for (x = 0; x <= 4; x++) {
            parityBit = 0;
            parityBit = EXT5PARITYMAP[chk][x];
            if (parityBit == 0) {
                transformdata = transformdata + filtereddata.substr(x, 1);
            }
            else {
                transformdata = transformdata + String.fromCharCode(filtereddata.charCodeAt(x) + 49 + 14);
            }
        }
        Result = "<" + transformdata.substr(0, 1) + "+" + transformdata.substr(1, 1) + "+" + transformdata.substr(2, 1) + "+" + transformdata.substr(3, 1) + "+" + transformdata.substr(4, 1);
        //Result = html_escape(Result);
        return Result;
    }

    this.Get_HRText = function () {
        return connectcode_human_readable_text;
    }

    function filterInput(data) {
        var Result = "";
        var datalength = data.length;
        for (x = 0; x < datalength; x++) {
            if (data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57) {
                Result = Result + data.substr(x, 1);
            }
        }
        return Result;
    }

    function html_escape(data) {
        var Result = "";
        for (x = 0; x < data.length; x++) {
            Result = Result + "&#" + data.charCodeAt(x).toString() + ";";
        }
        return Result;
    }

    function html_decode(str) {
        var ta = document.createElement("textarea");
        return ta.value;
    }

};