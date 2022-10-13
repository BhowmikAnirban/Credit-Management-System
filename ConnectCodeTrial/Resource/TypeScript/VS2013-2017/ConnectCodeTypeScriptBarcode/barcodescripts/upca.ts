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

module net {
    export module connectcode {

        export class UPCA extends CCBarcode {
            hr: boolean=false;
            constructor(data: string, hr: boolean= false) {
                super(data, false);             
                this.hr = hr;
            }

            encode(): string {
                var cd = "";
                var Result = "";
                var filtereddata = this.filterInput(this.data);
                var transformdataleft = "";
                var transformdataright = "";

                var filteredlength = filtereddata.length;

                if (filteredlength > 11) {
                    filtereddata = filtereddata.substr(0, 11);
                }

                if (filteredlength < 11) {
                    var addcharlength = 11 - filtereddata.length;
                    for (var x = 0; x < addcharlength; x++) {
                        filtereddata = "0" + filtereddata
                       }
                }

                cd = this.generateCheckDigit(filtereddata);

                filtereddata = filtereddata + cd;

                this.connectcode_human_readable_text = this.html_escape(filtereddata);

                var datalength = 0;
                datalength = filtereddata.length;
                for (x = 0; x < 6; x++) {
                    transformdataleft = transformdataleft + filtereddata.substr(x, 1);
                }

                for (x = 6; x < 12; x++) {
                    var transformchar = filtereddata.charCodeAt(x);
                    transformchar = transformchar + 49
                       transformdataright = transformdataright + String.fromCharCode(transformchar);
                }

                if (this.hr == true) {

                    Result = String.fromCharCode(transformdataleft.charCodeAt(0) - 15) + "[" + String.fromCharCode(transformdataleft.charCodeAt(0) + 110) + transformdataleft.substr(1, 5) + "-" + transformdataright.substr(0, 5) + String.fromCharCode(transformdataright.charCodeAt(5) - 49 + 159) + "]" + String.fromCharCode(transformdataright.charCodeAt(5) - 49 - 15);
                }
                else {
                    Result = "[" + transformdataleft + "-" + transformdataright + "]";
                }
                Result = this.html_escape(Result);
                return Result;
            }

		getUPCACharacter(inputdecimal:number):number {
            return (inputdecimal + 48);
        }

            generateCheckDigit(data: string): string {
            var datalength = 0;
            var Sum = 0;
            var Result = -1;
            var strResult = "";
            var barcodechar = "";
            var barcodevalue = 0;

            datalength = data.length;

            for (var x = 0; x < datalength; x++) {

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


            filterInput(data: string): string {
            var Result = "";
            var datalength = data.length;
            for (var x = 0; x < datalength; x++) {
                if (data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57) {
                    Result = Result + data.substr(x, 1);
                }
            }
            return Result;
        }

        }
    }
}