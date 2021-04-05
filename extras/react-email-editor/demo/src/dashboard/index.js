import React, { Component } from 'react';
import styled from 'styled-components';


import DesignList from './DesignList';
import DesignEdit from './DesignEdit';

const Dashboard = (props) => {
  const match = useRouteMatch();

  return [
      <Route key="edit" path={`${match.path}/edit/:designId`} exact={true} render={({match}) => (
        <DesignEdit designId={match.params.designId} />
      )}/>,
      <Route key="new"  path={`${match.path}/new`} exact={true} render={({match}) => (
        <DesignEdit />
      )}/>]

  );
};

export default Dashboard;
