import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {encode,getText} from './js/connectcode-javascript-gs1databar14'
import './GS1Databar14.css';

class GS1Databar14 extends Component {
  static propTypes = {
       input: PropTypes.string.isRequired,
       linkage: PropTypes.string
  }

  static defaultProps = {
        input: "12345678",
        linkage: "1"
  }

  render() {
    const {input, linkage}=this.props
    return (
      <div className="GS1Databar14">
	<br /><center>
        	<div className='barcode'>{encode(input,linkage)}</div>	
        	<div className='barcode_text'>{getText()}</div>	
	</center>
	<br />
      </div>
    );
  }
}

export default GS1Databar14;
