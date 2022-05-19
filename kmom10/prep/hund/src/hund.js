/**
 * A module exporting functions to access the exam database.
 */

"use strict";

module.exports = {
    showMemberInfo: showMemberInfo,
    searchMemberInfo: searchMemberInfo,
};

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
 * Function to show member information
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */

async function showMemberInfo() {
    let sql = `CALL show_memberInfo();`;
    let res;

    res = await db.query(sql);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}

/**
 * Function to show member information
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */

async function searchMemberInfo(searchWord) {
    let sql = `CALL search_memberInfo('${searchWord}');`;
    let res;

    res = await db.query(sql);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}
