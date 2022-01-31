/**
 * A simple program to search information from the skolan database.
 *
 * @author frpe21
 */

/**
 * Show teachers and their departments.
 */

"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

// Read from commandline
const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
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

    search = await question("What to search for? ");
    str = await searchTeachers(db, search);
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
async function searchTeachers(db, search) {
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
            akronym LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR avdelning LIKE ?
            OR lon = ?
            OR kompetens = ?
        ORDER BY akronym;
    `;
    res = await db.query(sql, [like, like, like, like, like, search]);
    str = teacherAsTable(res);
    return str;
}

/**
 * Output resultset as formatted table with details on teachers.
 *
 * @param {Array} res Resultset with details on from database query.
 *
 * @returns {string} Formatted table to print out.
 */
function teacherAsTable(res) {
    let str;

    str =
        "+-----------+---------------------+-----------+----------+-------+-----------+\n";
    str +=
        "| Akronym   | Namn                | Avd       |   Lön    | Komp | Fodd       |\n";
    str +=
        "|-----------|---------------------|-----------|----------|------|------------|\n";
    for (const row of res) {
        str += "| ";
        str += row.akronym.padEnd(10);
        str += "| ";
        str += (row.fornamn + " " + row.efternamn).padEnd(20);
        str += "| ";
        str += row.avdelning.padEnd(10);
        str += "| ";
        str += row.lon.toString().padStart(9);
        str += "| ";
        str += row.kompetens.toString().padStart(5);
        str += "| ";
        str += row.fodd.toISOString().split("T")[0];
        str += " |\n";
    }
    str +=
        "+-----------+---------------------+-----------+----------+------+------------+\n";
    return str;
}
