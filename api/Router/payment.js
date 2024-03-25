const express = require('express')
const db = require('../db')

const date = new Date();
const router = express.Router();


router.post("/", (req, res) => {
    const traveller_id = req.body.traveller_login_id;
    const guide_id = req.body.guide_login_id;
    const amount = req.body.amount;
    const trip_id = req.body.trip_id;

    console.log(req.body)


    db.all(`SELECT id FROM Local_Guide WHERE login_id =? `, guide_id, (err, localguideid) => {
        if (err) {
            console.log(err)
        }
        console.log(localguideid)
        db.all(`SELECT id FROM Traveller WHERE login_id = ?`, traveller_id, (err, travellerid) => {
            if (err) {
                console.log(err)
            }
            console.log(travellerid)
            db.run(`INSERT INTO Payment(amount,traveller_id, local_guide_id, trip_id, date) 
                    VALUES(?,?,?,?,?)`, [amount, travellerid[0].id, localguideid[0].id, trip_id, date], (err) => {
                if (err) {
                    console.log(err)
                } else {
                    console.log("Insert successfully")
                }
            })
        })
    })

    db.run(`UPDATE Request SET request = "pending" WHERE id =? `, trip_id, (err) => {
        if (err) {
            console.log(err)
        }
        console.log("request update")
    })
    res.sendStatus(200)
})

module.exports = router;