const Express = require('express');
const db = require('../db');

const router = Express.Router();

router.post("/", (req, res) => {
    const { email, contact, pickuplocation, localguideid } = req.body;
    const date = new Date();

    // Validate input data
    if (!email || !contact || !pickuplocation || !localguideid) {
        return res.json({ error: 'Missing required fields' });
    }
    db.all(`SELECT id FROM Traveller WHERE email = ? `, email, (err, id) => {
        if (err) {
            console.log(err)
        }
        db.run(`INSERT INTO Request(local_guide_id, traveller_id, date, pickuplocation, contact) VALUES(?,?,?,?,?)`, [localguideid, id[0].id, date, pickuplocation, contact],
            (err) => {
                if (err) {
                    console.error(err.message);
                    return res.json({ error: 'Internal Server Error' });
                }
                console.log("Request sent");
                res.send("done");
            });
    })

});

router.get("/guide/active/:email", (req, res) => {
    const email = req.params.email;

    db.get(`SELECT id FROM Local_Guide WHERE email = ?`, email, (err, localGuideRow) => {
        if (err) {
            console.error(err.message);
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        if (!localGuideRow) {
            return res.status(404).json({ error: 'Local guide not found' });
        }

        const localGuideId = localGuideRow.id;

        const query = `SELECT r.id, t.name, t.place, r.contact, t.email, t.image_file AS image, t.login_id, r.pickuplocation
                       FROM Request r
                       INNER JOIN Traveller t ON r.traveller_id = t.id
                       WHERE r.local_guide_id = ? AND r.request = "active"`;

        db.all(query, localGuideId, (err, rows) => {
            if (err) {
                console.error(err.message);
                return res.status(500).json({ error: 'Internal Server Error' });
            }

            if (rows.length === 0) {
                return res.json();
            }
            const data = JSON.stringify(rows.reverse())
            res.send(data);
        });
    });
});

router.get("/traveller/active/:email", (req, res) => {
    const email = req.params.email;

    db.get(`SELECT id FROM Traveller WHERE email = ?`, email, (err, localGuideRow) => {
        if (err) {
            console.error(err.message);
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        if (!localGuideRow) {
            return res.status(404).json({ error: 'Local guide not found' });
        }

        const localGuideId = localGuideRow.id;

        const query = `SELECT r.id, l.name, l.place, r.contact, l.email, l.image_file AS image, l.login_id, r.pickuplocation
        FROM Request r
        INNER JOIN Local_Guide l ON r.local_guide_id = l.id
        WHERE r.traveller_id = ? AND r.request = "active"`;

        db.all(query, localGuideId, (err, rows) => {
            if (err) {
                console.error(err.message);
                return res.status(500).json({ error: 'Internal Server Error' });
            }

            if (rows.length === 0) {
                return res.json();
            }
            const data = JSON.stringify(rows.reverse())
            res.send(data);
        });
    });
});

router.get("/guide/accept/:email", (req, res) => {
    const email = req.params.email;

    db.get(`SELECT id FROM Local_Guide WHERE email = ?`, email, (err, localGuideRow) => {
        if (err) {
            console.error(err.message);
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        if (!localGuideRow) {
            return res.status(404).json({ error: 'Local guide not found' });
        }

        const localGuideId = localGuideRow.id;

        const query = `SELECT r.id, t.name, t.place, r.contact, t.email, t.image_file AS image, t.login_id, r.pickuplocation
                       FROM Request r
                       INNER JOIN Traveller t ON r.traveller_id = t.id
                       WHERE r.local_guide_id = ? AND r.request = "accept"`;

        db.all(query, localGuideId, (err, rows) => {
            if (err) {
                console.error(err.message);
                return res.status(500).json({ error: 'Internal Server Error' });
            }

            if (rows.length === 0) {
                return res.json();
            }
            const data = JSON.stringify(rows.reverse())
            res.send(data);
        });
    });
});

router.get("/traveller/accept/:email", (req, res) => {
    const email = req.params.email;

    db.get(`SELECT id FROM Traveller WHERE email = ?`, email, (err, localGuideRow) => {
        if (err) {
            console.error(err.message);
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        if (!localGuideRow) {
            return res.status(404).json({ error: 'Local guide not found' });
        }

        const localGuideId = localGuideRow.id;

        const query = `SELECT r.id, l.name, l.place, r.contact, l.email, l.image_file AS image, l.login_id, r.pickuplocation
        FROM Request r
        INNER JOIN Local_Guide l ON r.local_guide_id = l.id
        WHERE r.traveller_id = ? AND r.request = "accept"`;

        db.all(query, localGuideId, (err, rows) => {
            if (err) {
                console.error(err.message);
                return res.status(500).json({ error: 'Internal Server Error' });
            }

            if (rows.length === 0) {
                return res.json();
            }
            const data = JSON.stringify(rows.reverse())
            res.send(data);
        });
    });
});


router.get("/traveller/deline/:email", (req, res) => {
    const email = req.params.email;

    db.get(`SELECT id FROM Traveller WHERE email = ?`, email, (err, localGuideRow) => {
        if (err) {
            console.error(err.message);
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        if (!localGuideRow) {
            return res.status(404).json({ error: 'Local guide not found' });
        }

        const localGuideId = localGuideRow.id;

        const query = `SELECT r.id, l.name, l.place, r.contact, l.email, l.image_file AS image, l.login_id, r.pickuplocation
        FROM Request r
        INNER JOIN Local_Guide l ON r.local_guide_id = l.id
        WHERE r.traveller_id = ? AND r.request = "deline"`;

        db.all(query, localGuideId, (err, rows) => {
            if (err) {
                console.error(err.message);
                return res.status(500).json({ error: 'Internal Server Error' });
            }

            if (rows.length === 0) {
                return res.json();
            }
            const data = JSON.stringify(rows.reverse())
            res.send(data);
        });
    });
});

router.get("/traveller/pending/:email", (req, res) => {
    const email = req.params.email;

    db.get(`SELECT id FROM Traveller WHERE email = ?`, email, (err, localGuideRow) => {
        if (err) {
            console.error(err.message);
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        if (!localGuideRow) {
            return res.status(404).json({ error: 'Local guide not found' });
        }

        const localGuideId = localGuideRow.id;

        const query = `SELECT r.id, l.name, l.place, r.contact, l.email, l.image_file AS image, l.login_id, r.pickuplocation
        FROM Request r
        INNER JOIN Local_Guide l ON r.local_guide_id = l.id
        WHERE r.traveller_id = ? AND r.request = "pending"`;

        db.all(query, localGuideId, (err, rows) => {
            if (err) {
                console.error(err.message);
                return res.status(500).json({ error: 'Internal Server Error' });
            }

            if (rows.length === 0) {
                return res.json([]);
            }

            // Using parameterized query to fetch payment details
            db.all(`SELECT * FROM payment WHERE trip_id IN (${rows.map(row => row.id).join(',')})`, (err, payments) => {
                if (err) {
                    console.error(err.message);
                    return res.status(500).json({ error: 'Internal Server Error' });
                }

                // Merging payment details with request details
                const data = rows.map(row => {
                    const payment = payments.find(p => p.trip_id === row.id);
                    return {...row, payment };
                });
                // res.json(data)
                const respones = JSON.stringify(data.reverse())
                res.send(respones);
            });
        });
    });
});
router.post("/accept", (req, res) => {
    const id = req.body.id;

    db.run(`UPDATE Request SET request =? WHERE id =?`, ["accept", id], (err) => {
        if (err) {
            console.log(err)
        } else {
            console.log("update request")
        }
    })
})
router.post("/deline", (req, res) => {
    const id = req.body.id;

    db.run(`UPDATE Request SET request =? WHERE id =?`, ["deline", id], (err) => {
        if (err) {
            console.log(err)
        } else {
            console.log("update request")
        }
    })
})
router.post("/complete", (req, res) => {
    const id = req.body.id;
    const payment_id = req.body.payment_id;

    db.run(`UPDATE Request SET request =? WHERE id =?`, ["complete", id], (err) => {
        if (err) {
            console.log(err)
        } else {
            console.log("update request")
        }
    })
    db.run(`UPDATE Payment SET status =? WHERE id =?`, ["complete", payment_id], (err) => {
        if (err) {
            console.log(err)
        } else {
            console.log("update request")
        }
    })
})
module.exports = router;