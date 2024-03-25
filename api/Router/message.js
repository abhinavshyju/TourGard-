const express = require('express')
const db = require('../db')

const router = express.Router();


router.post("/", (req, res) => {
    const { sender_id, reciver_id, message } = req.body
    const date = `${new Date()}`;

    const query = `INSERT INTO Message(sender_id, reciver_id, message, date) VALUES(?,?,?,?) `
    db.run(query, [sender_id, reciver_id, message, date], (err) => {
        if (err) {
            console.log(err)
        }
        console.log("Message update")
        res.send("update")
    })
})


router.post("/get", (req, res) => {
    const { sender_id, reciver_id } = req.body
    const queryOne = `SElECT * FROM Message WHERE sender_id =? OR reciver_id = ?`


    db.all(queryOne, [sender_id, sender_id], (err, rows) => {
        if (err) {
            console.log(err)
        }
        const array = [];

        rows.map((e) => {
            if (e.sender_id == reciver_id || e.reciver_id == reciver_id) {
                array.push(e)
            }
        })
        const data = JSON.stringify(array)
            // console.log(data)
        res.json(data)
    })


})


module.exports = router;