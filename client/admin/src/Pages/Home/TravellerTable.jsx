import axios from 'axios';
import React, { useEffect } from 'react';
import { useState } from 'react';

const TravellerTable = () => {
    const [Guide, SetGuide] = useState([

    ])

    useEffect(() => {
        const getdata = async()=>{
            const data = await axios.get("http://localhost:8000/admin/travellers")
            SetGuide(data.data);

        }
       getdata();
    }, []);
    console.log(Guide)
    const imageUrl = "http://localhost:8000"
    return (
        <div className='w-full h-full py-4'>
        <div className="flex gap-8">
        <h1 className='text-2xl font-bold mr-32'>Travellers</h1>
        <input type="text" 
        placeholder='Search local guides'
        className='w-80 h-9 rounded-full shadow-md text-center'/>
        <button className='rounded-full bg-white px-9 font-bold shadow-md'>Search   </button>
        </div>
        <div className='flex justify-center w-full p-6'>
        <table className='w-full'>
             {Guide.map(e=>(
                 <tr className='border-b-2'>
                  <td className='pb-4 pt-2 '>
                        <img src={imageUrl+e.image_file } alt="" className='rounded-full w-14 h-14 shadow-md    '/>
                    </td>
                 <td className='pb-4 pt-2 w-[20%]'>
                     <div className="flex flex-col">
                         <h1 className='font-medium text-lg'>{e.name}</h1>
                         <p className='text-blue-400 text-base'>{e.place}</p>
                     </div>
                 </td>
                 <td className='pb-4 pt-2 w-[50%]'>
                     <p className='text-center'>More details</p>
                 </td>
                 <td>
                     <button className='bg-transparent px-10 py-1 rounded text-transparent font-bold'>Accept</button>
                 </td>
                 <td>
                     <button className='bg-red-600 px-10 py-1 rounded text-white font-bold'>Block</button>
                 </td>
             </tr>
             ))}
         
         </table>
        </div>
     </div>
    );
}

export default TravellerTable;
