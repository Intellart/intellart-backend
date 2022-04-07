import React from 'react';
import './NftListTabs.scss';

class NftListTabs extends React.Component {
  render () {
    return (
      <div className="nft-list-tabs">
        <div className="tab all">
          All
        </div>
        <div className="tab biology">
          Biology
        </div>
        <div className="tab physics">
          Physics
        </div>
        <div className="tab chemistry">
          Chemistry
        </div>
      </div>
    );
  }
};

export default NftListTabs;