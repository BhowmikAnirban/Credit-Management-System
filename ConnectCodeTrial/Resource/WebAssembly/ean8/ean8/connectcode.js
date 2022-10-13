Module['onRuntimeInitialized'] = onRuntimeInitialized;

function onRuntimeInitialized() {

var elements=document.getElementsByClassName('barcode');
var elementsHR=document.getElementsByClassName('barcode_text');
var instance = new Module.EAN8();

for (x=0;x<elements.length;x++)
{
	instance.inputData = elements[x].innerHTML;
	instance.extendedStyle=0;
	elements[x].innerHTML=instance.encode();
	elementsHR[x].innerHTML=instance.humanReadableText;
}
instance.delete();

}