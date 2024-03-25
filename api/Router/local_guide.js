const Express = require('express')
const multer = require('multer');
const jwt = require('jsonwebtoken')

const bcrypt = require('bcrypt')
const db = require('../db')

const saltRounds = 10;
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

const router = Express.Router();

router.post("/signup", upload.fields([{ name: 'image' }, { name: 'document' }]), async(req, res) => {


    const username = req.body.email;
    const password = req.body.password;
    const name = req.body.name;
    const place = req.body.place;
    const phone = req.body.phone;
    const email = req.body.email;
    const type = 'guide';

    console.log(req.body)
    const imageFile = req.files['image'][0].path.replace("\\", '/');
    const documentFile = req.files['document'][0].path.replace("\\", '/');


    const imageUrl = `/${imageFile}`;
    const documentUrl = `/${documentFile}`;


    // return res.send.JSON.stringify()

    try {
        const hash = await bcrypt.hash(password, saltRounds);

        db.run(`INSERT INTO Login(username, password, type) VALUES (?, ?, ?)`, [username, hash, type], function(err) {
            if (err) {
                console.error('Error inserting into Login table:', err.message);
                res.status(500).json({ error: 'Internal Server Error' });
                return;
            }

            const login_id = this.lastID;
            console.log(login_id)

            db.run(`INSERT INTO Local_Guide(login_id, name, place, phone, email, image_file ,document) VALUES (?, ?, ?, ?, ?, ?, ?)`, [login_id, name, place, phone, email, imageUrl, documentUrl], function(err) {
                if (err) {
                    console.error('Error inserting into Traveller table:', err.message);
                    res.status(500).json({ error: 'Internal Server Error' });
                    return;
                }
                const id = this.lastID;
                console.log('Data inserted successfully');
                res.json({ email: email, type: type, id: login_id, userid: id });
            });
        });
    } catch (error) {
        console.error('Error hashing password:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
})


router.get(`/`, (req, res) => {
    const loginIdToRetrieve = req.params.id;

    const query = ` SELECT Login.*, Local_Guide.* FROM Login INNER JOIN Local_Guide ON Login.id = Local_Guide.login_id WHERE login.active = "active"`;

    db.all(query, [loginIdToRetrieve], (err, rows) => {
        if (err) {
            console.error(err.message);
            return;
        }
        const data = JSON.stringify(rows)
        res.send(rows)
    });
})


router.post(`/`, (req, res) => {
    const loginIdToRetrieve = req.params.id;
    const typeofTransport = req.body.type;
    const model = req.body.model;

    console.log(req.body)

    const query = ` SELECT Login.*, Local_Guide.* FROM Login INNER JOIN Local_Guide ON Login.id = Local_Guide.login_id WHERE login.active = "allow"`;

    db.all(query, [loginIdToRetrieve], (err, rows) => {
        if (err) {
            console.error(err.message);
            return;
        }
        db.all(`SELECT * FROM Vehicle_Details WHERE local_guide_id IN (${rows.map(row => row.id).join(',')})`, (err, payments) => {
            if (err) {
                console.error(err.message);
                return res.status(500).json({ error: 'Internal Server Error' });
            }

            // Merging payment details with request details
            const data = rows.map(row => {
                const payment = payments.find(p => p.local_guide_id === row.id);
                return {...row, payment };
            });
            // res.json(data)

            const array = [];

            data.map(e => {
                if (e.payment != undefined) {
                    if (e.payment.vehicle_model == model && e.payment.vehicle_type == typeofTransport) {
                        array.push(e)
                    }
                }

            })


            const respones = JSON.stringify(array.reverse())
            res.send(array);
        });
    });
})

router.get(`/user/:id`, (req, res) => {
    const loginIdToRetrieve = req.params.id;

    const query = ` SELECT Login.*, Local_Guide.* FROM Login INNER JOIN Local_Guide ON Login.id = Local_Guide.login_id WHERE Local_Guide.id = ?`;

    db.all(query, [loginIdToRetrieve], (err, rows) => {
        if (err) {
            console.error(err.message);
            return;
        }
        res.json(rows[0])
    });
})

router.get(`/user/get/:user`, (req, res) => {
    const loginUser = req.params.user;
    console.log(loginUser)

    const query = ` SELECT Login.*, Local_Guide.* FROM Login INNER JOIN Local_Guide ON Login.id = Local_Guide.login_id WHERE Local_Guide.email = ?`;

    db.all(query, [loginUser], (err, rows) => {
        if (err) {
            console.error(err.message);
            res.json("error")
        }

        res.json(rows[0])
    });
})

module.exports = router