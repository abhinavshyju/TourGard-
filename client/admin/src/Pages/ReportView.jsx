import axios from 'axios';
import React, { useEffect, useState } from 'react';

const ReportView = () => {
    const handleReject = async (id) => {
        try {
            const response = await axios.post('http://localhost:8000/admin/ban', { id });
            console.log(id); // Assuming the server sends some confirmation
        } catch (error) {
            console.error("Error accepting guide:", error);
        }
    };
    const [data, Setdata]= useState([]);
    useEffect(() => {
        const getdata = async()=>{
            const respones =await axios.get('http://localhost:8000/admin/report')
            Setdata(respones.data)
        }
        getdata();
    }, []);


    return (
        <div className='p-10'>
            <h1 className='text-2xl font-bold'>
                Report view
            </h1>
            <div className="mt-10 p-3 flex flex-col ">
            {data.map(e=>(
            <div className="flex flex-col shadow-lg px-6 py-4 bg-white rounded-lg">
                <h1 className='underline'>Report Details</h1>   
                 <div className="flex justify-between items-baseline gap-14">
                 <div className=" flex flex-col">
                    
                    <h1>Reported by : {e.traveller.name}</h1>
                    <h1>Reported to: {e.localGuide.name}</h1>
              </div>
              <div className="flex">
                <p>{e.report.report}</p>
              </div>
              <div className="flex flex-col">
              <button type="button" className="px-8 py-3 font-semibold rounded-full bg-red-500 text-gray-100" onClick={() => handleReject(e.localGuide.login_id)}>Take action</button>
              </div>
             </div>
            </div>
              ))}
            </div>
           
        </div>
    );
}

export default ReportView;
