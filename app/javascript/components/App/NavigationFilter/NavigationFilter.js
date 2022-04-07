import React from 'react';
import SearchIcon from '../../../../assets/icons/magnify.svg';
import './NavigationFilter.scss';

class NavigationFilter extends React.Component {
  render () {
    return (
      <div className="navigation-filter">
        <img src={SearchIcon} alt="Search Icon" />
        <input placeholder="Collection, item or user" />
      </div>
    );
  }
};

export default NavigationFilter;