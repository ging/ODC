import React, { Component } from 'react';
import styled from 'styled-components';


import DesignList from './DesignList';
import DesignEdit from './DesignEdit';

const Dashboard = (props) => {
  const match = useRouteMatch();

  return (
      <Route path={`${match.path}/edit/:designId`} exact={true} render={({match}) => (
        <DesignEdit designId={match.params.designId} />
      )}/>
  );
};

export default Dashboard;
