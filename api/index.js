const express = require('express')
const path = require('path')
const cors = require("cors");
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const cookieParser = require('cookie-parser');
require('dotenv').config()

const db = require('./db')

const admin = require("./Router/admin")
const traveller = require('./Router/traveller');
const Local_Guide = require("./Router/local_guide");
const login = require('./Router/login');
const payment = require('./Router/payment');
const message = require('./Router/message');
const vehicle = require('./Router/vehicle');
const report = require('./Router/report');

const request = require('./Router/request')



const app = express()
const port = 8000

app.use(express.json());
app.use(cors({
    origin: ["http://localhost:3000"],
    methods: ["POST", "GET"],
    credentials: true
}));
app.use(cookieParser());

// Admin route
app.use("/admin", admin)

// traveller route
app.use('/traveller', traveller)

//Local Guide route
app.use("/localguide", Local_Guide)


app.use("/request", request)

// User Login system

app.use("/login", login);

app.use("/payment", payment);

app.use("/message", message);

app.use("/vehicle", vehicle);

app.use("/report", report);

app.get('/uploads/:filename', (req, res) => {
    const filename = req.params.filename;

    const imagePath = path.join(__dirname, 'uploads', filename);

    res.sendFile(imagePath);
});



app.listen(port, () => console.log(`Example app listening on port ${port}!`))