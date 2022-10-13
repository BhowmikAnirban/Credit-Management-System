var Code39 = net.connectcode.Code39;

window.onload = function () {
    var elementBarcode = document.getElementById("barcodeData");
    var barcode = new Code39("12345678", false);
    var result = barcode.encode();
    var hrText = barcode.getHRText();
    elementBarcode.innerHTML = result;
    var elementHumanReadableText = document.getElementById("humanReadableText");
    elementHumanReadableText.innerHTML = hrText;
};
//# sourceMappingURL=code39app.js.map
