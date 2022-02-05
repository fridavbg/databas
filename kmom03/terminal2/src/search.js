/**
 * Search all teacher information from larare table
 *
 * @author frpe21
 */

const mysql = require("promise-mysql");
const config = require("../config.json");

/**
 * Search all information regarding teachers
 *
 * @returns (string) menu options
 *
 */

async function searchLarare(searchWord) {
    const db = await mysql.createConnection(config);

    let sql = `SELECT 
        akronym,
        avdelning,
        fornamn,
        efternamn,
        kon,
        lon,
        DATE_FORMAT(fodd, "%Y-%m-%d") as fodd,
        kompetens,
        Alder
        FROM v_larare
        WHERE 
            akronym LIKE ?
        ORDER BY akronym
        `;
    let res = await db.query(sql, [`%${searchWord}%`]);

    console.log("TEACHERS wtih searchword: " + searchWord);
    console.table(res);
    return res;
}

module.exports.searchLarare = searchLarare;
