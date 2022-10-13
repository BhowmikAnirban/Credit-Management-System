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

        export class Code128B extends CCBarcode {

            constructor(data: string) {
                super(data, false);
            }

            encode(): string {
                var cd = "";
                var result = "";
                var filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;

                if (filteredlength > 254) {
                    filtereddata = filtereddata.substr(0, 254);
                }
                cd = this.generateCheckDigit(filtereddata);

                this.connectcode_human_readable_text = this.html_escape(filtereddata);

                for (var x = 0; x < filtereddata.length; x++) {
                    var c = filtereddata.charCodeAt(x);
                    if (c == 127) {
                        c = c + 100
			     }
                    else {
                        c = c;
                    }

                    result = result + String.fromCharCode(c);

                }

                result = result + cd;

                var startc = 236;
                var stopc = 238;
                result = String.fromCharCode(startc) + result + String.fromCharCode(stopc);
                result = this.html_escape(result);
                return result;

            }

            getCode128BCharacter(inputvalue:number) {

                if ((inputvalue <= 94) && (inputvalue >= 0)) {
                    inputvalue = inputvalue + 32;
                }
                else if ((inputvalue <= 106) && (inputvalue >= 95)) {
                    inputvalue = inputvalue + 100 + 32;
                }
                else {
                    inputvalue = -1;
                }

                return String.fromCharCode(inputvalue);

            }

            getCode128BValue(inputchar:number) {

                var returnvalue = 0;

                if ((inputchar <= 127) && (inputchar >= 32)) {
                    returnvalue = (inputchar - 32);
                }
                else {
                    returnvalue = -1;
                }

                return returnvalue;

            }

            filterInput(data: string): string {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 32 && data.charCodeAt(x) <= 127) {
                        Result = Result + data.substr(x, 1);
                    }
                }

                return Result;
            }

            generateCheckDigit(data: string): string {
                var datalength = 0;
                var Sum = 104;
                var Result = -1;
                var strResult = "";

                datalength = data.length;

                var x = 0;
                var Weight = 1;
                var num = 0;

                for (x = 0; x < data.length; x++) {
                    num = data.charCodeAt(x);
                    Sum = Sum + (this.getCode128BValue(num) * (Weight));
                    Weight = Weight + 1;
                }

                Result = Sum % 103;
                strResult = this.getCode128BCharacter(Result);
                return strResult;
            }

        }
    }
}