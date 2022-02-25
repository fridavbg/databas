/**
 * Erik Nästesjö Todd
 * Creates reports from teacher table
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");
const teacherAsTable = require("./result_table.js");

/**
 * Main function.
 * @async
 * @returns void
 */
(async function() {
    const db = await mysql.createConnection(config);

    let str;

    str = await viewTeachers(db);

    console.info(str);

    db.end();
})();


/**
 * Get a report with teacher details, formatted as a text table.
 *
 * @async
 * @param {connection} db Database connection.
 *
 * @returns {string} Formatted table to print out.
 */
async function viewTeachers(db) {
    let sql;
    let res;
    let str;

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            fodd
        FROM larare
        ORDER BY akronym;
    `;
    res = await db.query(sql);
    str = teacherAsTable(res);
    return str;
}
