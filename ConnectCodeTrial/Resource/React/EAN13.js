import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-ean13'
import './EAN13.css';

class EAN13 extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired,
       extendedStyle: PropTypes.string		
  }

  static defaultProps = {
        input: "12345678",
        extendedStyle: "1"
  }

  render() {
    const {input, extendedStyle}=this.props
    return (
      <div className="EAN13">
	<br /><center>
        	<div className='barcode'>{encode(input,extendedStyle)}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default EAN13;
