import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-uccean'
import './UCCEAN.css';

class UCCEAN extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired,
       gs1Compliance: PropTypes.string		
  }

  static defaultProps = {
        input: "(10)12345678",
        gs1Compliance: "1"
  }

  render() {
   const {input, gs1Compliance}=this.props
    return (
      <div className="UCCEAN">
	<br /><center>
        	<div className='barcode'>{encode(input,gs1Compliance)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default UCCEAN;
