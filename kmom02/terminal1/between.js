/**
 * Erik Nästesjö Todd
 * Show teachers and their departments.
 */
"use strict";
const mysql = require("promise-mysql");
const config = require("./config.json");

const teacherAsTable = require("./result_table.js");

// Read from commandline
const readline = require("readline");   // gör att användaren kan skriva in i terminalen
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});


// Promisify rl.question to question
const util = require("util");


rl.question[util.promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};
const question = util.promisify(rl.question);


/**
 * Main function.
 *
 * @async
 * @returns void
 */
(async function () {
    const db = await mysql.createConnection(config);
    let str;
    let search;
    let min;
    let max;

    search = await question("What to search for? ");
    min = await question("Enter minimum value: ");
    max = await question("Enter maximum value: ");
    str = await searchTeachers(db, search, min, max);
    console.info(str);

    rl.close();
    db.end();
})();



/**
 * Output resultset as formatted table with details on a teacher.
 *
 * @async
 * @param {connection} db     Database connection.
 * @param {string}     search String to search for.
 *
 * @returns {string} Formatted table to print out.
 */
async function searchTeachers(db, search, min, max) {
    let sql;
    let res;
    let str;
    let like = `%${search}%`;

    console.info(`Searching for: ${search}`);

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
        WHERE
            (akronym LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR avdelning LIKE ?
            OR fodd = ?)
            AND
            ((lon >= ? AND lon <= ?) OR (kompetens >= ? AND kompetens <= ?))

        ORDER BY akronym;
    `;
    res = await db.query(sql, [like, like, like, like, like, min, max, min, max]);
    str = teacherAsTable(res);
    return str;
}
