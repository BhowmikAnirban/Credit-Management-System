import Code128C = net.connectcode.Code128C;

window.onload = () => {
           /*
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: Code128C = new Code128C(elementBarcode.innerHTML);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;    
    var elementHumanReadableText = document.getElementById("humanReadableText");
    elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x: number = 0; x < elementBarcode.length; x++) {
        var barcode: Code128C = new Code128C((<HTMLElement>elementBarcode[x]).innerHTML);
        var result: string = barcode.encode();
        var hrText: string = barcode.getHRText();
        (<HTMLElement>elementBarcode[x]).innerHTML = result;
        (<HTMLElement>elementHumanReadableText[x]).innerHTML = hrText;
    }    

};