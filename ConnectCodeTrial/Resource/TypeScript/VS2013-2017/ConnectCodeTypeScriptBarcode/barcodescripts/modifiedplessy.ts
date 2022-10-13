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

        export class ModifiedPlessy extends CCBarcode {

            constructor(data: string, checkDigit: boolean= false) {
                super(data, checkDigit);               
            }

            encode(): string {
                var Result = "";
                var cd = "";
                var filtereddata = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (this.checkDigit == true) {
                    if (filteredlength > 15) {
                        filtereddata = filtereddata.substr(0, 15);
                    }
                    cd = this.generateCheckDigit(filtereddata);
                }
                else {
                    if (filteredlength > 16) {
                        filtereddata = filtereddata.substr(0, 16);
                    }
                }

                this.connectcode_human_readable_text = this.html_escape(filtereddata + cd);

                Result = "{" + filtereddata + cd + "}";
                Result = this.html_escape(Result);
                return Result;
            }

        filterInput(data:string):string {
            var Result = "";
            var datalength = data.length;
            for (var x:number = 0; x < datalength; x++) {
                if (data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57) {
                    Result = Result + data.substr(x, 1);
                }
            }
            return Result;
        }

            generateCheckDigit(data: string): string {
            var doublechar = "";
            var doubleStr = "";
            var doubleNumber = 0;

            var datalength = 0;
            var lastcharpos = 0;
            var Result = 0;
            var strResult = "";
            var barcodechar = "";
            var barcodevalue = 0;
            var toggle = 1;
            var Sum = 0;

            datalength = data.length;
            lastcharpos = datalength - 1;

            for (var x:number = lastcharpos; x >= 0; x--) {
                barcodevalue = data.charCodeAt(x) - 48;

                if (toggle == 1) {
                    doubleStr = data.substr(x, 1) + doubleStr;
                    toggle = 0;
                }
                else {
                    Sum = Sum + barcodevalue;
                    toggle = 1;
                }
            }

            doubleNumber = parseInt(doubleStr, 10);
            doubleNumber = doubleNumber * 2;
            doubleStr = doubleNumber.toString();

            for (var y:number = 0; y < doubleStr.length; y++) {
                barcodevalue = doubleStr.charCodeAt(y) - 48;
                Sum = Sum + barcodevalue;
            }

            if ((Sum % 10) == 0) {
                Result = 48;
            }
            else {
                Result = (10 - (Sum % 10)) + 48;
            }
            strResult = (Result - 48).toString();
            return strResult;
        }


        }
    }
}