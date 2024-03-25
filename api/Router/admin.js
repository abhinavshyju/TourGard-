const express = require('express')
const router = express.Router();
const jwt = require('jsonwebtoken');
const db = require('../db')


const IsAuth = (req, res, next) => {
    const token = req.cookies.token;

    if (!token) {
        return res.json({ access: "fail" })
    } else {
        jwt.verify(token, "secret_key", (err, result) => {
            if (err) {
                return res.sendStatus(403).json({ access: "Your not authenticated" })
            } else {
                if (result.username === "admin@email.com") {
                    next()
                } else {
                    return res.sendStatus(403).json({ access: "Your not authenticated" })
                }
            }
        })
    }
}

router.get('/', IsAuth, (req, res) => {
    res.json({ access: "pass" });
})

router.post('/login', (req, res) => {
    const { username, password } = req.body;
    if (username === "admin@email.com" && password === "pass") {
        const token = jwt.sign({ username }, "secret_key", { expiresIn: '1h' });
        res.cookie('token', token);
        res.json({ access: "pass" });
    } else {
        res.json({ access: "fail" })
    }
})

router.get("/logout", (req, res) => {
    res.clearCookie('token');
    res.json("Logged out");
})



router.get("/localguide", (req, res) => {
    const query = ` SELECT Login.*, Local_Guide.* FROM Login INNER JOIN Local_Guide ON Login.id = Local_Guide.login_id WHERE Login.active ="pending"`;

    db.all(query, (err, rows) => {
        if (err) {
            console.error(err.message);
            return;
        }

        res.json(rows.reverse())
    });
})
router.get(`/travellers`, (req, res) => {

    const query = ` SELECT Login.*, Traveller.* FROM Login INNER JOIN Traveller ON Login.id = Traveller.login_id  WHERE Login.active ="pending"`;

    db.all(query, (err, rows) => {
        if (err) {
            console.error(err.message);
            return;
        }

        res.json(rows.reverse())
    });
})


router.post('/accept', (req, res) => {
    const id = req.body.id;
    db.all(`UPDATE Login SET active = "allow" WHERE id = ?`, id, function(err) {
        if (err) {
            console.log("Error updating login:", err);
            res.status(500).send("Error updating login");
        } else {
            console.log("Update successful");
            res.status(200).send("Login updated successfully");
        }
    });
});


router.post('/ban', (req, res) => {
    const id = req.body.id;
    db.all(`UPDATE Login SET active = "ban" WHERE id = ?`, id, function(err) {
        if (err) {
            console.log("Error updating login:", err);
            res.status(500).send("Error updating login");
        } else {
            console.log("Update successful");
            res.status(200).send("Login updated successfully");
        }
    });
});
router.post('/reject', (req, res) => {
    const id = req.body.id;
    db.all(`UPDATE Login SET active = "reject" WHERE id = ?`, id, function(err) {
        if (err) {
            console.log("Error updating login:", err);
            res.status(500).send("Error updating login");
        } else {
            console.log("Update successful");
            res.status(200).send("Login updated successfully");
        }
    });
});


router.get("/report", (req, res) => {
    db.all(`SELECT * FROM Report_local_guide`, (err, reportRows) => {
        if (err) {
            console.error("Error retrieving report:", err);
            return res.status(500).json({ error: "Internal server error" });
        }

        // Assuming Report_local_guide contains columns local_guide_id and traveller_id
        // Fetch related data for each report entry
        const reports = [];

        reportRows.forEach(reportRow => {
            const localGuideId = reportRow.local_guide_id;
            const travellerId = reportRow.traveller_id;

            db.get(`SELECT * FROM Local_Guide WHERE id = ?`, [localGuideId], (err, localGuideRow) => {
                if (err) {
                    console.error("Error retrieving local guide:", err);
                    return res.status(500).json({ error: "Internal server error" });
                }

                db.get(`SELECT * FROM Traveller WHERE id = ?`, [travellerId], (err, travellerRow) => {
                    if (err) {
                        console.error("Error retrieving traveller:", err);
                        return res.status(500).json({ error: "Internal server error" });
                    }

                    reports.push({
                        report: reportRow,
                        localGuide: localGuideRow,
                        traveller: travellerRow
                    });

                    if (reports.length === reportRows.length) {

                        res.json(reports);
                    }
                });
            });
        });
    });
});


module.exports = router;