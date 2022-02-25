/**
 * Erik Nästesjö Todd
 * Show teachers and their departments.
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

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
            OR fodd = ?
        ORDER BY akronym;
    `;
    // Observera att vi använder 'search' och inte 'like'
    // när vi söker på lön och kompetens(då vi vill ha exakt sökning)
    res = await db.query(sql, [like, like, like, like, search, search, like]);
    str = teacherAsTable(res);
    return str;
}



/**
 * Output resultset as formatted table with details on a teacher.
 *
 * @param {RowDataPacket} res Resultset with details on a teacher.
 *
 * @returns {string} Formatted table to print out.
 */
function teacherAsTable(res) {
    let str;

    str = "+-----------+---------------------+-----------+------------+---------+-------------+\n";
    str += "| Akronym   | Namn                | Avd       | Lön        | Komp    | Född        |\n";
    str += "|-----------|---------------------|-----------|------------+---------+-------------+\n";
    for (const row of res) {
        str += "| ";
        str += row.akronym.padEnd(10);
        str += "| ";
        str += (row.fornamn + " " + row.efternamn).padEnd(20);
        str += "| ";
        str += row.avdelning.padEnd(10);
        str += "| ";
        str += row.lon.toString().padEnd(11);
        str += "| ";
        str += row.kompetens.toString().padEnd(8);
        str += "| ";
        str += row.fodd.toLocaleDateString("sv-SE").padEnd(11);
        str += " |\n";
    }
    str += "+-----------+---------------------+-----------+------------+---------+-------------+\n";

    return str;
}
