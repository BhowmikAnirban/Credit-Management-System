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
var POSTNET = new function () {

    var connectcode_human_readable_text = "";

    this.ConnectCode_Encode_POSTNET = function (data, checkDigit) {
        var Result = "";
        var cd = "";
        var filtereddata = "";
        filtereddata = filterInput(data);
        var filteredlength = filtereddata.length;
        if (filteredlength > 11) {
            filtereddata = filtereddata.substr(0, 11);
        }
        cd = generateCheckDigit(filtereddata);

        connectcode_human_readable_text = html_decode(html_escape(filtereddata + cd));

        Result = "{" + filtereddata + cd + "}";
        Result = html_decode(html_escape(Result));
        return Result;
    }

    this.Get_HRText = function () {
        return connectcode_human_readable_text;
    }

    function getPOSTNETCharacter(inputdecimal) {
        return inputdecimal + 48;
    }

    function getPOSTNETValue(inputdecimal) {
        return inputdecimal - 48;
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

    function generateCheckDigit(data) {
        var datalength = 0;
        var Sumx = 0;
        var result = -1;
        var strResult = "";
        var barcodechar = "";

        datalength = data.length;
        for (x = 0; x < datalength; x++) {
            Sumx = Sumx + getPOSTNETValue(data.charCodeAt(x));
        }

        result = Sumx % 10;
        if (result != 0) {
            result = (10 - result);
        }

        strResult = result.toString();

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
