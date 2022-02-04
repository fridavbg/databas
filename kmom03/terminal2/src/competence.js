/**
 * Shows all teacher information from larare table
 *
 * @author frpe21
 */

const mysql = require("promise-mysql");
const config = require("../config.json");
// const cTable = require("console.table");

/**
 * Show all information regarding teachers
 *
 * @returns (string) menu options
 *
 */

async function searchKompetens() {
    const db = await mysql.createConnection(config);
    let sql = `SELECT * FROM larare;`;
    let res = await db.query(sql);

    console.log("KOMPETENS");
    console.table(res);
}

module.exports.searchKompetens = searchKompetens;
