import React from 'react';
import HeroCta from '../HeroCta/HeroCta';
import './pages.scss';

class Home extends React.Component {
  render () {
    return (
      <div className="home-page-wrapper">
        <HeroCta />
        <div className="home-page-content">
          <section>
            <div className="section-header">
              <h2>Browse osNFTs by category</h2>
              <h3>Lorem ipsum dolor sit amet, consectetuer adipiscing elit</h3>
            </div>
          </section>
        </div>
      </div>
    );
  }
};

export default Home;