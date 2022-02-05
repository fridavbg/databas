/**
 * Search all teacher information from larare table
 *
 * @author frpe21
 */

const mysql = require("promise-mysql");
const config = require("../config.json");

/**
 * Update the salary of a teacher.
 *
 * @async
 * @param {connection} db      Database connection.
 * @param {string}     acronym Who to update.
 * @param {string}     salary  Value to update with.
 *
 * @returns {void}
 */

async function updateSalary(acronym, salary) {
    const db = await mysql.createConnection(config);

    let sql = `UPDATE larare 
        SET lon = ?
        WHERE 
            akronym = ?
        `;
    let res = await db.query(sql, [salary, acronym]);

    console.log(
        "TEACHERS with akronym " + acronym + " has a new salary of: " + salary
    );
    console.table(res);
}

module.exports.updateSalary = updateSalary;
