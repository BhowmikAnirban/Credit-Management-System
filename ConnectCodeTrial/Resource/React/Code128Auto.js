import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-code128auto'
import './Code128Auto.css';

class Code128Auto extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired
  }

  static defaultProps = {
        input: "12345678"
  }

  render() {
    const {input}=this.props
    return (
      <div className="Code128Auto">
	<br /><center>
        	<div className='barcode'>{encode(input)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default Code128Auto;
