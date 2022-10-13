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

        export class EAN8 extends CCBarcode {

            hr: boolean = false;
            constructor(data: string, hr: boolean= false) {
                super(data, false);
                this.hr = hr;
            }

            encode(): string {
                var Result = "";
                var cd = "";
                var filtereddata = "";

                var transformdataleft = "";
                var transformdataright = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;


                if (filteredlength > 7) {
                    filtereddata = filtereddata.substr(0, 7);
                }

                if (filteredlength < 7) {
                    var addcharlength = 7 - filtereddata.length;
                    for (var x = 0; x < addcharlength; x++) {
                        filtereddata = "0" + filtereddata;
                    }
                }


                cd = this.generateCheckDigit(filtereddata);

                this.connectcode_human_readable_text = this.html_escape(filtereddata + cd);

                filtereddata = filtereddata + cd;
                var datalength = 0;
                datalength = filtereddata.length;

                for (x = 0; x < 4; x++) {
                    transformdataleft = transformdataleft + filtereddata.substr(x, 1);
                }

                var transformchar = "";
                for (x = 4; x < 8; x++) {
                    transformchar = filtereddata.substr(x, 1);

                    transformchar = String.fromCharCode(filtereddata.charCodeAt(x) + 49);

                    transformdataright = transformdataright + transformchar;
                }

                Result = "[" + transformdataleft + "-" + transformdataright + "]";
                Result = this.html_escape(Result);
                return Result;
            }

            generateCheckDigit(data: string): string {
            var datalength = 0;
            var parity = 0;
            var Sum = 0;
            var Result = -1;
            var strResult = "";
            var barcodechar = "";
            var barcodevalue = 0;

            datalength = data.length;

            for (var x = 0; x < datalength; x++) {

                barcodevalue = (data.charCodeAt(x) - 48);
                if (parity == 0) {
                    Sum = Sum + (3 * barcodevalue);
                    parity = 1;
                }
                else {
                    Sum = Sum + barcodevalue;
                    parity = 0;
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