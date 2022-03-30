import React from 'react';
import {
  MdFilterList, MdArrowBack, MdChevronRight,
  MdCheckBoxOutlineBlank,
} from 'react-icons/md';
import './GallerySideMenu.scss';

class GallerySideMenu extends React.Component {
  render () {
    return (
      <div className="gallery-side-menu">
        <div className="gallery-side-menu-header">
          <div className="label">
            <MdFilterList /> Filter
          </div>
          <div className="icon">
            <MdArrowBack />
          </div>
        </div>
        <div className="gallery-side-menu-body">
          <div className="item">
            <div className="item-toggle">
              <div className="label">Status</div>
              <div className="icon"><MdChevronRight /></div>
            </div>
          </div>
          <div className="item">
            <div className="item-toggle">
              <div className="label">Price</div>
              <div className="icon"><MdChevronRight /></div>
            </div>
          </div>
          <div className="item">
            <div className="item-toggle">
              <div className="label">Collections</div>
              <div className="icon"><MdChevronRight /></div>
            </div>
          </div>
          <div className="item active">
            <div className="item-toggle">
              <div className="label">Categories</div>
              <div className="icon"><MdChevronRight /></div>
            </div>
            <div className="item-menu">
              <div className="item-checkbox">
                <MdCheckBoxOutlineBlank /> Biology
              </div>
              <div className="item-checkbox">
                <MdCheckBoxOutlineBlank /> Physics
              </div>
              <div className="item-checkbox">
                <MdCheckBoxOutlineBlank /> Chemistry
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
};

export default GallerySideMenu;