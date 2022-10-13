/*
 * ConnectCode
 *
 * Copyright (c) 2006-2012 ConnectCode Pte Ltd (http://www.barcoderesource.com)
 * All Rights Reserved.
 *
 * This source code is protected by International Copyright Laws. You are only allowed to modify
 * && include the source in your application if you have purchased a Distribution License.
 *
 * http://www.barcoderesource.com
 *
 */
var Code128Auto = new function () {

    var connectcode_human_readable_text = "";

    this.ConnectCode_Encode_Code128Auto = function (data) {

        var cd = "";
        var Result = "";
        var shiftdata = "";

        var filtereddata = filterInput(data);

        filteredlength = filtereddata.length;
        if (filteredlength > 254) {
            filtereddata = filtereddata.substr(0, 254);
        }

        connectcode_human_readable_text = html_decode(html_escape(filtereddata));

        if (detectAllNumbers(filtereddata) == 0) {
            filtereddata = addShift(filtereddata);
            cd = generateCheckDigit_Code128ABAuto(filtereddata);

            filtereddata = getAutoSwitchingAB(filtereddata);

            filtereddata = filtereddata + cd;
            Result = filtereddata;

            var startc = 236;
            var stopc = 238;
            Result = String.fromCharCode(startc) + Result + String.fromCharCode(stopc)
        }
        else {

            cd = generateCheckDigit_Code128CAuto(filtereddata);
            var lenFiltered = filtereddata.length;

            for (x = 0; x < lenFiltered; x = x + 2) {
                var tstr = filtereddata.substr(x, 2);
                num = parseInt(tstr, 10);
                Result = Result + getCode128CCharacterAuto(num);
            }


            Result = Result + cd;
            startc = 237;
            stopc = 238;
            Result = String.fromCharCode(startc) + Result + String.fromCharCode(stopc);

        }
        Result = html_decode(html_escape(Result));
        return Result;
    }

    this.Get_HRText = function () {
        return connectcode_human_readable_text;
    }

    function getCode128ABValueAuto(inputchar) {

        var returnvalue = 0;

        if ((inputchar <= 31) && (inputchar >= 0))
            returnvalue = (inputchar + 64);
        else if ((inputchar <= 127) && (inputchar >= 32))
            returnvalue = (inputchar - 32);
        else if (inputchar == 230)
            returnvalue = 98;
        else
            returnvalue = -1;

        return returnvalue;

    }


    function getCode128ABCharacterAuto(inputvalue) {
        if ((inputvalue <= 94) && (inputvalue >= 0))
            inputvalue = inputvalue + 32;
        else if ((inputvalue <= 106) && (inputvalue >= 95))
            inputvalue = inputvalue + 100 + 32;
        else
            inputvalue = -1;


        return String.fromCharCode(inputvalue);

    }

    function getCode128CCharacterAuto(inputvalue) {

        if ((inputvalue <= 94) && (inputvalue >= 0))
            inputvalue = inputvalue + 32;
        else if ((inputvalue <= 106) && (inputvalue >= 95))
            inputvalue = inputvalue + 32 + 100;
        else
            inputvalue = -1;


        return String.fromCharCode(inputvalue);

    }



    function filterInput(data) {
        var Result = "";
        var datalength = data.length;
        for (x = 0; x < datalength; x++) {
            if (data.charCodeAt(x) >= 0 && data.charCodeAt(x) <= 127) {
                Result = Result + data.substr(x, 1);
            }
        }

        return Result;
    }

    function generateCheckDigit_Code128ABAuto(data) {
        var datalength = 0;
        var Sum = 104;
        var Result = -1;
        var strResult = "";

        datalength = data.length;

        var num = 0;
        var Weight = 1;

        var x = 0;
        while (x < data.length) {
            num = ScanAhead_8orMore_Numbers(data, x);
            if (num >= 8) {
                endpoint = x + num;

                var BtoC = 99;
                Sum = Sum + (BtoC * (Weight));
                Weight = Weight + 1;

                while (x < endpoint) {
                    num = parseInt(data.substr(x, 2), 10);
                    Sum = Sum + (num * (Weight));
                    x = x + 2;
                    Weight = Weight + 1;

                }
                var CtoB = 100;
                Sum = Sum + (CtoB * (Weight));
                Weight = Weight + 1;

            }
            else {
                num = data.charCodeAt(x);
                Sum = Sum + (getCode128ABValueAuto(num) * (Weight));
                x = x + 1;
                Weight = Weight + 1;

            }
        }
        Result = Sum % 103;
        strResult = getCode128ABCharacterAuto(Result);
        return strResult;
    }

    function getCode128CCharacter(inputvalue) {
        if ((inputvalue <= 94) && (inputvalue >= 0))
            inputvalue = inputvalue + 32;
        else if ((inputvalue <= 106) && (inputvalue >= 95))
            inputvalue = inputvalue + 32 + 100;
        else
            inputvalue = -1;

        return String.fromCharCode(inputvalue);


    }

    function generateCheckDigit_Code128CAuto(data) {
        var datalength = 0;
        var Sum = 105;
        var Result = -1;
        var strResult = "";

        datalength = data.length;

        var x = 0;
        var Weight = 1;
        var num = 0;

        for (x = 0 ; x < data.length; x = x + 2) {
            num = parseInt(data.substr(x, 2), 10);
            Sum = Sum + (num * Weight);
            Weight = Weight + 1;
        }

        Result = Sum % 103;
        strResult = getCode128CCharacter(Result);
        return strResult;
    }

    function OptimizeNumbers(data, x, strResult, num) {

        var BtoC = String.fromCharCode(231);
        var strResult = strResult + BtoC;

        var endpoint = x + num;
        while (x < endpoint) {
            var twonum = parseInt(data.substr(x, 2), 10);
            strResult = strResult + getCode128CCharacterAuto(twonum);
            x = x + 2;
        }

        var CtoB = String.fromCharCode(232);
        strResult = strResult + CtoB;
        return strResult;
    }

    function ScanAhead_8orMore_Numbers(data, x) {
        var numNumbers = 0;
        var exitx = 0;
        while ((x < data.length) && (exitx == 0)) {
            var barcodechar = data.substr(x, 1);
            var barcodevalue = barcodechar.charCodeAt(0);
            if (barcodevalue >= 48 && barcodevalue <= 57)
                numNumbers = numNumbers + 1;
            else
                exitx = 1;

            x = x + 1;

        }
        if (numNumbers > 8) {
            if (numNumbers % 2 == 1)
                numNumbers = numNumbers - 1;
        }
        return numNumbers;

    }

    function getAutoSwitchingAB(data) {

        var datalength = 0;
        var strResult = "";
        var shiftchar = String.fromCharCode(230);

        datalength = data.length;
        var barcodechar = "";
        var x = 0;

        for (x = 0; x < datalength; x++) {
            barcodechar = data.substr(x, 1);
            var barcodevalue = barcodechar.charCodeAt(0);

            if (barcodevalue == 31) {
                barcodechar = String.fromCharCode(barcodechar.charCodeAt(0) + 96 + 100);
                strResult = strResult + barcodechar;
            }
            else if (barcodevalue == 127) {
                barcodechar = String.fromCharCode(barcodechar.charCodeAt(0) + 100);
                strResult = strResult + barcodechar;
            }
            else {
                num = ScanAhead_8orMore_Numbers(data, x);

                if (num >= 8) {
                    strResult = OptimizeNumbers(data, x, strResult, num);
                    x = x + num;
                    x = x - 1;
                }
                else
                    strResult = strResult + barcodechar;
            }

        }
        return strResult;

    }


    function detectAllNumbers(data) {
        var Result = "";
        var allnumbers = 1;

        var datalength = data.length;

        if (datalength % 2 == 1)
            allnumbers = 0;
        else {
            for (x = 0; x < datalength; x++) {
                var barcodechar = data.charCodeAt(x);
                if ((barcodechar <= 57) && (barcodechar >= 48)) {
                }
                else
                    allnumbers = 0;
            }
        }

        return allnumbers;

    }


    function addShift(data) {
        var datalength = 0;
        var strResult = "";
        var shiftchar = String.fromCharCode(230);

        datalength = data.length;

        for (x = 0; x < datalength; x++) {
            var barcodechar = data.substr(x, 1);
            var barcodevalue = barcodechar.charCodeAt(0);
            if ((barcodevalue <= 31) && (barcodevalue >= 0)) {

                strResult = strResult + shiftchar;
                barcodechar = String.fromCharCode(barcodechar.charCodeAt(0) + 96);
                strResult = strResult + barcodechar;
            }
            else
                strResult = strResult + barcodechar;



        }

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