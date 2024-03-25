import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';


const Login = () => {

    const [Username, SetUsername] = useState("");
    const [Password, SetPassword] = useState("");
    const [alert,SetAlert] = useState(false);
    const navigate = useNavigate();

    axios.defaults.withCredentials = true
    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await axios.get("http://localhost:8000/admin")
                if(response.data.access === "pass"){
                    navigate("/")
                }
            } catch (error) {
                console.error("Error fetching data:", error);
            }
        };
    
        fetchData();
    }, []);

    axios.defaults.withCredentials = true;
    const handleSubmit = (e) => {
        e.preventDefault()

        const postData = {
            username: Username, 
            password: Password,
        };
        
        axios.post("http://localhost:8000/admin/login", postData)
        .then((res) => {
            if(res.data.access === "pass"){
                navigate('/');
            } else {
                SetAlert(true);
            }
        })
        .catch((error) => {
            console.error("Error submitting the form:", error);
        });
    };

    return (
        <div className='w-full h-screen flex justify-center items-center flex-col'>
            <h1 className='text-6xl font-black mb-3 '>TourGuard</h1>
            <h1 className='text-xl font-bold  mb-9'>“Your trusted travel companion”</h1>
            <div className="flex flex-col max-w-md p-6 rounded-md sm:p-10 bg-gray-50 text-gray-800">
	<div className="mb-8 text-center">
		<h1 className="my-3 text-4xl font-bold">Sign in</h1>
		<p className="text-sm text-gray-600">Sign in to access your account</p>
	</div>
	<form action="" onSubmit={handleSubmit} className="space-y-12">
		<div className="space-y-4">
			<div>
				<label for="email" className="block mb-2 text-sm">Email address</label>
				<input type="email" name="email" id="email" placeholder="leroy@jenkins.com" className="w-full px-3 py-2 border rounded-md border-gray-300 bg-gray-50 text-gray-800" 
                value={Username}
                onChange={(e) => SetUsername(e.target.value)}
                required
                />
			</div>
			<div>
				<div className="flex justify-between mb-2">
					<label for="password" className="text-sm">Password</label>
					<a rel="noopener noreferrer" href="#" className="text-xs hover:underline text-gray-600">Forgot password?</a>
				</div>
				<input type="password" name="password" id="password" placeholder="*****" className="w-full px-3 py-2 border rounded-md border-gray-300 bg-gray-50 text-gray-800" 
                value={Password}
                onChange={(e)=> SetPassword(e.target.value)}
                required
                />
			</div>
            {alert ? <p className='text-red-700'>invalid credentials</p> : <p></p>}
		</div>
        
		<div className="space-y-2">
			<div>
				<button type="submit" className="w-full px-8 py-3 font-semibold rounded-md bg-violet-600 text-gray-50">Sign in</button>
			</div>
			<p className="px-6 text-sm text-center text-gray-600">Don't have an account yet?
				<a rel="noopener noreferrer" href="#" className="hover:underline text-violet-600">Sign up</a>.
			</p>
		</div>
	</form>
</div>
        </div>
    );
}

export default Login;
