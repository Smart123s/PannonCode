var table_name = "";
var scheme = {};
var lock = false;
var limit = true;
var filter = "";

function removeLimit() {
    limit = false;
    document.getElementById("big-warn").innerHTML = "";
    loadTable();
}

document.addEventListener("DOMContentLoaded", async function loadSchemes() {
    try {
        let selectElement = document.getElementById('tableSelect');
        scheme = await (await fetch("schemes.json")).json();
        for (let i in scheme) {
            let option = new Option(i, i);
            selectElement.appendChild(option);
        }
        loadTable()
    } catch (error) {
        console.error(error);
    }
});

async function loadTable() {
    if (lock) {
        return;
    }
    try {
        lock = true;
        table_name = document.getElementById('tableSelect').value;
        let table = document.querySelector("table");
        table.innerHTML = "Betöltés... Néhány tábla nagyon nagy a minta adatbázisban, ezért a böngésző ideiglenesen lefagyhat renderelés közben.";
        let response = await fetch("/select/" + table_name + (filter ? `?filter=${filter}` : ""));
        let data = await response.json();

        table.innerHTML = "<tr></tr>";

        let row = document.querySelector("tr")

        for (let i of scheme[table_name]["columns"]) {
            row.innerHTML += `<th>${i}</th>`
        }
        row.innerHTML += `<th>Szerkeszt</th>`
        row.innerHTML += `<th>Töröl</th>`

        let i = 0
        for (let data_row of data) {
            i++;
            row_html = Object.values(data_row).map(element => `<td><input type="text" class="data" value="${element}"></input></td>`).join('');

            // ezt láthatatlan sor az update hívásnál lesz használva az aktuálisan szerkesztett sor azonosítására
            // a backenden
            // ez egy nagyoooooon csúnya megoldás
            row_html += `<td style="display:none" class="original_data" id="original-${i}">${JSON.stringify(data_row)}</td>`
            row_html += `<td class="edit_btn"><button onclick="editRow(${i})">Szerkeszt</button></td>`
            row_html += `<td class="del_btn"><button onclick="deleteRow(${i})">Töröl</button></td>`
            table.innerHTML += `<tr id="data-row-${i}">` + row_html + "</tr>"

            if (limit && i > 100) {
                break;
            }
        }

        // insert row
        row_html = ""
        for (let i of scheme[table_name]["columns"]) {
            row_html += `<td><input type="text" placeholder="${i}"></input></td>`
        }
        row_html += `<td class="insert_btn"><button onclick="insertRow()">Beszúrás</button></td><td></td>`
        table.innerHTML += '<tr id="insert-row">' + row_html + "</tr>"

    } catch (error) {
        console.error(error);
    } finally {
        lock = false;
    }
}

async function deleteRow(num) {
    try {
        let original = Object.values(JSON.parse(document.getElementById("original-" + num).innerText))
        await fetch("/del/" + table_name, {
            method: "DELETE", body: JSON.stringify({ "original": original }), headers: {
                "Content-type": "application/json",
            }
        });
        loadTable()
    } catch (error) {
        console.error(error);
    }
}

async function insertRow() {
    try {
        // Array.from is needed because of https://stackoverflow.com/a/46349468/9767089
        // tl;dr: to be able to use .map()
        // így nem lehet "null"-t beállítani, tudom. Leheten ide tenni egy escape karaktert, vagy egy set null gombot.
        let values = Array.from(document.getElementById("data-row-" + num).querySelectorAll("input")).map((e) => e.value === "null" ? null : e.value)
        await fetch("/insert/" + table_name, {
            method: "PUT", body: JSON.stringify({ "values": values }), headers: {
                "Content-type": "application/json",
            }
        });
        loadTable()
    } catch (error) {
        console.error(error);
    }
}

async function editRow(num) {
    try {
        let original = Object.values(JSON.parse(document.getElementById("original-" + num).innerText))
        let values = Array.from(document.getElementById("data-row-" + num).querySelectorAll("input")).map((e) => e.value === "null" ? null : e.value)
        await fetch("/update/" + table_name, {
            method: "PATCH", body: JSON.stringify({ "new": values, "original": original }), headers: {
                "Content-type": "application/json",
            }
        });
        loadTable()
    } catch (error) {
        console.error(error);
    }
}

function filterBtn() {
    filter = document.getElementById("filterInp").value;
    loadTable();
}
