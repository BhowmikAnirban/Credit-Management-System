import UPCE = net.connectcode.UPCE;

window.onload = () => {
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
    for (var x: number = 0; x < elementBarcode.length; x++) {
        var barcode: UPCE = new UPCE((<HTMLElement>elementBarcode[x]).innerHTML, true);
        var result: string = barcode.encode();
        var hrText: string = barcode.getHRText();
        (<HTMLElement>elementBarcode[x]).innerHTML = result;
        //(<HTMLElement>elementHumanReadableText[x]).innerHTML = hrText;
    }    

};