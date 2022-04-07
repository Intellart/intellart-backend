import React from 'react';
import {
  MdCollectionsBookmark, MdEdit, IoMdHeart
} from 'react-icons/md';
import { IoHeart, IoSearch } from 'react-icons/io5';
import './GalleryFilters.scss';

class GalleryFilters extends React.Component {
  render () {
    return (
      <div className="gallery-filters-wrapper">
        <div className="group">
          <div className="tab active">
            <MdCollectionsBookmark /> Collected
            <div className="count">
              27
            </div>
          </div>
          <div className="tab">
            <MdEdit /> Created
            <div className="count">
              4
            </div>
          </div>
          <div className="tab">
            <IoHeart /> Liked
            <div className="count">
              92
            </div>
          </div>
        </div>
        <div className="group">
          <div className="filter">
            <input placeholder="Search..." />
            <IoSearch />
          </div>
        </div>
      </div>
    );
  }
};

export default GalleryFilters;