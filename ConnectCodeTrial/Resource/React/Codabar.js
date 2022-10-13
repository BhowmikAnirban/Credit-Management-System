import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { encode , getText } from './js/connectcode-javascript-codabar'
import './Codabar.css';

class Codabar extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired,
       checkDigit: PropTypes.string
  }

  static defaultProps = {
        input: "A12345678A",
        checkDigit: "1"	
  }

  render() {
    const {input, checkDigit}=this.props
    return (
      <div className="Codabar">
	<br /><center>
        	<div className='barcode'>{encode(input,checkDigit)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default Codabar;
