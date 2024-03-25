import React from 'react';
import NavBar from '../components/NavBar';
import SideBar from '../components/SideBar';
import LocalGuidesRequestsTable from './LocalGuidesRequestsTable';
import TravellerTable from './TravellerTable';

const HomePage = () => {
    return (
       
                <div className="home-Content w-full">
                     <div className="px-6 py-4">
                     <LocalGuidesRequestsTable/>
                     </div>

                     <div className="px-6 py-4">
                     <TravellerTable/>
                     </div>
                </div>
           
    );
}

export default HomePage;
