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
var UPCA = new function () {

    var connectcode_human_readable_text = "";

    this.ConnectCode_Encode_UPCA = function (data, hr) {
        var cd = "";
        var Result = "";
        var filtereddata = filterInput(data);
        var transformdataleft = "";
        var transformdataright = "";

        filteredlength = filtereddata.length;

        if (filteredlength > 11) {
            filtereddata = filtereddata.substr(0, 11);
        }

        if (filteredlength < 11) {
            addcharlength = 11 - filtereddata.length;
            for (x = 0; x < addcharlength; x++) {
                filtereddata = "0" + filtereddata
            }
        }

        cd = generateCheckDigit(filtereddata);

        filtereddata = filtereddata + cd;

        connectcode_human_readable_text = html_decode(html_escape(filtereddata));

        var datalength = 0;
        datalength = filtereddata.length;
        for (x = 0; x < 6; x++) {
            transformdataleft = transformdataleft + filtereddata.substr(x, 1);
        }

        for (x = 6; x < 12; x++) {
            transformchar = filtereddata.charCodeAt(x);
            transformchar = transformchar + 49
            transformdataright = transformdataright + String.fromCharCode(transformchar);
        }

        if (hr == 1) {

            Result = String.fromCharCode(transformdataleft.charCodeAt(0) - 15) + "[" + String.fromCharCode(transformdataleft.charCodeAt(0) + 110) + transformdataleft.substr(1, 5) + "-" + transformdataright.substr(0, 5) + String.fromCharCode(transformdataright.charCodeAt(5) - 49 + 159) + "]" + String.fromCharCode(transformdataright.charCodeAt(5) - 49 - 15);
        }
        else {
            Result = "[" + transformdataleft + "-" + transformdataright + "]";
        }
        Result = html_decode(html_escape(Result));
        return Result;
    }

    this.Get_HRText = function () {
        return connectcode_human_readable_text;
    }

    function getUPCACharacter(inputdecimal) {
        return (inputdecimal + 48);
    }

    function generateCheckDigit(data) {
        var datalength = 0;
        var Sum = 0;
        var Result = -1;
        var strResult = "";
        var barcodechar = "";
        var barcodevalue = 0;

        datalength = data.length;

        for (x = 0; x < datalength; x++) {

            barcodevalue = (data.charCodeAt(x) - 48);

            if (x % 2 == 0) {
                Sum = Sum + (3 * barcodevalue);
            }
            else {
                Sum = Sum + barcodevalue;
            }
        }

        Result = Sum % 10;
        if (Result == 0) {
            Result = 0;
        }
        else {
            Result = 10 - Result;
        }

        strResult = String.fromCharCode(Result + 48);
        return strResult;
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
        ta.innerHTML = str.replace(/</g, "&lt;").replace(/>/g, "&gt;");
        return ta.value;
    }
};
