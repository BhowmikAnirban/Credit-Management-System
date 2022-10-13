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

        export interface Barcode {

            encode(): string;
            getHRText(): string;
            overrideNewLine(nl:string):void;
            lengthExceeded2D():number;

        }

        export class CCBarcode implements Barcode {

            connectcode_human_readable_text: string;
            data: string
            checkDigit: boolean;
            newline: string = "<br>";

            constructor(data: string, checkDigit: boolean) {
                //\\ and \" is treated as 1 char so it need not be unescape
                this.data = this.html_decode(data);                
                this.checkDigit = checkDigit;
                this.connectcode_human_readable_text = "";
            }

            encode(): string {
                return this.data;
            }

            overrideNewLine(nl: string) {
                this.newline = nl;
            }

            generateCheckDigit(data: string): string {
                return "";
            }

            getHRText(): string {
                return this.connectcode_human_readable_text;
            }

            filterInput(data: string) {
                return data;
            }

            html_escape(data:string): string {
                var result = "";
                for (var x: number = 0; x < data.length; x++) {
                    result = result + "&#" + data.charCodeAt(x).toString() + ";";
                }
                return result;
            }

            html_decode(str:string): string {
                var ta = document.createElement("textarea"); //this line converts &#.. back into html
                ta.innerHTML = str.replace(/</g, "&lt;").replace(/>/g, "&gt;"); //so if have a < must replace
                return ta.value;
            }
         
            lengthExceeded2D(): number {
                return 0;
            }

        }
        
    }
}