import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-ext2'
import './EXT2.css';

class EXT2 extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired
  }

  static defaultProps = {
        input: "12"
  }

  render() {
    const {input}=this.props
    return (
      <div className="EXT2">
	<br /><center>
        	<div className='barcode'>{encode(input)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default EXT2;
