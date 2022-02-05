/**
 * Show the competence change from the last salary revision.
 *
 * @author frpe21
 */

const mysql = require("promise-mysql");
const config = require("../config.json");
// const cTable = require("console.table");

/**
 * Show the competence change from the last salary revision.
 *
 * @returns (string) menu options
 *
 */

async function showLon() {
    const db = await mysql.createConnection(config);
    let sql = `SELECT 
        pre,
        nu,
        diff
        FROM v_lonerevision;`;
    let res = await db.query(sql);

    console.log("LON");
    console.table(res);
}

module.exports.showLon = showLon;
