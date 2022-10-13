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

        export class I2of5 extends CCBarcode {

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
                    if (filteredlength > 253) {
                        filtereddata = filtereddata.substr(0, 253);
                    }

                    if (filtereddata.length % 2 == 0) {
                        filtereddata = "0" + filtereddata
				}

                    cd = this.generateCheckDigit(filtereddata);
                }
                else {
                    if (filteredlength > 254) {
                        filtereddata = filtereddata.substr(0, 254);
                    }
                    if (filtereddata.length % 2 == 1) {
                        filtereddata = "0" + filtereddata
				}

                }
                filtereddata = filtereddata + cd;

                this.connectcode_human_readable_text = this.html_escape(filtereddata);

                var num = 0;
                for (var x:number = 0; x < filtereddata.length; x = x + 2) {
                    num = parseInt(filtereddata.substr(x, 2), 10);
                    Result = Result + this.getI2of5Character(num)
    			}
                Result = "{" + Result + "}";
                Result = this.html_escape(Result);
                return Result;
            }


        getI2of5Character(inputvalue:number) {
            if ((inputvalue <= 90) && (inputvalue >= 0)) {
                inputvalue = inputvalue + 32;
            }
            else if ((inputvalue <= 99) && (inputvalue >= 91)) {
                inputvalue = inputvalue + 100;
            }
            else {
                inputvalue = -1;
            }
            return String.fromCharCode(inputvalue);
        }

            filterInput(data: string): string {
            var Result = "";
            var datalength = data.length;
            for (var x:number = 0; x < datalength; x++) {
                if ((data.charCodeAt(x) >= 48) && (data.charCodeAt(x) <= 57)) {
                    Result = Result + data.substr(x, 1);
                }
            }

            return Result;
        }

            generateCheckDigit(data: string): string {
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

            for (var x:number = lastcharpos; x >= 0; x--) {
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


        }
    }
}