Module['onRuntimeInitialized'] = onRuntimeInitialized;

function onRuntimeInitialized() {

var elements=document.getElementsByClassName('code128barcode');
var elementsHR=document.getElementsByClassName('code128barcode_text');
var instance = new Module.Code128Auto();

for (x=0;x<elements.length;x++)
{
	instance.inputData = elements[x].innerHTML;
	elements[x].innerHTML=instance.encode();
	elementsHR[x].innerHTML=instance.humanReadableText;
}

elements=document.getElementsByClassName('ean13barcode');
elementsHR=document.getElementsByClassName('ean13barcode_text');
instance = new Module.EAN13();

for (x=0;x<elements.length;x++)
{
	instance.inputData = elements[x].innerHTML;
	instance.extendedStyle = 1;
	elements[x].innerHTML=instance.encode();
	elementsHR[x].innerHTML=instance.humanReadableText;
}
instance.delete();

}