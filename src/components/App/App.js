import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Home from './Pages/Home';
import Gallery from './Pages/Gallery';

export const App = () => {
  return (
    <Router>
      <Routes>
        <Route exact path="/" element={
          <Home />
        } />
        <Route path="/gallery" element={
          <Gallery />
        } />
      </Routes>
    </Router>
  );
};
