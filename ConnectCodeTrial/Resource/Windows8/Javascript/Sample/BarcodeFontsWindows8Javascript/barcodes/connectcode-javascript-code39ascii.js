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
var Code39ASCII = new function () {

    var connectcode_human_readable_text = "";
    this.ConnectCode_Encode_Code39ASCII = function (data, checkDigit) {

        var Result = "";
        var cd = "";
        var filtereddata = "";
        filtereddata = filterInput(data);

        var filteredlength = filtereddata.length;
        if (checkDigit == 1) {
            if (filteredlength > 254) {
                filtereddata = filtereddata.substr(0, 254);
            }
            connectcode_human_readable_text = filtereddata;
            filtereddata = getCode39ASCIIMappedString(filtereddata)
            cd = generateCheckDigit(filtereddata);
        }
        else {
            if (filteredlength > 255) {
                filtereddata = filtereddata.substr(0, 255);
            }
            connectcode_human_readable_text = filtereddata;
            filtereddata = getCode39ASCIIMappedString(filtereddata)
        }

        connectcode_human_readable_text = html_decode(html_escape("*" + connectcode_human_readable_text + cd + "*"));

        Result = "*" + filtereddata + cd + "*";
        Result = html_decode(html_escape(Result));

        return Result;
    }

    this.Get_HRText = function () {
        return connectcode_human_readable_text;
    }

    function getCode39ASCIIMappedString(inputx) {
        var CODE39ASCIIMAP = new Array("%U", "$A", "$B", "$C", "$D", "$E", "$F", "$G", "$H", "$I", "$J", "$K", "$L", "$M", "$N", "$O", "$P", "$Q", "$R", "$S", "$T", "$U", "$V", "$W", "$X", "$Y", "$Z", "%A", "%B", "%C", "%D", "%E", " ", "/A", "/B", "/C", "/D", "/E", "/F", "/G", "/H", "/I", "/J", "/K", "/L", "-", ".", "/O", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "/Z", "%F", "%G", "%H", "%I", "%J", "%V", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "%K", "%L", "%M", "%N", "%O", "%W", "+A", "+B", "+C", "+D", "+E", "+F", "+G", "+H", "+I", "+J", "+K", "+L", "+M", "+N", "+O", "+P", "+Q", "+R", "+S", "+T", "+U", "+V", "+W", "+X", "+Y", "+Z", "%P", "%Q", "%R", "%S", "%T");
        var strResult = "";
        var datalength = inputx.length;
        for (x = 0; x < datalength; x++) {
            strResult = strResult + CODE39ASCIIMAP[inputx.charCodeAt(x)];
        }
        return strResult;
    }

    function getCode39Character(inputdecimal) {
        var CODE39MAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                        "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                        "U", "V", "W", "X", "Y", "Z", "-", ".", " ", "$",
                        "/", "+", "%");
        return CODE39MAP[inputdecimal];
    }

    function getCode39Value(inputchar) {
        var CODE39MAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                        "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                        "U", "V", "W", "X", "Y", "Z", "-", ".", " ", "$",
                        "/", "+", "%");
        var RVal = -1;
        for (i = 0; i < 43; i++) {
            if (inputchar == CODE39MAP[i]) {
                RVal = i;
            }
        }
        return RVal;
    }

    function filterInput(data) {
        var Result = "";
        var datalength = data.length;
        for (x = 0; x < datalength; x++) {
            if ((data.charCodeAt(x) >= 0) && (data.charCodeAt(x) <= 127)) {
                Result = Result + data.substr(x, 1);
            }
        }

        return Result;
    }

    function generateCheckDigit(data) {
        var Result = "";
        var datalength = data.length;
        var sumValue = 0;
        for (x = 0; x < datalength; x++) {
            sumValue = sumValue + getCode39Value(data.substr(x, 1));
        }
        sumValue = sumValue % 43;
        return getCode39Character(sumValue);
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