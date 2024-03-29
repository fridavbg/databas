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

async function showKompetens() {
    const db = await mysql.createConnection(config);
    let sql = `SELECT 
        prekomp,
        nukomp,
        diffkomp
        FROM v_lonerevision;`;
    let res = await db.query(sql);

    console.log("KOMPETENS");
    console.table(res);
}

module.exports.showKompetens = showKompetens;
