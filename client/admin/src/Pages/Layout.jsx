import axios, { Axios } from 'axios';
import React, { useEffect, useState } from 'react';
import { Outlet, useNavigate } from 'react-router-dom';
import NavBar from './components/NavBar';
import SideBar from './components/SideBar';



const Layout = () => {

    const [data,setdata ] = useState();
    const navigate = useNavigate();

    axios.defaults.withCredentials = true
    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await axios.get("http://localhost:8000/admin")
                if(response.data.access === "fail"){
                    navigate("/login")
                }
            } catch (error) {
                console.error("Error fetching data:", error);
            }
        };
    
        fetchData();
    }, []);

    return (
        <div className='flex w-full bg-[#F2F8FC]'>

        <SideBar/>
    <div className="w-full pl-[228px]">
        
        <NavBar/>
            <Outlet/>
        </div>
        </div>
    );
}

export default Layout;
