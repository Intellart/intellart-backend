import React from "react";
import { Link } from 'react-router-dom';
import logoIcon from '../../../../assets/logo/veritheum_logo_white.svg';
import twitterIcon from '../../../../assets/social_icons/twitter-brands.svg';
import discordIcon from '../../../../assets/social_icons/discord-brands.svg';
import githubIcon from '../../../../assets/social_icons/github-brands.svg';
import './Footer.scss';

class Footer extends React.Component {
  render () {
    const today = new Date();
    const graphics = (
      <div className="graphics-wrapper">
        <div className="circle-graphic gr-1" />
        <div className="circle-graphic gr-2" />
        <div className="circle-graphic gr-3" />
        <div className="circle-graphic gr-4" />
        <div className="circle-graphic gr-5" />
      </div>
    );

    return (
      <footer>
        <div className="footer-content-wrapper">
          <div className="row">
            <div className="column logo-column">
              <div className="column-title">
                <a href="/">
                  <img src={logoIcon} alt='Intellart logo' />
                </a>
              </div>
            </div>
            <div className="column">
              <div className="column-title">
                Social
              </div>
              <div className="column-item social-links">
                <a href="#" target="_blank" rel="noopener noreferrer" title="Twitter">
                  <img src={twitterIcon} alt='Twitter icon' />
                </a>
                <a href="#" target="_blank" rel="noopener noreferrer" title="Discord">
                  <img src={discordIcon} alt='Discord icon' />
                </a>
                <a href="#" target="_blank" rel="noopener noreferrer" title="Github">
                  <img src={githubIcon} alt='Github icon' />
                </a>
              </div>
            </div>
            <div className="column">
              <div className="column-title">
                Contact
              </div>
              <div className="column-item">
                <a href="mailto:info@intellart.ca" className="email">info@intellart.ca</a>
              </div>
            </div>
            <div className="column">
              <div className="column-title">
                Navigation
              </div>
              <div className="column-item">
                <a href='#'>
                  Home
                </a>
              </div>
              <div className="column-item">
                <a href='#'>
                  Explore
                </a>
              </div>
            </div>
          </div>
          <div className="footer-bottom">
            <div className="copyright">
              © {today.getFullYear()} Intellart. All rights reserved.
            </div>
            <div className="action-links">
              <span>Terms of Use</span>|<span>Cookie policy</span>|<span>Privacy policy</span>
            </div>
          </div>
        </div>
        {graphics}
      </footer>
    );
  }
}

export default Footer;
