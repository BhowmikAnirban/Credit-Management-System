var Industrial2of5 = net.connectcode.Industrial2of5;

window.onload = function () {
    /*
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: Industrial2of5 = new Industrial2of5(elementBarcode.innerHTML,false);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;
    var elementHumanReadableText = document.getElementById("humanReadableText");
    elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x = 0; x < elementBarcode.length; x++) {
        var barcode = new Industrial2of5(elementBarcode[x].innerHTML);
        var result = barcode.encode();
        var hrText = barcode.getHRText();
        elementBarcode[x].innerHTML = result;
        elementHumanReadableText[x].innerHTML = hrText;
    }
};
//# sourceMappingURL=app-industrial2of5.js.map
