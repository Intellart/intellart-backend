import React from 'react';
import { Link } from 'react-router-dom';
import Logo from '../../../assets/logo/veritheum_logo.png';
import NavigationFilter from '../NavigationFilter/NavigationFilter';
import './Navigation.scss';

class Navigation extends React.Component {
  render () {
    return (
      <nav>
        <div className="nav-items-wrapper">
          <div className="item-group">
            <div className="logo">
              <img src={Logo} alt="Veritheum Logo" />
            </div>
            <NavigationFilter />
          </div>
          <div className="item-group">
            <div className="links-wrapper">
              <Link to="/">Home</Link>
              <Link to="/gallery">Explore</Link>
              <div className="group">
                <Link to="/" className="outline">Create</Link>
                <Link to="/" className="full">Sign in</Link>
              </div>
            </div>
          </div>
        </div>
      </nav>
    );
  }
};

export default Navigation;