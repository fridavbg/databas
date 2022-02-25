
const mysql = require("promise-mysql");
const config = require("../config.json");


let helper = {
    showAll: async function () {
        const db = await mysql.createConnection(config);
        let sql = `
        SELECT
            akronym AS Akronym,
            fornamn AS Förnamn,
            efternamn AS Efternamn,
            avdelning AS Avdelning,
            lon AS Lön,
            kompetens as Kompetens,
            TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
        FROM larare
        ORDER BY akronym;
    `;
        let res = await db.query(sql);

        return res;
        // Den kod som använder funktionen får
        //använda egen kod för att göra till snygg tabell.
    },

    showCompetenceChange: async function () {
        const db = await mysql.createConnection(config);
        let sql = `
        SELECT
            l.akronym AS Akronym,
            l.fornamn AS Förnamn,
            l.efternamn AS Efternamn,
            p.kompetens AS Prekomp,
            l.kompetens AS Nukomp,
            (l.kompetens - p.kompetens) AS Diffkomp
        FROM larare AS l
            JOIN larare_pre AS p
                ON l.akronym = p.akronym
        ORDER BY diffkomp DESC
        ;
    `;
        let res = await db.query(sql);

        return res;
    },

    showSalaryChange: async function () {
        const db = await mysql.createConnection(config);
        let sql = `
        SELECT
            l.akronym,
            l.fornamn,
            l.efternamn,
            p.lon AS pre,
            l.lon AS nu,
            (l.lon - p.lon) AS diff,
            ROUND((((l.lon / p.lon) - 1) * 100), 2) AS proc,
            IF(ROUND((((l.lon / p.lon) - 1) * 100), 2) >= 3, 'ok', 'nook') AS mini
        FROM larare AS l
            JOIN larare_pre AS p
                ON l.akronym = p.akronym
        ORDER BY proc DESC
        ;
    `;

        let res = await db.query(sql);

        return res;
    },

    searchAll: async function (searchWord) {
        const db = await mysql.createConnection(config);
        let like = `%${searchWord}%`;

        console.info(`Söker på: ${searchWord}`);

        let sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            DATE_FORMAT(fodd, '%Y-%m-%d') AS Född
        FROM larare
        WHERE
            akronym LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR avdelning LIKE ?
            OR lon = ?
            OR kompetens = ?
            OR YEAR(fodd) = ?
            OR MONTH(fodd) = ?
            OR DAY(fodd) = ?
        ORDER BY akronym;
    `;

        // Observera speciellt fall med datum.
        // Man MÅSTE söka på exakt sökord(searchWord) samt dela upp i YEAR MONTH och DAY
        let res = await db.query(sql,
            [like, like, like, like, searchWord, searchWord, searchWord, searchWord, searchWord]);

        return res;
    },

    updateLon: async function (acronyme, newSalary) {
        const db = await mysql.createConnection(config);

        let sql = `
        UPDATE larare
        SET
            lon = ?
        WHERE
            akronym = ?
    `;

        await db.query(sql, [newSalary, acronyme]);

        console.info(`Resultat vid uppdatering av ${acronyme}:`);

        let sql2 = `
        SELECT
            akronym AS Akronym,
            fornamn AS Förnamn,
            efternamn AS Efternamn,
            lon AS Lön
        FROM larare
        WHERE
            akronym LIKE ?
        ORDER BY akronym;
    `;
        let res = await db.query(sql2, [acronyme]);

        return res;
    }
};

module.exports = helper;
