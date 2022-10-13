import UPCA = net.connectcode.UPCA;

window.onload = () => {
        /*   
    var elementBarcode = document.getElementById("barcodeData");
    var barcode: UPCA = new UPCA(elementBarcode.innerHTML,true);
    var result: string = barcode.encode();
    var hrText: string = barcode.getHRText();
    elementBarcode.innerHTML = result;    
    var elementHumanReadableText = document.getElementById("humanReadableText");
    //elementHumanReadableText.innerHTML = hrText;
    */
    var elementBarcode = document.getElementsByClassName("barcodeData");
    var elementHumanReadableText = document.getElementsByClassName("humanReadableText");
    for (var x: number = 0; x < elementBarcode.length; x++) {
        var barcode: UPCA = new UPCA((<HTMLElement>elementBarcode[x]).innerHTML, true);
        var result: string = barcode.encode();
        var hrText: string = barcode.getHRText();
        (<HTMLElement>elementBarcode[x]).innerHTML = result;
        //(<HTMLElement>elementHumanReadableText[x]).innerHTML = hrText;
    }    

};