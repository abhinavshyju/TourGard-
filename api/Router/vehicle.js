const express = require('express');
const db = require('../db');
const multer = require('multer');

const router = express.Router();
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix + '.' + file.originalname.split('.').pop());
    },
});


const upload = multer({ storage: storage });


router.post("/upload", upload.fields([{ name: 'image_one' }, { name: 'image_two' }]), async(req, res) => {

    const imageOne = req.files['image_one'][0].path.replace("\\", '/');
    const imageTwo = req.files['image_two'][0].path.replace("\\", '/');



    const id = req.body.id;
    const typeofTransport = req.body.typeoftrasport;
    const vehicle_model = req.body.vehiclemodel;
    const name = req.body.name;


    const imageONE = `/${imageOne}`;
    const imageTWO = `/${imageTwo}`;


    db.all(`SELECT id FROM Local_Guide WHERE login_id = ?`, id, (err, rows) => {
        if (err) {
            console.error("Error querying local guide ID:", err);
            res.status(500).send("Internal Server Error");
        } else if (rows.length === 0) {
            console.error("No local guide found for login ID:", id);
            res.status(404).send("Local Guide Not Found");
        } else {
            const guideid = rows[0].id;
            db.run(`INSERT INTO Vehicle_Details (name ,vehicle_type, vehicle_model, vehicle_image_one,vehicle_image_two, local_guide_id) VALUES (?, ?, ?, ?,?,?)`, [name, typeofTransport, vehicle_model, imageONE, imageTWO, guideid],
                (err) => {
                    if (err) {
                        console.error("Error inserting vehicle details:", err);
                        res.status(500).send("Internal Server Error");
                    } else {
                        console.log("Vehicle Profile added");
                        res.send("pass");
                    }
                });
        }
    });

})

router.post("/get", (req, res) => {
    const id = req.body.id;

    db.all(`SELECT * FROM Vehicle_Details WHERE local_guide_id =?`, id, (err, data) => {
        if (err) {
            console.log(err)
        }
        if (data[0] == null) {
            res.send(null);
        }
        // res.json(data[0])
        res.send(JSON.stringify(data[0]))

    })
})


module.exports = router;