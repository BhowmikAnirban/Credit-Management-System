import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-i2of5'
import './I2of5.css';

class I2of5 extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired,
       checkDigit: PropTypes.string
  }

  static defaultProps = {
        input: "12345678",
        checkDigit: "1"
  }

  render() {
    const {input, checkDigit}=this.props
    return (
      <div className="I2of5">
	<br /><center>
        	<div className='barcode'>{encode(input,checkDigit)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default I2of5;
