import axios from 'axios';
import React, { useEffect, useState } from 'react';

const LocalGuidesRequestsTable = () => {
    const [guides, setGuides] = useState([]);
    const [search, SetSearch] = useState("");


    

    const handleAccept = async (id) => {
        try {
            const response = await axios.post('http://localhost:8000/admin/accept', { id });
            console.log(response.data); // Assuming the server sends some confirmation
        } catch (error) {
            console.error("Error accepting guide:", error);
        }
    };
    const handleReject = async (id) => {
        try {
            const response = await axios.post('http://localhost:8000/admin/reject', { id });
            console.log(response.data); // Assuming the server sends some confirmation
            // Update state or perform any necessary action after successful acceptance
        } catch (error) {
            console.error("Error accepting guide:", error);
        }
    };

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await axios.get("http://localhost:8000/admin/localguide");
                setGuides(response.data);
            } catch (error) {
                console.error("Error fetching data:", error);
            }
        };
        fetchData();
    }, [handleAccept, handleReject]);
    const imageUrl = "http://localhost:8000";

    return (
        <div className='w-full h-full py-4'>
            <div className="flex gap-8">
                <h1 className='text-2xl font-bold'>Local Guides Requests</h1>
                <input type="text" placeholder='Search local guides' className='w-80 h-9 rounded-full shadow-md text-center' value={search}  onChange={e=> SetSearch(e.target.value)} />
                <button className='rounded-full bg-white px-9 font-bold shadow-md'>Search</button>
            </div>
            <div className='flex justify-center w-full p-6'>
                <table className='w-full'>
                    <tbody>
                    {guides.filter(guide => guide.email.includes(search)).map((guide) => (
    <tr key={guide.login_id} className='border-b-2'>
        <td className='pb-4 pt-2 '>
            <img src={imageUrl + guide.image_file} alt="" className='rounded-full w-14 h-14 shadow-md' />
        </td>
        <td className='pb-4 pt-2 w-[20%]'>
            <div className="flex flex-col">
                <h1 className='font-medium text-lg'>{guide.name}</h1>
                <p className='text-blue-400 text-base'>{guide.place}</p>
            </div>
        </td>
        <td className='pb-4 pt-2 w-[50%]'>
            <p className='text-center'>More details</p>
        </td>
        <td>
            <button className='bg-green-500 px-10 py-1 rounded text-white font-bold' onClick={() => handleAccept(guide.login_id)}>Accept</button>
        </td>
        <td>
            <button className='bg-red-600 px-10 py-1 rounded text-white font-bold' onClick={() => handleReject(guide.login_id)}>Reject</button>
        </td>
    </tr>
))}

                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default LocalGuidesRequestsTable;
