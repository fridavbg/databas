/**
 * Shows all teacher information from larare table
 *
 * @author frpe21
 */

const mysql = require("promise-mysql");
const config = require("../config.json");

/**
 * Show all information regarding teachers
 *
 * @returns (string) menu options
 *
 */

async function showLarare() {
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
        FROM v_larare;`;
    let res = await db.query(sql);

    console.log("TEACHERS");
    console.table(res);
    return res;
}

module.exports.showLarare = showLarare;
