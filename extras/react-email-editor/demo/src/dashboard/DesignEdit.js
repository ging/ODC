import React, { Component, useRef } from 'react';
import styled from 'styled-components';

import EmailEditor from '../../../src';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  position: relative;
  height: 100%;
`;


const DesignEdit = (props) => {
  const ref = useRef(null);
  window.ref = ref;
  const saveDesign = () => {
    ref.current.saveDesign((design) => {
      console.log('saveDesign', design);
      console.log('saveDesign', JSON.stringify(design));
    });
  };

  const exportHtml = () => {
    ref.current.exportHtml((data) => {
      const { design, html } = data;
      console.log('exportHtml', html);
    });
  };
  const onDesignLoad = (data) => {
    console.log('onDesignLoad', data);
  };
  const onLoad = () => {
    ref.current.editor.addEventListener(
      'onDesignLoad',
      onDesignLoad
    );
    // emailEditorRef.current.editor.loadDesign(sample);
    if (props.designId) {
      fetch("/designs/" + props.designId)
        .then(res=>res.json())
        .then(data=>ref.current.editor.loadDesign(data))
        .catch(e=> {
          console.error(e);
          fetch("/email_builder/sample.json")
            .then(res=>res.json())
            .then(data=>ref.current.editor.loadDesign(data))
            .catch(e=>console.error(e));
        });
    } else {
        fetch("/email_builder/sample.json")
          .then(res=>res.json())
          .then(data=>ref.current.editor.loadDesign(data))
          .catch(e=>console.error(e));
    }
  };
  return (
    <Container>
      <EmailEditor ref={ref} onLoad={onLoad} />
    </Container>
  );
};

export default DesignEdit;
