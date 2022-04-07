import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Home from './App/Pages/Home';
import Gallery from './App/Pages/Gallery';
import Navigation from './App/Navigation/Navigation';
import "./index.css"

function ReactApp() {
  return (
    <Router>
      <Navigation />
      <div className="main-content">
        <Routes>
          <Route exact path="/" element={
            <Home />
          } />
          <Route path="/gallery" element={
            <Gallery />
          } />
        </Routes>
      </div>
    </Router>
  );
};

export default ReactApp;