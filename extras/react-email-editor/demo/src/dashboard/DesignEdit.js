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
    // console.log('onDesignLoad', data);
  };
  const onLoad = () => {
    ref.current.editor.addEventListener(
      'onDesignLoad',
      onDesignLoad
    );

  };
  return (
    <Container>
      <EmailEditor ref={ref} onLoad={onLoad} />
    </Container>
  );
};

export default DesignEdit;
