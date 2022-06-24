/**
 * A module exporting functions to access the exam database.
 */

"use strict";

const mysql = require("promise-mysql");
const config = require("../config/db/exam.json");
let db;

/**
 * Main function.
 * @async
 * @returns void
 */
(async function () {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

/**
 * Function to display vaccine report
 * @async
 * @returns {RowDataPacket} Resultset from query
 */

async function showPersonReport() {
    let sql = `CALL show_personReport()`;
    let res;

    res = await db.query(sql);

    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Function to search vaccine information
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */

async function searchPersonInfo(searchWord) {
    let sql = `CALL search_personReport('${searchWord}');`;
    let res;

    res = await db.query(sql);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}

module.exports = {
    showPersonReport: showPersonReport,
    searchPersonInfo: searchPersonInfo,
};
