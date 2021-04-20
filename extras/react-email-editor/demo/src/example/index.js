import React, { useRef } from 'react';
import styled from 'styled-components';

import EmailEditor from '../../../src';
import sample from './sample.json';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  position: relative;
  height: 100%;
`;

const Bar = styled.div`
  flex: 1;
  background-color: #A7AAAF;
  color: #000;
  padding: 10px;
  display: flex;
  max-height: 40px;

  h1 {
    flex: 1;
    font-size: 16px;
    text-align: left;
  }

  button {
    flex: 1;
    padding: 10px;
    margin-left: 10px;
    font-size: 14px;
    font-weight: bold;
    background-color: #000;
    color: #fff;
    border: 0px;
    max-width: 150px;
    cursor: pointer;
  }
`;

const Example = (props) => {
  const emailEditorRef = useRef(null);

  const saveDesign = () => {
    emailEditorRef.current.editor.saveDesign((design) => {
      console.log('saveDesign', design);
      console.log('saveDesign', JSON.stringify(design));
      alert('Design JSON has been logged in your developer console.');
    });
  };

  const exportHtml = () => {
    emailEditorRef.current.editor.exportHtml((data) => {
      const { design, html } = data;
      console.log('exportHtml', html);
      alert('Output HTML has been logged in your developer console.');
    });
  };

  const onDesignLoad = (data) => {
    console.log('onDesignLoad', data);
  };

  const onLoad = () => {
    emailEditorRef.current.editor.addEventListener(
      'onDesignLoad',
      onDesignLoad
    );
    // emailEditorRef.current.editor.loadDesign(sample);

    fetch("/sample.json").then(res=>res.json()).then(data=>emailEditorRef.current.editor.loadDesign(data))
  };

  return (
    <Container>
      <Bar>
        <h1></h1>
        <button onClick={saveDesign}>Save design</button>
        <button onClick={exportHtml}>Use this design</button>
      </Bar>

      <React.StrictMode>
        <EmailEditor ref={emailEditorRef} onLoad={onLoad} />
      </React.StrictMode>
    </Container>
  );
};

export default Example;
