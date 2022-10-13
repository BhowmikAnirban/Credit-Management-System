import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-upca'
import './UPCA.css';

class UPCA extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired,
       extendedStyle: PropTypes.string		
  }

  static defaultProps = {
        input: "12345678",
        extendedStyle: "0"
  }

  render() {
    const {input, extendedStyle}=this.props
    return (
      <div className="UPCA">
	<br /><center>
        	<div className='barcode'>{encode(input,extendedStyle)}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default UPCA;
