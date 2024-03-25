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
    const type = 'traveller';

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

            db.run(`INSERT INTO Traveller(login_id, name, place, phone, email, image_file ,document_file) VALUES (?, ?, ?, ?, ?, ?, ?)`, [login_id, name, place, phone, email, imageUrl, documentUrl], function(err) {
                if (err) {
                    console.error('Error inserting into Traveller table:', err.message);
                    res.status(500).json({ error: 'Internal Server Error' });
                    return;
                }

                console.log('Data inserted successfully');
                res.json({ email: email, type: type, id: login_id });
            });
        });
    } catch (error) {
        console.error('Error hashing password:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
})


router.get(`/`, (req, res) => {

    const query = ` SELECT Login.*, Traveller.* FROM Login INNER JOIN Traveller ON Login.id = Traveller.login_id`;

    db.all(query, (err, rows) => {
        if (err) {
            console.error(err.message);
            return;
        }
        const response = JSON.stringify(rows[0])
        res.send(response)
    });
})


router.get(`/user/:user`, (req, res) => {
    const loginUser = req.params.user;

    const query = ` SELECT Login.*, Traveller.* FROM Login INNER JOIN Traveller ON Login.id = Traveller.login_id WHERE Traveller.email = ?`;

    db.all(query, [loginUser], (err, rows) => {
        if (err) {
            console.error(err.message);
            return;
        }

        res.json(rows[0])
    });
})


module.exports = router;