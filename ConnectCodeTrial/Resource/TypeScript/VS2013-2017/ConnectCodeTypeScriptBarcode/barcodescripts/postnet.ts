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

        export class POSTNET extends CCBarcode {

            constructor(data: string) {
                super(data, false);               
            }

            encode(): string {
                var Result = "";
                var cd = "";
                var filtereddata = "";
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (filteredlength > 11) {
                    filtereddata = filtereddata.substr(0, 11);
                }
                cd = this.generateCheckDigit(filtereddata);

                this.connectcode_human_readable_text = this.html_escape(filtereddata + cd);

                Result = "{" + filtereddata + cd + "}";
                Result = this.html_escape(Result);
                return Result;
            }


            getPOSTNETCharacter(inputdecimal: number): number {
            return inputdecimal + 48;
        }

            getPOSTNETValue(inputdecimal: number): number {
            return inputdecimal - 48;
        }

            filterInput(data: string): string {
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
            var datalength = 0;
            var Sumx = 0;
            var result = -1;
            var strResult = "";
            var barcodechar = "";

            datalength = data.length;
            for (var x:number = 0; x < datalength; x++) {
                Sumx = Sumx + this.getPOSTNETValue(data.charCodeAt(x));
            }

            result = Sumx % 10;
            if (result != 0) {
                result = (10 - result);
            }

            strResult = result.toString();

            return strResult;
        }


        }
    }
}