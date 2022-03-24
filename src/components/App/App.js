import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Home from './Pages/Home';
import Gallery from './Pages/Gallery';
import Navigation from './Navigation/Navigation';

export const App = () => {
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
