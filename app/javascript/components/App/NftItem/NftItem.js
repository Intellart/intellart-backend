import React from 'react';
import ShieldIcon from '../../../../assets/icons/shield-check.svg';
import HeartIcon from '../../../../assets/icons/heart-outline.svg';
import User from '../../../../assets/icons/user.svg';
import './NftItem.scss';

class NftItem extends React.Component {
  render () {
    const { title, category, price, author } = this.props;
    return (
      <div className="nft-item">
        <div className="nft-item-title">
          {title}
        </div>
        <div className="nft-item-top-info">
          <div className="group">
            <div className={`category ${category}`}>
              {category}
            </div>
          </div>
          <div className="group">
            <div className="verified-user">
              <img src={ShieldIcon} alt="Verified user" />
            </div>
            <div className="like-button">
              <img src={HeartIcon} alt="Like button" />
            </div>
          </div>
        </div>
        <div className="nft-item-bottom-info">
          <div className="group">
            <div className="info-label">
              Price
            </div>
            <div className="price-info">
              {price} ADA
              <div className="to-dollars">
               ≈ $ 12.75
              </div>
            </div>
          </div>
          <div className="group">
            <div className="info-label">
              Author
            </div>
            <div className="author">
              <div className="author-image">
                <img src={User} alt="User image" />
              </div>
              {author}
            </div>
          </div>
        </div>
      </div>
    );
  }
};

export default NftItem;