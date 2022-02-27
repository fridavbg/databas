/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {};

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");
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
 * Show all entries in the selected table.
 *
 * @async
 * @param {string} table A valid table name.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */

// async function findAllInTable(table) {
//     let sql = `SELECT * FROM ??;`;
//     let res;

//     res = await db.query(sql, [table]);
//     console.info(`SQL: ${sql} (${table}) got ${res.length} rows.`);
//     console.table(res);
//     return res;
// }