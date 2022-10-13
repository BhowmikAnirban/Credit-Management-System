import GS1Databar14 = net.connectcode.GS1Databar14;

window.onload = () => {
           /*
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: GS1Databar14 = new GS1Databar14(elementBarcode.innerHTML,false);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;    
    var elementHumanReadableText = document.getElementById("humanReadableText");
    elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x: number = 0; x < elementBarcode.length; x++) {
        var barcode: GS1Databar14 = new GS1Databar14((<HTMLElement>elementBarcode[x]).innerHTML);
        var result: string = barcode.encode();
        var hrText: string = barcode.getHRText();
        (<HTMLElement>elementBarcode[x]).innerHTML = result;
        (<HTMLElement>elementHumanReadableText[x]).innerHTML = hrText;
    }    

};