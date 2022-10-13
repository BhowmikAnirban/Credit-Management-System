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
var Industrial2of5 = new function () {

    var connectcode_human_readable_text = "";

    this.ConnectCode_Encode_Industrial2OF5 = function (data, checkDigit) {
        var Result = "";
        var cd = "";
        var filtereddata = "";
        filtereddata = filterInput(data);
        var filteredlength = filtereddata.length;
        if (checkDigit == 1) {
            if (filteredlength > 254) {
                filtereddata = filtereddata.substr(0, 254);
            }

            cd = generateCheckDigit(filtereddata);
        }
        else {
            if (filteredlength > 255) {
                filtereddata = filtereddata.substr(0, 255);
            }


        }
        filtereddata = filtereddata + cd;

        connectcode_human_readable_text = html_decode(html_escape(filtereddata));

        Result = "{" + filtereddata + "}";
        Result = html_decode(html_escape(Result));
        return Result;
    }

    this.Get_HRText = function () {
        return connectcode_human_readable_text;
    }

    function filterInput(data) {
        var Result = "";
        var datalength = data.length;
        for (x = 0; x < datalength; x++) {
            if ((data.charCodeAt(x) >= 48) && (data.charCodeAt(x) <= 57)) {
                Result = Result + data.substr(x, 1);
            }
        }

        return Result;
    }

    function generateCheckDigit(data) {
        var datalength = 0;
        var lastcharpos = 0;
        var Result = 0;
        var strResult = "";
        var barcodechar = "";
        var barcodevalue = 0;
        var toggle = 1;
        var sum = 0;

        datalength = data.length;
        lastcharpos = datalength - 1;

        for (x = lastcharpos ; x >= 0 ; x--) {
            barcodevalue = data.charCodeAt(x) - 48;

            if (toggle == 1) {
                sum = sum + (barcodevalue * 3);
                toggle = 0;
            }
            else {
                sum = sum + barcodevalue;
                toggle = 1;
            }
        }
        if ((sum % 10) == 0) {
            Result = 48;
        }
        else {
            Result = (10 - (sum % 10)) + 48;
        }

        strResult = String.fromCharCode(Result);
        return strResult;
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
        ta.innerHTML = str.replace(/</g, "&lt;").replace(/>/g, "&gt;");
        return ta.value;
    }
};
