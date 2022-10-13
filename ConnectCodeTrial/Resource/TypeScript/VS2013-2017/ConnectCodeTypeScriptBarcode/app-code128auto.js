var Code128Auto = net.connectcode.Code128Auto;

window.onload = function () {
    /*
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: Code128Auto = new Code128Auto(elementBarcode.innerHTML);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;
    var elementHumanReadableText = document.getElementById("humanReadableText");
    elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x = 0; x < elementBarcode.length; x++) {
        var barcode = new Code128Auto(elementBarcode[x].innerHTML);
        var result = barcode.encode();
        var hrText = barcode.getHRText();
        elementBarcode[x].innerHTML = result;
        elementHumanReadableText[x].innerHTML = hrText;
    }
};
//# sourceMappingURL=app-code128auto.js.map
