const express = require('express')
const db = require('../db')
const router = express.Router()

const date = new Date()
router.post("/", (req, res) => {
    console.log(req.body.reporter_id)
    db.all(`select id from Traveller where login_id = ?`, req.body.reporter_id, (err, row) => {
        if (err) {

        }
        db.all(`select id from Local_Guide where login_id = ?`, req.body.report_id, (err, row2) => {
            if (err) {

            }
            db.run(`insert into  Report_local_guide(local_guide_id, traveller_id , report, date) values(?,?,?,?)`, [
                row2[0].id, row[0].id, req.body.report, date
            ], (err) => {
                console.log(err)
            })
            console.log("Report added")
        })
    })
    res.sendStatus(200)
})


module.exports = router;