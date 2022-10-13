import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-upce'
import './UPCE.css';

class UPCE extends Component {
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
      <div className="UPCE">
	<br /><center>
        	<div className='barcode'>{encode(input,extendedStyle)}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default UPCE;
