import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-postnet'
import './POSTNET.css';

class POSTNET extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired
  }

  static defaultProps = {
        input: "12345678"
  }

  render() {
    const {input}=this.props
    return (
      <div className="POSTNET">
	<br /><center>
        	<div className='barcode'>{encode(input)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default POSTNET;
