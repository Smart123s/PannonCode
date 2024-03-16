const express = require('express')
const app = express()
const port = 3000

const fs = require('fs');
const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('./chinook.db');

app.use(express.json());
app.use(express.static('public'))

app.get('/', (req, res) => {
    res.send('Hello World!')
})

const schemes = JSON.parse(fs.readFileSync('public/schemes.json', 'utf8'));

app.put('/insert/:table', (req, res) => {
    db.serialize(() => {
        let table = req.params.table;
        // fura sql injection ellenőrzés :)
        if (schemes[table] === undefined) {
            return res.status(400).send("Table not found");
        }
        let columns_num = schemes[table]["columns"].length;
        let placeholders = Array(columns_num).fill('?').join(', ');
        db.run(`INSERT INTO ${table} VALUES (${placeholders})`, req.body["values"], function (err) {
            if (err) {
                return res.status(400).send(err.message);
            }
            return res.sendStatus(200);
        });
    })
})

app.get('/select/:table', (req, res) => {
    db.serialize(() => {
        let table = req.params.table;
        // fura sql injection ellenőrzés :)
        if (schemes[table] === undefined) {
            return res.status(400).send("Table not found");
        }

        // oké, ez viszont elég rendesen sebezhető
        filter_text = req.query["filter"] ? " WHERE " + req.query["filter"] : "";

        db.all(`SELECT * FROM ${table}${filter_text}`, function (err, rows) {
            if (err) {
                return res.status(400).send(err.message);
            }
            return res.send(rows);
        });
    })
})

app.delete('/del/:table/', (req, res) => {
    db.serialize(() => {
        let table = req.params.table;
        // fura sql injection ellenőrzés :)
        if (schemes[table] === undefined) {
            return res.status(400).send("Table not found");
        }
        let columns = schemes[table]["columns"];
        let placeholders = columns.map((k) => `${k}=(?)`).join(' AND ');
        db.run(`DELETE FROM ${table} WHERE ${placeholders}`, req.body["original"], function (err) {
            if (err) {
                return res.status(400).send(err.message);
            }
            return res.sendStatus(200);
        });
    })
})

app.patch('/update/:table/', (req, res) => {
    db.serialize(() => {
        let table = req.params.table;
        // fura sql injection ellenőrzés :)
        if (schemes[table] === undefined) {
            return res.status(400).send("Table not found");
        }
        let columns = schemes[table]["columns"];
        let placeholders = columns.map((k) => `${k}=(?)`);
        db.run(`UPDATE ${table}
                SET ${placeholders.join(', ')}
                WHERE ${placeholders.join(' AND ')}`, [...req.body["new"], ...req.body["original"]], function (err) {
            if (err) {
                return res.status(400).send(err.message);
            }
            return res.sendStatus(200);
        });
    })
})

app.listen(port, () => {
    console.log(`App listening on port ${port}`)
})

process.on('exit', function () {
    db.close()
});
