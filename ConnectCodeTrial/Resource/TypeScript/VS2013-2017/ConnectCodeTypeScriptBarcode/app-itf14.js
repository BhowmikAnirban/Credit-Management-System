var ITF14 = net.connectcode.ITF14;

window.onload = function () {
    /*
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: ITF14 = new ITF14(elementBarcode.innerHTML,false,false);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;
    var elementHumanReadableText = document.getElementById("humanReadableText");
    elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x = 0; x < elementBarcode.length; x++) {
        var barcode = new ITF14(elementBarcode[x].innerHTML);
        var result = barcode.encode();
        var hrText = barcode.getHRText();
        elementBarcode[x].innerHTML = result;
        elementHumanReadableText[x].innerHTML = hrText;
    }
};
//# sourceMappingURL=app-itf14.js.map
