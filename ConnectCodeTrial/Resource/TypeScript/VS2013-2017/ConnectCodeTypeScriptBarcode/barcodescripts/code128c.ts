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

        export class Code128C extends CCBarcode {

            constructor(data: string) {
                super(data, false);
            }

            encode(): string {
                var cd = "";
                var result = "";
                var filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;

                if (filteredlength > 253) {
                    filtereddata = filtereddata.substr(0, 253);
                }

                if (filtereddata.length % 2 == 1) {
                    filtereddata = "0" + filtereddata;
                }

                this.connectcode_human_readable_text = this.html_escape(filtereddata);

                cd = this.generateCheckDigit(filtereddata);
                for (var x:number = 0; x < filtereddata.length; x = x + 2) {
                    var num = parseInt(filtereddata.substr(x, 2), 10);
                    result = result + this.getCode128CCharacter(num);
                }

                result = result + cd;

                var startc = 237;
                var stopc = 238;
                result = String.fromCharCode(startc) + result + String.fromCharCode(stopc);
                result = this.html_escape(result);
                return result;
            }

            getCode128CCharacter(inputvalue:number) {
                if ((inputvalue <= 94) && (inputvalue >= 0)) {
                    inputvalue = inputvalue + 32;
                }
                else if ((inputvalue <= 106) && (inputvalue >= 95)) {
                    inputvalue = inputvalue + 32 + 100;
                }
                else {
                    inputvalue = -1;
                }
                return String.fromCharCode(inputvalue);

            }

            filterInput(data: string): string {
                var Result = "";
                var datalength = data.length;
                for (var x: number = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 48 && data.charCodeAt(x) <= 57) {
                        Result = Result + data.substr(x, 1);
                    }
                }

                return Result;
            }

            generateCheckDigit(data: string): string {
                var datalength = 0;
                var Sum = 105;
                var Result = -1;
                var strResult = "";

                datalength = data.length;

                var x = 0;
                var Weight = 1;
                var num = 0;

                for (x = 0; x < data.length; x = x + 2) {
                    num = parseInt(data.substr(x, 2), 10);
                    Sum = Sum + (num * Weight);
                    Weight = Weight + 1;
                }

                Result = Sum % 103;
                strResult = this.getCode128CCharacter(Result);
                return strResult;
            }

        }
    }
}