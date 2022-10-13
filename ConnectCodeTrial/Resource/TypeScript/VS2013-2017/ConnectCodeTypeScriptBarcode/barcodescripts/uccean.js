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
var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
var net;
(function (net) {
    (function (connectcode) {
        var UCCEAN = (function (_super) {
            __extends(UCCEAN, _super);
            function UCCEAN(data, gs1Compliance) {
                if (typeof gs1Compliance === "undefined") { gs1Compliance = true; }
                _super.call(this, data, false);
                this.gs1Compliance = true;
                this.gs1Compliance = gs1Compliance;
            }
            UCCEAN.prototype.encode = function () {
                var cd = "";
                var Result = "";
                var replacedata102 = "";
                var replacedata234 = "";
                var replacedata234text = "";

                var filtereddata = this.filterInput(this.data);
                var filteredlength = filtereddata.length;
                if (filteredlength > 254) {
                    filtereddata = filtereddata.substr(0, 254);
                }

                replacedata234 = this.replaceUCCEAN(filtereddata, 234, this.gs1Compliance);
                replacedata234text = this.replaceUCCEANText(filtereddata, 234, this.gs1Compliance);

                this.connectcode_human_readable_text = this.html_escape(replacedata234text);

                if (this.detectAllNumbers(replacedata234, this.gs1Compliance) == false) {
                    Result = this.getAutoSwitchingAB(replacedata234);
                    cd = this.generateCheckDigit_Code128ABAuto(replacedata234);
                    Result = Result + cd;
                    startc = 236;
                    stopc = 238;
                    Result = String.fromCharCode(startc) + Result + String.fromCharCode(stopc);
                } else {
                    cd = this.generateCheckDigit_Code128CAuto(replacedata234);

                    var x = 0;
                    var Skip = 0;
                    while (x < replacedata234.length) {
                        Skip = 0;
                        if (replacedata234.charCodeAt(x) == 234) {
                            Result = Result + String.fromCharCode(234);
                            x = x + 1;
                            Skip = 1;
                        }

                        var barcodechar1 = 0;
                        var barcodechar2 = 0;

                        if (Skip == 0) {
                            barcodechar1 = 0;
                            barcodechar2 = 0;
                            barcodechar1 = replacedata234.charCodeAt(x);
                            if (x + 1 < replacedata234.length) {
                                barcodechar2 = replacedata234.charCodeAt(x + 1);
                            }

                            if (barcodechar1 >= 48 && barcodechar1 <= 57 && barcodechar2 >= 48 && barcodechar2 <= 57) {
                                var num = parseInt(replacedata234.substr(x, 2), 10);
                                Result = Result + this.getCode128CCharacterAuto(num);
                                x = x + 2;
                            } else if ((barcodechar1 >= 48 && barcodechar1 <= 57 && barcodechar2 == 234) || (barcodechar1 >= 48 && barcodechar1 <= 57 && barcodechar2 == 0)) {
                                var CtoB = "";
                                var BtoC = "";

                                CtoB = String.fromCharCode(232);
                                Result = Result + CtoB;

                                Result = Result + String.fromCharCode(barcodechar1);
                                x = x + 1;

                                BtoC = String.fromCharCode(231);
                                Result = Result + BtoC;
                            }
                        }
                    }
                    Result = Result + cd;
                    var startc = 237;
                    var stopc = 238;
                    Result = String.fromCharCode(startc) + Result + String.fromCharCode(stopc);
                }
                Result = this.html_escape(Result);
                return Result;
            };

            UCCEAN.prototype.replaceUCCEAN = function (data, fncvalue, GS1Compliance) {
                var replaceUCCEAN = "";
                var Result = "";
                var datalength = data.length;
                var forceNULL = 0;

                var x = 0;
                var numset = 0;
                var exitx = 0;

                var startBracketPosition = new Array(8);
                var stopBracketPosition = new Array(8);

                var aiset = new Array(8);
                var dataset = new Array(8);
                var barcodechar = "";
                var barcodevalue = 0;

                for (var counter = 0; counter < 8; counter++) {
                    startBracketPosition[counter] = -1;
                    stopBracketPosition[counter] = -1;
                }

                x = 0;
                while (x < datalength) {
                    var barcodecharx = data.substr(x, 1);
                    if (barcodecharx == "(") {
                        var y = x + 1;
                        exitx = 0;

                        while ((y < datalength) && (exitx == 0)) {
                            var barcodechary = data.substr(y, 1);
                            if (barcodechary == ")") {
                                startBracketPosition[numset] = x;
                                stopBracketPosition[numset] = y;
                                numset = numset + 1;
                                exitx = 1;
                            }
                            if (exitx == 0)
                                y = y + 1;
                        }
                        x = y;
                    }
                    x = x + 1;
                }

                if (numset == 0) {
                    forceNULL = 0;
                    replaceUCCEAN = String.fromCharCode(fncvalue) + data;
                } else {
                    for (x = 0; x < numset; x++) {
                        aiset[x] = "";
                        dataset[x] = "";

                        if (stopBracketPosition[x] <= startBracketPosition[x]) {
                            forceNULL = 1;
                            replaceUCCEAN = "";
                            return replaceUCCEAN;
                        }

                        if (stopBracketPosition[x] - 1 == startBracketPosition[x]) {
                            forceNULL = 1;
                            replaceUCCEAN = "";
                            return replaceUCCEAN;
                        }
                        for (y = startBracketPosition[x] + 1; y < stopBracketPosition[x]; y++) {
                            barcodechar = data.substr(y, 1);
                            barcodevalue = barcodechar.charCodeAt(0);
                            if ((barcodevalue <= 57 && barcodevalue >= 48) || (barcodevalue <= 90 && barcodevalue >= 65) || (barcodevalue <= 122 && barcodevalue >= 97)) {
                                aiset[x] = aiset[x] + barcodechar;
                            }
                        }

                        if (x == numset - 1) {
                            for (y = stopBracketPosition[x] + 1; y < data.length; y++) {
                                barcodechar = data.substr(y, 1);
                                barcodevalue = barcodechar.charCodeAt(0);
                                if ((barcodevalue <= 57 && barcodevalue >= 48) || (barcodevalue <= 90 && barcodevalue >= 65) || (barcodevalue <= 122 && barcodevalue >= 97)) {
                                    dataset[x] = dataset[x] + barcodechar;
                                }
                            }
                        } else {
                            for (y = stopBracketPosition[x] + 1; y < startBracketPosition[x + 1]; y++) {
                                barcodechar = data.substr(y, 1);
                                barcodevalue = barcodechar.charCodeAt(0);
                                if ((barcodevalue <= 57 && barcodevalue >= 48) || (barcodevalue <= 90 && barcodevalue >= 65) || (barcodevalue <= 122 && barcodevalue >= 97)) {
                                    dataset[x] = dataset[x] + barcodechar;
                                }
                            }
                        }
                    }

                    if (forceNULL == 1) {
                        replaceUCCEAN = "";
                    } else {
                        Result = String.fromCharCode(fncvalue) + Result;
                        var fncstring = String.fromCharCode(fncvalue);
                        for (x = 0; x < numset; x++) {
                            if (x == numset - 1) {
                                Result = Result + aiset[x] + dataset[x];
                            } else {
                                //if (GS1Compliance == true) {
                                if (GS1Compliance == false) {
                                    Result = Result + aiset[x] + dataset[x] + fncstring;
                                } else {
                                    if (aiset[x] == "8002" || aiset[x] == "8003" || aiset[x] == "8004" || aiset[x] == "8007" || aiset[x] == "8008" || aiset[x] == "8020" || aiset[x] == "240" || aiset[x] == "241" || aiset[x] == "250" || aiset[x] == "251" || aiset[x] == "400" || aiset[x] == "401" || aiset[x] == "403" || aiset[x] == "420" || aiset[x] == "421" || aiset[x] == "423" || aiset[x] == "10" || aiset[x] == "21" || aiset[x] == "22" || aiset[x] == "23" || aiset[x] == "30" || aiset[x] == "37" || aiset[x] == "90" || aiset[x] == "91" || aiset[x] == "92" || aiset[x] == "93" || aiset[x] == "94" || aiset[x] == "95" || aiset[x] == "96" || aiset[x] == "97" || aiset[x] == "98" || aiset[x] == "99") {
                                        Result = Result + aiset[x] + dataset[x] + fncstring;
                                    } else {
                                        Result = Result + aiset[x] + dataset[x];
                                    }
                                }
                            }
                        }
                        replaceUCCEAN = Result;
                    }
                }

                if (forceNULL == 1) {
                    replaceUCCEAN = "";
                }
                return replaceUCCEAN;
            };

            UCCEAN.prototype.replaceUCCEANText = function (data, fncvalue, GS1Compliance) {
                var replaceUCCEAN = "";
                var Result = "";
                var datalength = data.length;
                var forceNULL = 0;

                var x = 0;
                var numset = 0;
                var exitx = 0;

                var startBracketPosition = new Array(8);
                var stopBracketPosition = new Array(8);

                var aiset = new Array(8);
                var dataset = new Array(8);
                var barcodechar = "";
                var barcodevalue = 0;

                for (var counter = 0; counter < 8; counter++) {
                    startBracketPosition[counter] = -1;
                    stopBracketPosition[counter] = -1;
                }

                x = 0;
                while (x < datalength) {
                    var barcodecharx = data.substr(x, 1);
                    if (barcodecharx == "(") {
                        var y = x + 1;
                        exitx = 0;

                        while ((y < datalength) && (exitx == 0)) {
                            var barcodechary = data.substr(y, 1);
                            if (barcodechary == ")") {
                                startBracketPosition[numset] = x;
                                stopBracketPosition[numset] = y;
                                numset = numset + 1;
                                exitx = 1;
                            }
                            if (exitx == 0)
                                y = y + 1;
                        }
                        x = y;
                    }
                    x = x + 1;
                }

                if (numset == 0) {
                    forceNULL = 0;
                    replaceUCCEAN = data;
                } else {
                    for (x = 0; x < numset; x++) {
                        aiset[x] = "";
                        dataset[x] = "";

                        if (stopBracketPosition[x] <= startBracketPosition[x]) {
                            forceNULL = 1;
                            replaceUCCEAN = "";
                            return replaceUCCEAN;
                        }

                        if (stopBracketPosition[x] - 1 == startBracketPosition[x]) {
                            forceNULL = 1;
                            replaceUCCEAN = "";
                            return replaceUCCEAN;
                        }
                        for (y = startBracketPosition[x] + 1; y < stopBracketPosition[x]; y++) {
                            barcodechar = data.substr(y, 1);
                            barcodevalue = barcodechar.charCodeAt(0);
                            if ((barcodevalue <= 57 && barcodevalue >= 48) || (barcodevalue <= 90 && barcodevalue >= 65) || (barcodevalue <= 122 && barcodevalue >= 97)) {
                                aiset[x] = aiset[x] + barcodechar;
                            }
                        }

                        if (x == numset - 1) {
                            for (y = stopBracketPosition[x] + 1; y < data.length; y++) {
                                barcodechar = data.substr(y, 1);
                                barcodevalue = barcodechar.charCodeAt(0);
                                if ((barcodevalue <= 57 && barcodevalue >= 48) || (barcodevalue <= 90 && barcodevalue >= 65) || (barcodevalue <= 122 && barcodevalue >= 97)) {
                                    dataset[x] = dataset[x] + barcodechar;
                                }
                            }
                        } else {
                            for (y = stopBracketPosition[x] + 1; y < startBracketPosition[x + 1]; y++) {
                                barcodechar = data.substr(y, 1);
                                barcodevalue = barcodechar.charCodeAt(0);
                                if ((barcodevalue <= 57 && barcodevalue >= 48) || (barcodevalue <= 90 && barcodevalue >= 65) || (barcodevalue <= 122 && barcodevalue >= 97)) {
                                    dataset[x] = dataset[x] + barcodechar;
                                }
                            }
                        }
                    }

                    if (forceNULL == 1) {
                        replaceUCCEAN = "";
                    } else {
                        Result = Result;
                        var fncstring = String.fromCharCode(fncvalue);
                        for (x = 0; x < numset; x++) {
                            if (x == numset - 1) {
                                Result = Result + "(" + aiset[x] + ")" + dataset[x];
                            } else {
                                if (GS1Compliance == false) {
                                    Result = Result + "(" + aiset[x] + ")" + dataset[x];
                                } else {
                                    if (aiset[x] == "8002" || aiset[x] == "8003" || aiset[x] == "8004" || aiset[x] == "8007" || aiset[x] == "8008" || aiset[x] == "8020" || aiset[x] == "240" || aiset[x] == "241" || aiset[x] == "250" || aiset[x] == "251" || aiset[x] == "400" || aiset[x] == "401" || aiset[x] == "403" || aiset[x] == "420" || aiset[x] == "421" || aiset[x] == "423" || aiset[x] == "10" || aiset[x] == "21" || aiset[x] == "22" || aiset[x] == "23" || aiset[x] == "30" || aiset[x] == "37" || aiset[x] == "90" || aiset[x] == "91" || aiset[x] == "92" || aiset[x] == "93" || aiset[x] == "94" || aiset[x] == "95" || aiset[x] == "96" || aiset[x] == "97" || aiset[x] == "98" || aiset[x] == "99") {
                                        Result = Result + "(" + aiset[x] + ")" + dataset[x];
                                    } else {
                                        Result = Result + "(" + aiset[x] + ")" + dataset[x];
                                    }
                                }
                            }
                        }
                        replaceUCCEAN = Result;
                    }
                }

                if (forceNULL == 1) {
                    replaceUCCEAN = "";
                }
                return replaceUCCEAN;
            };

            UCCEAN.prototype.getCode128ABValueAuto = function (inputchar) {
                var returnvalue = 0;

                if ((inputchar <= 31) && (inputchar >= 0))
                    returnvalue = (inputchar + 64);
                else if ((inputchar <= 127) && (inputchar >= 32))
                    returnvalue = (inputchar - 32);
                else if (inputchar == 230)
                    returnvalue = 98;
                else
                    returnvalue = -1;

                return returnvalue;
            };

            UCCEAN.prototype.getCode128ABCharacterAuto = function (inputvalue) {
                if ((inputvalue <= 94) && (inputvalue >= 0))
                    inputvalue = inputvalue + 32;
                else if ((inputvalue <= 106) && (inputvalue >= 95))
                    inputvalue = inputvalue + 100 + 32;
                else
                    inputvalue = -1;

                return String.fromCharCode(inputvalue);
            };

            UCCEAN.prototype.getCode128CCharacterAuto = function (inputvalue) {
                if ((inputvalue <= 94) && (inputvalue >= 0))
                    inputvalue = inputvalue + 32;
                else if ((inputvalue <= 106) && (inputvalue >= 95))
                    inputvalue = inputvalue + 32 + 100;
                else
                    inputvalue = -1;

                return String.fromCharCode(inputvalue);
            };

            UCCEAN.prototype.filterInput = function (data) {
                var Result = "";
                var datalength = data.length;
                for (var x = 0; x < datalength; x++) {
                    if (data.charCodeAt(x) >= 0 && data.charCodeAt(x) <= 127) {
                        Result = Result + data.substr(x, 1);
                    }
                }

                return Result;
            };

            UCCEAN.prototype.generateCheckDigit_Code128ABAuto = function (data) {
                var datalength = 0;
                var Sum = 104;
                var Result = -1;
                var strResult = "";

                datalength = data.length;

                var num = 0;
                var Weight = 1;

                var x = 0;
                while (x < data.length) {
                    num = this.ScanAhead_8orMore_Numbers(data, x);
                    if (num >= 8) {
                        var endpoint = x + num;

                        var BtoC = 99;
                        Sum = Sum + (BtoC * (Weight));
                        Weight = Weight + 1;

                        while (x < endpoint) {
                            num = parseInt(data.substr(x, 2), 10);
                            Sum = Sum + (num * (Weight));
                            x = x + 2;
                            Weight = Weight + 1;
                        }
                        var CtoB = 100;
                        Sum = Sum + (CtoB * (Weight));
                        Weight = Weight + 1;
                    } else {
                        num = data.charCodeAt(x);
                        Sum = Sum + (this.getCode128ABValueAuto(num) * (Weight));
                        x = x + 1;
                        Weight = Weight + 1;
                    }
                }
                Result = Sum % 103;
                strResult = this.getCode128ABCharacterAuto(Result);
                return strResult;
            };

            UCCEAN.prototype.getCode128CCharacter = function (inputvalue) {
                if ((inputvalue <= 94) && (inputvalue >= 0))
                    inputvalue = inputvalue + 32;
                else if ((inputvalue <= 106) && (inputvalue >= 95))
                    inputvalue = inputvalue + 32 + 100;
                else
                    inputvalue = -1;

                return String.fromCharCode(inputvalue);
            };

            UCCEAN.prototype.generateCheckDigit_Code128CAuto = function (data) {
                var datalength = 0;
                var Sum = 105;
                var num = 0;
                var Result = -1;
                var strResult = "";

                datalength = data.length;

                var x = 0;
                var Weight = 1;
                var Skip = 0;
                while (x < data.length) {
                    Skip = 0;
                    if (data.charCodeAt(x) == 234) {
                        num = 102;
                        Sum = Sum + (num * (Weight));
                        x = x + 1;
                        Weight = Weight + 1;
                        Skip = 1;
                    }

                    var barcodechar1 = 0;
                    var barcodechar2 = 0;
                    if (Skip == 0) {
                        barcodechar1 = 0;
                        barcodechar2 = 0;
                        barcodechar1 = data.charCodeAt(x);
                        if (x + 1 < data.length) {
                            barcodechar2 = data.charCodeAt(x + 1);
                        }

                        if (barcodechar1 >= 48 && barcodechar1 <= 57 && barcodechar2 >= 48 && barcodechar2 <= 57) {
                            num = parseInt(data.substr(x, 2), 10);
                            Sum = Sum + (num * (Weight));
                            x = x + 2;
                            Weight = Weight + 1;
                        } else if ((barcodechar1 >= 48 && barcodechar1 <= 57 && barcodechar2 == 234) || (barcodechar1 >= 48 && barcodechar1 <= 57 && barcodechar2 == 0)) {
                            var CtoB = 0;
                            var BtoC = 0;

                            CtoB = 100;
                            Sum = Sum + (CtoB * (Weight));
                            Weight = Weight + 1;

                            num = data.charCodeAt(x);
                            Sum = Sum + this.getCode128ABValueAuto(num) * (Weight);
                            Weight = Weight + 1;

                            BtoC = 99;
                            Sum = Sum + (BtoC * (Weight));
                            Weight = Weight + 1;
                            x = x + 1;
                        }
                    }
                }

                Result = Sum % 103;
                strResult = this.getCode128CCharacterAuto(Result);

                return strResult;
            };

            UCCEAN.prototype.OptimizeNumbers = function (data, x, strResult, num) {
                var BtoC = String.fromCharCode(231);
                var strResult = strResult + BtoC;

                var endpoint = x + num;
                while (x < endpoint) {
                    var twonum = parseInt(data.substr(x, 2), 10);
                    strResult = strResult + this.getCode128CCharacterAuto(twonum);
                    x = x + 2;
                }

                var CtoB = String.fromCharCode(232);
                strResult = strResult + CtoB;
                return strResult;
            };

            UCCEAN.prototype.ScanAhead_8orMore_Numbers = function (data, x) {
                var numNumbers = 0;
                var exitx = 0;
                while ((x < data.length) && (exitx == 0)) {
                    var barcodechar = data.substr(x, 1);
                    var barcodevalue = barcodechar.charCodeAt(0);
                    if (barcodevalue >= 48 && barcodevalue <= 57)
                        numNumbers = numNumbers + 1;
                    else
                        exitx = 1;

                    x = x + 1;
                }
                if (numNumbers > 8) {
                    if (numNumbers % 2 == 1)
                        numNumbers = numNumbers - 1;
                }
                return numNumbers;
            };

            UCCEAN.prototype.getAutoSwitchingAB = function (data) {
                var datalength = 0;
                var strResult = "";
                var shiftchar = String.fromCharCode(230);

                datalength = data.length;
                var barcodechar = "";
                var x = 0;
                for (x = 0; x < datalength; x++) {
                    barcodechar = data.substr(x, 1);
                    var barcodevalue = barcodechar.charCodeAt(0);

                    if ((barcodevalue <= 31) && (barcodevalue >= 0)) {
                        strResult = strResult + shiftchar;
                        barcodevalue = barcodevalue + 96;
                        strResult = strResult + String.fromCharCode(barcodevalue);
                    } else if (barcodevalue == 127) {
                        barcodechar = String.fromCharCode(barcodechar.charCodeAt(0) + 100);
                        strResult = strResult + barcodechar;
                    } else {
                        var num = this.ScanAhead_8orMore_Numbers(data, x);
                        if (num >= 8) {
                            strResult = this.OptimizeNumbers(data, x, strResult, num);

                            x = x + num;
                            x = x - 1;
                        } else
                            strResult = strResult + barcodechar;
                    }
                }
                return strResult;
            };

            UCCEAN.prototype.detectAllNumbers = function (data, GS1Compliance) {
                var result = "";
                var allnumbers = 1;
                var numNumbers = 0;
                var datalength = data.length;

                for (var x = 0; x < datalength; x++) {
                    var barcodechar = data.substr(x, 1);
                    var barcodevalue = barcodechar.charCodeAt(0);

                    if ((barcodevalue <= 57) && (barcodevalue >= 48)) {
                        numNumbers = numNumbers + 1;
                    } else if (barcodevalue == 234) {
                        //if (GS1Compliance == true) {
                        if (GS1Compliance == false) {
                            if ((numNumbers % 2) == 1)
                                allnumbers = 0;
                        }
                        numNumbers = 0;
                    } else {
                        allnumbers = 0;
                    }
                }

                //if (GS1Compliance == true) {
                if (GS1Compliance == false) {
                    if ((numNumbers % 2) == 1)
                        allnumbers = 0;
                }
                if (allnumbers == 1)
                    return true;
                return false;
                //return allnumbers;
            };

            UCCEAN.prototype.addShift = function (data) {
                var datalength = 0;
                var strResult = "";
                var shiftchar = String.fromCharCode(230);

                datalength = data.length;

                for (var x = 0; x < datalength; x++) {
                    var barcodechar = data.substr(x, 1);
                    var barcodevalue = barcodechar.charCodeAt(0);
                    if ((barcodevalue <= 31) && (barcodevalue >= 0)) {
                        strResult = strResult + shiftchar;
                        barcodechar = String.fromCharCode(barcodechar.charCodeAt(0) + 96);
                        strResult = strResult + barcodechar;
                    } else
                        strResult = strResult + barcodechar;
                }

                return strResult;
            };
            return UCCEAN;
        })(connectcode.CCBarcode);
        connectcode.UCCEAN = UCCEAN;
    })(net.connectcode || (net.connectcode = {}));
    var connectcode = net.connectcode;
})(net || (net = {}));
//# sourceMappingURL=uccean.js.map
