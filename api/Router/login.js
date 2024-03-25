const express = require('express')
const bcrypt = require('bcrypt')
const db = require('../db')
const router = express.Router()

router.get('/', (req, res) => {
    res.send('login')
})

router.post("/", (req, res) => {
    const username = req.body.email;
    const password = req.body.password;
    // console.log(req.body)

    const query = `SELECT * FROM Login WHERE username = ?`

    try {
        db.all(query, username, (err, rows) => {
            if (err) {
                console.error(err.message)
            }
            if (rows.length != 0) {
                const row = rows[0]
                bcrypt.compare(password, row.password, (err, isValid) => {
                    if (!isValid) return res.json({ success: false })

                    if (row.type === "traveller") {
                        const type = "traveller"
                        console.log(req.body)
                        db.all(`SELECT id FROM Traveller WHERE login_id =? `, row.id, (err, userid) => {
                            res.json({ email: username, type: type, id: row.id, userid: userid[0].id });
                        })
                    } else if (row.type === "guide") {
                        db.all(`SELECT id FROM Local_Guide WHERE login_id =? `, row.id, (err, userid) => {
                            const type = "guide"
                            res.json({ email: username, type: type, id: row.id, userid: userid[0].id });
                        })


                    }
                })

            }

        })

    } catch (error) {
        res.json("test")
    }
})

module.exports = router