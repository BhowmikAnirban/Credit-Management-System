import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-ean8'
import './EAN8.css';

class EAN8 extends Component {

  static propTypes = {
       input: PropTypes.string.isRequired
  }

  static defaultProps = {
        input: "12345678"
  }

  render() {
    const {input}=this.props
    return (
      <div className="EAN8">
	<br /><center>
        	<div className='barcode'>{encode(input)}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default EAN8;
