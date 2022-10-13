import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';

//import Codabar from './Codabar';
//import Code39 from './Code39';
//import Code39ASCII from './Code39ASCII';
//import Code93 from './Code93';
//import Code128A from './Code128A';
import Code128Auto from './Code128Auto';
//import Code128B from './Code128B';
//import Code128C from './Code128C';
//import EAN13 from './EAN13';
//import EAN8 from './EAN8';
//import EXT2 from './EXT2';
//import EXT5 from './EXT5';
//import GS1Databar14 from './GS1Databar14';
//import I2of5 from './I2of5';
//import Industrial2of5 from './Industrial2of5';
//import ITF14 from './ITF14';
//import ModifiedPlessy from './ModifiedPlessy';
//import POSTNET from './POSTNET';
//import UCCEAN from './UCCEAN';
//import UPCA from './UPCA';
//import UPCE from './UPCE';

import registerServiceWorker from './registerServiceWorker';

//ReactDOM.render(<Codabar input="12345678" checkDigit="1" />, document.getElementById('root'));
//ReactDOM.render(<Code39 input="12345678" checkDigit="1" />, document.getElementById('root'));
//ReactDOM.render(<Code39ASCII input="12345678" checkDigit="1" />, document.getElementById('root'));
//ReactDOM.render(<Code93 input="12345678" checkDigit="1" />, document.getElementById('root'));
//ReactDOM.render(<Code128A input="12345678" />, document.getElementById('root'));
ReactDOM.render(<Code128Auto input="12345678" />, document.getElementById('root'));
//ReactDOM.render(<Code128B input="12345678" />, document.getElementById('root'));
//ReactDOM.render(<Code128C input="12345678" />, document.getElementById('root'));
//ReactDOM.render(<EAN13 input="12345678" extendedStyle="1" />, document.getElementById('root'));
//ReactDOM.render(<EAN8 input="12345678" />, document.getElementById('root'));
//ReactDOM.render(<EXT2 input="12345678" />, document.getElementById('root'));
//ReactDOM.render(<EXT5 input="12345678" />, document.getElementById('root'));
//ReactDOM.render(<GS1Databar14 input="12345678" linkage="0"/>, document.getElementById('root'));
//ReactDOM.render(<I2of5 input="12345678" checkDigit="1" />, document.getElementById('root'));
//ReactDOM.render(<Industrial2of5 input="12345678" checkDigit="1" />, document.getElementById('root'));
//ReactDOM.render(<ITF14 input="12345678" checkDigit="1" bearersBar="1" />, document.getElementById('root'));
//ReactDOM.render(<ModifiedPlessy input="12345678" checkDigit="1" />, document.getElementById('root'));
//ReactDOM.render(<POSTNET input="12345678" />, document.getElementById('root'));
//ReactDOM.render(<UCCEAN input="12345678" gs1Compliance="1" />, document.getElementById('root'));
//ReactDOM.render(<UPCA input="12345678" extendedStyle="1" />, document.getElementById('root'));
//ReactDOM.render(<UPCE input="12345678" extendedStyle="1" />, document.getElementById('root'));

/*
const data = [
	{
		"input":"12345678",
	},
	{
		"input":"87654321",
	}
]

const Barcodes=({params})=>
<div className="barcodes">{params.map((param,i)=>
	<Code128Auto key={i} {...param} />)}
</div>

ReactDOM.render(<Barcodes param={data} />, document.getElementById('root'));
*/

registerServiceWorker();
