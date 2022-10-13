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

        export class Code93 extends CCBarcode {

            constructor(data: string, checkDigit: boolean= false) {
                super(data, checkDigit);               
            }

            encode(): string {
                var Result = "";
                var cd = "";
                var filtereddata = "";
                var textcd = "";
                var barcodevalue = 0;
                filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (this.checkDigit == true) {
                    if (filteredlength > 254) {
                        filtereddata = filtereddata.substr(0, 254);
                    }
                    cd = this.generateCheckDigit(filtereddata);

                    barcodevalue = cd.charCodeAt(0);
                    if (barcodevalue == 193) {
                        textcd = "($)";
                    }
                    else if (barcodevalue == 194) {
                        textcd = "(%)";
                    }
                    else if (barcodevalue == 195) {
                        textcd = "(/)";
                    }
                    else if (barcodevalue == 196) {
                        textcd = "(+)";
                    }
                    else {
                        textcd = cd[0];
                    }
                    barcodevalue = cd.charCodeAt(1);
                    if (barcodevalue == 193) {
                        textcd = textcd + "($)";
                    }
                    else if (barcodevalue == 194) {
                        textcd = textcd + "(%)";
                    }
                    else if (barcodevalue == 195) {
                        textcd = textcd + "(/)";
                    }
                    else if (barcodevalue == 196) {
                        textcd = textcd + "(+)";
                    }
                    else {
                        textcd = textcd + cd[1];
                    }


                }
                else {
                    if (filteredlength > 255) {
                        filtereddata = filtereddata.substr(0, 255);
                    }
                }

                this.connectcode_human_readable_text = this.html_escape("*" + filtereddata + textcd + "*");

                var datalength = 0;
                datalength = filtereddata.length;
                for (var x:number = 0; x < datalength; x++) {
                    Result = Result + this.translate_Code93(filtereddata.charCodeAt(x));
                }

                Result = String.fromCharCode(197) + Result + cd + String.fromCharCode(198);
                Result = this.html_escape(Result);
                return Result;
            }

            getCode93Character(inputx:number) {

                if ((inputx >= 43) && (inputx <= 46)) {
                    inputx = inputx + 150;
                }
                else if (inputx == 38) {
                    inputx = 32;
                }
                else if (inputx == 39) {
                    inputx = 36;
                }
                else if (inputx == 42) {
                    inputx = 37;
                }
                else if (inputx == 41) {
                    inputx = 43;
                }
                else if (inputx == 36) {
                    inputx = 45;
                }
                else if (inputx == 37) {
                    inputx = 46;
                }
                else if (inputx == 40) {
                    inputx = 47;
                }
                else if ((inputx >= 0) && (inputx <= 9)) {
                    inputx = inputx + 48;
                }
                else if ((inputx >= 10) && (inputx <= 35)) {
                    inputx = inputx + 55;
                }
                return inputx;
            }

            getCode93Value(inputx:number) {
                if ((inputx >= 193) && (inputx <= 196)) {
                    inputx = inputx - 150;
                }
                else if (inputx == 32) {
                    inputx = 38;
                }
                else if (inputx == 36) {
                    inputx = 39;
                }
                else if (inputx == 37) {
                    inputx = 42;
                }
                else if (inputx == 43) {
                    inputx = 41;
                }
                else if (inputx == 45) {
                    inputx = 36;
                }
                else if (inputx == 46) {
                    inputx = 37;
                }
                else if (inputx == 47) {
                    inputx = 40;
                }
                else if ((inputx >= 48) && (inputx <= 57)) {
                    inputx = inputx - 48;
                }
                else if ((inputx >= 65) && (inputx <= 90)) {
                    inputx = inputx - 55;
                }
                return inputx;
            }

            filterInput(data:string) {
                var Result = "";
                var datalength = data.length;
                for (var x:number = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 0 && data.charCodeAt(x) <= 127) {
                        Result = Result + data.substr(x, 1);
                    }
                }
                return Result;
            }

            generateCheckDigit(data: string) {
                var cchk:number;
                var kchk: number;
                var sumx: number;
                var x: number;
                var translatedStr: string;
                var weight: number;
                var code93value: number;
                var barcodechar:string;
                var forceReturn: number;

                cchk = 0;
                kchk = 0;
                forceReturn = 0;
                sumx = 0;
                x = 0;
                translatedStr = "";
                weight = 1;
                code93value = 0;
                barcodechar = "";

                x = data.length - 1;
                while (x >= 0) {
                    translatedStr = this.translate_Code93(data.charCodeAt(x));
                    if (translatedStr.length == 2) {
                        code93value = this.getCode93Value(translatedStr.charCodeAt(1));

                        if (weight > 20) {
                            weight = 1;
                        }
                        sumx = sumx + (weight * code93value);
                        weight = weight + 1;

                        code93value = this.getCode93Value(translatedStr.charCodeAt(0));
                        if (weight > 20) {
                            weight = 1;
                        }

                        sumx = sumx + (weight * code93value);
                        weight = weight + 1;
                    }
                    else if (translatedStr.length == 1) {
                        code93value = this.getCode93Value(translatedStr.charCodeAt(0));
                        if (weight > 20) {
                            weight = 1;
                        }
                        sumx = sumx + (weight * code93value);
                        weight = weight + 1;
                    }
                    else {
                        forceReturn = 1;
                    }

                    x = x - 1;

                }

                cchk = sumx % 47;
                weight = 2;
                sumx = sumx % 47;
                x = data.length - 1;
                while (x >= 0) {
                    translatedStr = this.translate_Code93(data.charCodeAt(x));

                    if (translatedStr.length == 2) {
                        code93value = this.getCode93Value(translatedStr.charCodeAt(1))
                            if (weight > 15) {
                            weight = 1;
                        }
                        sumx = sumx + (weight * code93value);
                        weight = weight + 1;

                        code93value = this.getCode93Value(translatedStr.charCodeAt(0));
                        if (weight > 15) {
                            weight = 1;
                        }
                        sumx = sumx + (weight * code93value);
                        weight = weight + 1;
                    }
                    else if (translatedStr.length == 1) {
                        code93value = this.getCode93Value(translatedStr.charCodeAt(0))
                            if (weight > 15) {
                            weight = 1;
                        }
                        sumx = sumx + (weight * code93value);
                        weight = weight + 1;
                    }
                    else {
                        forceReturn = 1;
                    }
                    x = x - 1;
                }
                kchk = sumx % 47;

                if (forceReturn == 1) {
                    return "";
                }
                else {
                    return String.fromCharCode(this.getCode93Character(cchk)) + String.fromCharCode(this.getCode93Character(kchk));
                }
            }


            translate_Code93(inputx:number) {
                var Result = "";
                switch (inputx) {
                    case 0:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(85);
                        break;
                    case 1:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(65);
                        break;
                    case 2:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(66);
                        break;
                    case 3:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(67);
                        break;
                    case 4:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(68);
                        break;
                    case 5:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(69);
                        break;
                    case 6:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(70);
                        break;
                    case 7:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(71);
                        break;
                    case 8:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(72);
                        break;
                    case 9:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(73);
                        break;
                    case 10:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(74);
                        break;
                    case 11:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(75);
                        break;
                    case 12:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(76);
                        break;
                    case 13:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(77);
                        break;
                    case 14:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(78);
                        break;
                    case 15:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(79);
                        break;
                    case 16:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(80);
                        break;
                    case 17:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(81);
                        break;
                    case 18:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(82);
                        break;
                    case 19:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(83);
                        break;
                    case 20:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(84);
                        break;
                    case 21:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(85);
                        break;
                    case 22:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(86);
                        break;
                    case 23:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(87);
                        break;
                    case 24:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(88);
                        break;
                    case 25:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(89);
                        break;
                    case 26:
                        Result = Result + String.fromCharCode(193);
                        Result = Result + String.fromCharCode(90);
                        break;
                    case 27:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(65);
                        break;
                    case 28:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(66);
                        break;
                    case 29:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(67);
                        break;
                    case 30:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(68);
                        break;
                    case 31:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(69);
                        break;
                    case 32:
                        Result = Result + String.fromCharCode(32);
                        break;
                    case 33:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(65);
                        break;
                    case 34:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(66);
                        break;
                    case 35:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(67);
                        break;
                    case 36:
                        Result = Result + String.fromCharCode(36);
                        break;
                    case 37:
                        Result = Result + String.fromCharCode(37);
                        break;
                    case 38:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(70);
                        break;
                    case 39:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(71);
                        break;
                    case 40:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(72);
                        break;
                    case 41:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(73);
                        break;
                    case 42:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(74);
                        break;
                    case 43:
                        Result = Result + String.fromCharCode(43);
                        break;
                    case 44:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(76);
                        break;
                    case 45:
                        Result = Result + String.fromCharCode(45);
                        break;
                    case 46:
                        Result = Result + String.fromCharCode(46);
                        break;
                    case 47:
                        Result = Result + String.fromCharCode(47);
                        break;
                    case 48:
                        Result = Result + String.fromCharCode(48);
                        break;
                    case 49:
                        Result = Result + String.fromCharCode(49);
                        break;
                    case 50:
                        Result = Result + String.fromCharCode(50);
                        break;
                    case 51:
                        Result = Result + String.fromCharCode(51);
                        break;
                    case 52:
                        Result = Result + String.fromCharCode(52);
                        break;
                    case 53:
                        Result = Result + String.fromCharCode(53);
                        break;
                    case 54:
                        Result = Result + String.fromCharCode(54);
                        break;
                    case 55:
                        Result = Result + String.fromCharCode(55);
                        break;
                    case 56:
                        Result = Result + String.fromCharCode(56);
                        break;
                    case 57:
                        Result = Result + String.fromCharCode(57);
                        break;
                    case 58:
                        Result = Result + String.fromCharCode(195);
                        Result = Result + String.fromCharCode(90);
                        break;
                    case 59:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(70);
                        break;
                    case 60:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(71);
                        break;
                    case 61:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(72);
                        break;
                    case 62:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(73);
                        break;
                    case 63:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(74);
                        break;
                    case 64:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(86);
                        break;
                    case 65:
                        Result = Result + String.fromCharCode(65);
                        break;
                    case 66:
                        Result = Result + String.fromCharCode(66);
                        break;
                    case 67:
                        Result = Result + String.fromCharCode(67);
                        break;
                    case 68:
                        Result = Result + String.fromCharCode(68);
                        break;
                    case 69:
                        Result = Result + String.fromCharCode(69);
                        break;
                    case 70:
                        Result = Result + String.fromCharCode(70);
                        break;
                    case 71:
                        Result = Result + String.fromCharCode(71);
                        break;
                    case 72:
                        Result = Result + String.fromCharCode(72);
                        break;
                    case 73:
                        Result = Result + String.fromCharCode(73);
                        break;
                    case 74:
                        Result = Result + String.fromCharCode(74);
                        break;
                    case 75:
                        Result = Result + String.fromCharCode(75);
                        break;
                    case 76:
                        Result = Result + String.fromCharCode(76);
                        break;
                    case 77:
                        Result = Result + String.fromCharCode(77);
                        break;
                    case 78:
                        Result = Result + String.fromCharCode(78);
                        break;
                    case 79:
                        Result = Result + String.fromCharCode(79);
                        break;
                    case 80:
                        Result = Result + String.fromCharCode(80);
                        break;
                    case 81:
                        Result = Result + String.fromCharCode(81);
                        break;
                    case 82:
                        Result = Result + String.fromCharCode(82);
                        break;
                    case 83:
                        Result = Result + String.fromCharCode(83);
                        break;
                    case 84:
                        Result = Result + String.fromCharCode(84);
                        break;
                    case 85:
                        Result = Result + String.fromCharCode(85);
                        break;
                    case 86:
                        Result = Result + String.fromCharCode(86);
                        break;
                    case 87:
                        Result = Result + String.fromCharCode(87);
                        break;
                    case 88:
                        Result = Result + String.fromCharCode(88);
                        break;
                    case 89:
                        Result = Result + String.fromCharCode(89);
                        break;
                    case 90:
                        Result = Result + String.fromCharCode(90);
                        break;
                    case 91:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(75);
                        break;
                    case 92:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(76);
                        break;
                    case 93:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(77);
                        break;
                    case 94:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(78);
                        break;
                    case 95:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(79);
                        break;
                    case 96:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(87);
                        break;
                    case 97:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(65);
                        break;
                    case 98:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(66);
                        break;
                    case 99:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(67);
                        break;
                    case 100:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(68);
                        break;
                    case 101:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(69);
                        break;
                    case 102:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(70);
                        break;
                    case 103:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(71);
                        break;
                    case 104:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(72);
                        break;
                    case 105:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(73);
                        break;
                    case 106:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(74);
                        break;
                    case 107:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(75);
                        break;
                    case 108:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(76);
                        break;
                    case 109:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(77);
                        break;
                    case 110:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(78);
                        break;
                    case 111:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(79);
                        break;
                    case 112:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(80);
                        break;
                    case 113:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(81);
                        break;
                    case 114:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(82);
                        break;
                    case 115:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(83);
                        break;
                    case 116:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(84);
                        break;
                    case 117:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(85);
                        break;
                    case 118:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(86);
                        break;
                    case 119:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(87);
                        break;
                    case 120:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(88);
                        break;
                    case 121:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(89);
                        break;
                    case 122:
                        Result = Result + String.fromCharCode(196);
                        Result = Result + String.fromCharCode(90);
                        break;
                    case 123:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(80);
                        break;
                    case 124:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(81);
                        break;
                    case 125:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(82);
                        break;
                    case 126:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(83);
                        break;
                    case 127:
                        Result = Result + String.fromCharCode(194);
                        Result = Result + String.fromCharCode(84);
                        break;
                }
                return Result;

            }

        }
    }
}