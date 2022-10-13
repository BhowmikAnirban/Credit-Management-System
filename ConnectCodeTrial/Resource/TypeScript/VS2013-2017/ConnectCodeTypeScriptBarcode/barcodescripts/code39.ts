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

        export class Code39 extends CCBarcode {

            constructor(data: string, checkDigit: boolean=false) {
                super(data, checkDigit);               
            }

            encode(): string {
                var result: string = "";
                var cd: string = "";
                var filtereddata: string = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (this.checkDigit == true) {
                    if (filteredlength > 254) {
                        filtereddata = filtereddata.substr(0, 254);
                    }
                    cd = this.generateCheckDigit(filtereddata);
                }
                else {
                    if (filteredlength > 255) {
                        filtereddata = filtereddata.substr(0, 255);
                    }
                }
                result = "*" + filtereddata + cd + "*";
                result = this.html_escape(result);                
                this.connectcode_human_readable_text = this.html_escape("*" + filtereddata + cd + "*");
                return result;
            }

            filterInput(data: string) {
                var result = "";
                var datalength = data.length;
                for (var x: number = 0; x < datalength; x++) {
                    if (this.getCode39Value(data.substr(x, 1)) != -1) {
                        result = result + data.substr(x, 1);
                    }
                }
                return result;
            }

            getCode39Character(inputdecimal: number): string {
                var CODE39MAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                    "U", "V", "W", "X", "Y", "Z", "-", ".", " ", "$",
                    "/", "+", "%");
                return CODE39MAP[inputdecimal];
            }

            generateCheckDigit(data: string): string {

                var result = "";
                var datalength = data.length;
                var sumValue = 0;
                for (var x: number = 0; x < datalength; x++) {
                    sumValue = sumValue + this.getCode39Value(data.substr(x, 1));
                }
                sumValue = sumValue % 43;
                return this.getCode39Character(sumValue);

            }

            getCode39Value(inputchar:string): number {
                var CODE39MAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                    "U", "V", "W", "X", "Y", "Z", "-", ".", " ", "$",
                    "/", "+", "%");
                var rVal: number = -1;
                for (var i: number = 0; i < 43; i++) {
                    if (inputchar == CODE39MAP[i]) {
                        rVal = i;
                    }
                }
                return rVal;
            }
        }
    }
}