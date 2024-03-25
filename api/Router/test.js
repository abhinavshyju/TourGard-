const express = require('express')
const router = express.Router();

const axios = require('axios');


// Define the base URL for Overpass API
const baseURL = 'https://overpass-api.de/api/';

// Function to find nearby hospitals
async function findNearbyHospitals(latitude, longitude, radius) {
    try {
        // Define the Overpass API query to find hospitals
        const query = `[out:json];
        (
          node["amenity"="hospital"](around:${radius},${latitude},${longitude});
          way["amenity"="hospital"](around:${radius},${latitude},${longitude});
          relation["amenity"="hospital"](around:${radius},${latitude},${longitude});
        );
        out center;`;

        // Make GET request to Overpass API
        const response = await axios.get(baseURL + 'interpreter', {
            params: {
                data: query
            }
        });

        // Return response data
        return response.data;
    } catch (error) {
        console.error('Error fetching nearby hospitals:', error);
        throw error;
    }
}

// Example usage
const latitude = 51.5074; // Latitude of London
const longitude = -0.1278; // Longitude of London
const radius = 5000; // Search radius in meters

const response = findNearbyHospitals(latitude, longitude, radius)
    .then(data => {
        // console.log(data)
        return data;
    })
    .catch(error => {
        console.error('Error:', error);
    });


module.exports = findNearbyHospitals;