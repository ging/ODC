import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import styled, { createGlobalStyle } from 'styled-components';

import { BrowserRouter as Router, Switch, Route, Link } from 'react-router-dom';

import Example from './example';
import DesignEdit from './dashboard/DesignEdit';

const GlobalStyle = createGlobalStyle`
  html, body {
    margin: 0;
    padding: 0;
    height: 100%;
    font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;
  }

  #demo {
    height: 100%;
  }
`;

class Demo extends Component {
  render() {
    const urlParams = new URLSearchParams(window.location.search);
    const designId = urlParams.get('designId');
    return <DesignEdit designId={designId} />
  }
}

ReactDOM.render(<Demo />, document.querySelector('#demo'));
