import EXT2 = net.connectcode.EXT2;

window.onload = () => {
    /*
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: EXT2 = new EXT2(elementBarcode.innerHTML);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;    
    var elementHumanReadableText = document.getElementById("humanReadableText");
    //elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x: number = 0; x < elementBarcode.length; x++) {
        var barcode: EXT2 = new EXT2((<HTMLElement>elementBarcode[x]).innerHTML);
        var result: string = barcode.encode();
        var hrText: string = barcode.getHRText();
        (<HTMLElement>elementBarcode[x]).innerHTML = result;
        //(<HTMLElement>elementHumanReadableText[x]).innerHTML = hrText;
    }    

};