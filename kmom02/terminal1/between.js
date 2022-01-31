/**
 * A simple program to display information from the skolan database.
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
    let minValue, maxValue;

    minValue = await question("Enter minimum value? ");
    maxValue = await question("Enter maximum value? ");
    str = await searchTeachers(db, minValue, maxValue);
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
async function searchTeachers(db, minValue, maxValue) {
    let sql;
    let res;
    let str;
    let minVal = `${minValue}`;
    let maxVal = `${maxValue}`;

    console.info(`Searching for values between: ${minValue} - ${maxValue}`);

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
            lon BETWEEN ? AND ?
            OR kompetens BETWEEN ? AND ?
        ORDER BY akronym;
    `;
    res = await db.query(sql, [minVal, maxVal, minValue, maxValue]);
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
