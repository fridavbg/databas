/**
 * A simple test program.
 *
 * @author frpe21
 */

/**
 * To verify that mysql is installed and is working.
 * Create a connection to the database and execute
 * a query without actually using the database.
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("../terminal1/config.json");

/**
 * Main function.
 * @async
 * @returns void
 */
(async function () {
    let sql;
    let res;
    const db = await mysql.createConnection(config);

    sql = "SELECT * from larare";
    res = await db.query(sql);

    console.info(res);

    db.end();
})();
