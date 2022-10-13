var UPCE = net.connectcode.UPCE;

window.onload = function () {
    /*
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: UPCE = new UPCE(elementBarcode.innerHTML,true);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;
    var elementHumanReadableText = document.getElementById("humanReadableText");
    //elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x = 0; x < elementBarcode.length; x++) {
        var barcode = new UPCE(elementBarcode[x].innerHTML, true);
        var result = barcode.encode();
        var hrText = barcode.getHRText();
        elementBarcode[x].innerHTML = result;
        //(<HTMLElement>elementHumanReadableText[x]).innerHTML = hrText;
    }
};
//# sourceMappingURL=app-upce.js.map
