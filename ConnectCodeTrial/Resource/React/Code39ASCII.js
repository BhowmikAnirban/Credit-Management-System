import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-code39ascii'
import './Code39ASCII.css';

class Code39ASCII extends Component {

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
      <div className="Code39ASCII">
	<br /><center>
        	<div className='barcode'>{encode(input, checkDigit)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default Code39ASCII;
