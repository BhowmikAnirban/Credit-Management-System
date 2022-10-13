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

        export class Codabar extends CCBarcode {

            constructor(data: string) {
                super(data, false);
            }

            encode(): string {
                var result: string = "";
                var cd = "";
                var filtereddata = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (filteredlength > 255) {
                    filtereddata = filtereddata.substr(0, 255);
                }
                result = filtereddata;
                result = this.html_escape(result);
                this.connectcode_human_readable_text = result;
                return result;
            }

            getCodeCodabarValue(inputchar:string) {
                var CODECODABARMAP = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "-", ".", "$", "/", "+", ":");

                var RVal = -1;
                for (var i: number = 0; i < 20; i++) {
                    if (inputchar == CODECODABARMAP[i]) {
                        RVal = i;
                    }
                }
                return RVal;
            }

            filterInput(data: string): string {
                var Result = "";
                var datalength = this.data.length;
                for (var x: number = 0; x < datalength; x++) {
                    if (this.getCodeCodabarValue(this.data.substr(x, 1)) != -1) {
                        Result = Result + this.data.substr(x, 1);
                    }
                }
                return Result;
            }
        }
    }
}