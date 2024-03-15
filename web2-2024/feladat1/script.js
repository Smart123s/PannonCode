function btnSearch() {
    let xmlhttp = new XMLHttpRequest();
    let query = document.getElementById("search-input").value
    let filter = document.getElementById("search-category").value

    let url = ""
    switch (filter) {
        case "all":
            url = "https://api.tvmaze.com/search/shows?q=" + query;
            break;
        case "actor":
            url = "https://api.tvmaze.com/search/people?q=" + query;
            // a people végpont egy csomó adatot nem ad vissza, amit a találati listában meg kéne jeleníteni
            // a feladat leírása szerint (pl. műfajbesorolás, premier, film címe), szóval maradok itt is az alap végpontnál
            url = "https://api.tvmaze.com/search/shows?q=" + query;
            break;
        case "title":
            // erre van külön végpont? én nem találtam.
            url = "https://api.tvmaze.com/search/shows?q=" + query;
            break;
        default:
            alert("Something went wrong");
            return;
    }


    xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            let resp = JSON.parse(this.responseText);
            handleResponse(resp);
        }
    };
    xmlhttp.open("GET", url, true);
    xmlhttp.send();

    function handleResponse(resp) {
        console.log(resp)
        elem = document.getElementById("results");
        elem.innerHTML = "Találatok száma: " + resp.length;

        let i = 0;
        for (let r of resp) {
            i++;
            let show = r["show"]
            elem.innerHTML += `
                <div class="card" style="width: 18rem; margin-bottom: 8px;">
                    <img class="card-img-top" src="${show["image"] ? show["image"]["medium"] : ""}" alt="Borítókép">
                    <div class="card-body">
                    <h5 class="card-title">${show["name"]}</h5>
                    <div class="card-text" id="summary-${i}">${show["summary"]}</div>
                    </div>
                    <ul class="list-group list-group-flush">
                    <li class="list-group-item">IMDB: ${show["externals"] ? show["externals"]["imdb"] : ""}</li>
                    <li class="list-group-item">Nyelv: ${show["language"]}</li>
                    <li class="list-group-item">Műfajbesorolás(ok): ${show["genres"].join(', ')}</li>
                    <li class="list-group-item">Premier: ${show["premiered"]}</li>
                    <li class="list-group-item">Státusz: ${show["status"]}</li>
                    </ul>
                </div>`
            // az összefoglaló max 200 karakter lehet
            let summary = document.getElementById("summary-" + i);
            console.log(summary)
            if (summary.innerText.length > 197) {
                summary.innerText = summary.innerText.substring(0, 197) + "...";
            }
            if (i == 10) {
                // csak az első 10 találtat megjelenítése
                // az API is csak 10 találatot ad vissza, de a feladat kiemeli, hoyg csak 10 találatot
                // jelenítsek meg, szóval biztos ami biztos, itt van ez is :)
                break;
            }
        }
    }

}
