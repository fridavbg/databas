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
