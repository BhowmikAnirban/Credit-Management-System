var EAN8 = net.connectcode.EAN8;

window.onload = function () {
    /*
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: EAN8 = new EAN8(elementBarcode.innerHTML,true);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;
    var elementHumanReadableText = document.getElementById("humanReadableText");
    //elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x = 0; x < elementBarcode.length; x++) {
        var barcode = new EAN8(elementBarcode[x].innerHTML, true);
        var result = barcode.encode();
        var hrText = barcode.getHRText();
        elementBarcode[x].innerHTML = result;
        //(<HTMLElement>elementHumanReadableText[x]).innerHTML = hrText;
    }
};
//# sourceMappingURL=app-ean8.js.map
