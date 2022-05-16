/**
 * A module exporting functions to access the exam database
 */

"use strict";

module.exports = {
    showGigs: showGigs,
    searchGigs: searchGigs,
};

const mysql = require("promise-mysql");
const config = require("../config/db/exam.json");
let db;

/**
 * Main function
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
 * Show rapport with all artist name, id, location, country, countrycode and times and dates they have a concert
 * @async
 * @returns {RowPacketData} Resultset from query.
 */

async function showGigs() {
    console.log("QUERY");
    let sql = `CALL show_concertInfo();`;
    let res;
    res = await db.query(sql);
    // console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}

/**
 * Search concert schedule.
 *
 * @async
 * @param {string} searchWord Search on this word.
 * @returns {RowDataPacket} Resultset from the query.
 */
async function searchGigs(searchWord) {
    let sql;

    sql = `CALL search_concertinfo('${searchWord}');`;

    let res;

    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}
