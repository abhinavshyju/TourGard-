import logo from './logo.svg';
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import NavBar from './Pages/components/NavBar';
import SideBar from './Pages/components/SideBar';
import Login from './Pages/Login/Login';
import HomePage from './Pages/Home/HomePage';
import Layout from './Pages/Layout';
import ReportView from './Pages/ReportView';

function App() {
  return (
    <BrowserRouter>
    <Routes>
      <Route path="/login" element={<Login/>}/>
      <Route path="/" element={<Layout/>}>
        <Route path='' element={<HomePage/>}/>
        <Route path='/report' element={<ReportView/>}/>
      </Route>
    </Routes>
    </BrowserRouter>
  );
}

export default App;
