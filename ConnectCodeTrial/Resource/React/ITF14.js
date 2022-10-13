import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-itf14'
import './ITF14.css';

class ITF14 extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired,
       checkDigit: PropTypes.string,
       bearersBar: PropTypes.string		
  }

  static defaultProps = {
        input: "12345678",
        checkDigit: "0",
        bearersBar: "0"
  }
  render() {
    const {input, checkDigit, bearersBar}=this.props
    return (
      <div className="ITF14">
	<br /><center>
        	<div className='barcode'>{encode(input,checkDigit,bearersBar)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );

  }
}

export default ITF14;
