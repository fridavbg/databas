/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showBalance: showBalance,
    transfer: transfer
};

const mysql = require("promise-mysql");
const config = require("../config/db/bank.json");
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
 * Show all entries in the account table.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showBalance() {
    return await findAllInTable("account");
}

/**
 * Tranfser to Adam
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function transfer(fromAccount, toAccount, amount) {
    return transferSql("account", fromAccount, toAccount, amount);
}


/**
 * Show all entries in the selected table.
 *
 * @async
 * @param {string} table A valid table name.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function findAllInTable(table) {
    // Det dubbla ?? säger till npm-modulen mysql att göra escape
    // på den variabeln för att undvika SQL injections.
    // Dubbla frågetecken används för tabellens namn eller dess kolumnnamn.
    // Enkla frågetecken används för värden.

    let sql = `SELECT * FROM ??;`;
    let res;

    res = await db.query(sql, [table]);
    // console.info(`SQL: ${sql} (${table}) got ${res.length} rows.`);

    return res;
}


/**
 * Transfer from Eva to Adam
 *
 * @async
 * @param {string} table A valid table name.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function transferSql(table, fromAccount, toAccount, amount) {
    // Det dubbla ?? säger till npm-modulen mysql att göra escape
    // på den variabeln för att undvika SQL injections.
    // Dubbla frågetecken används för tabellens namn eller dess kolumnnamn.
    // Enkla frågetecken används för värden.

    let sql = `
    START TRANSACTION;

    UPDATE ??
    SET
        balance = balance + ?
    WHERE
        id = ?;

    UPDATE ??
    SET
        balance = balance - ?
    WHERE
        id = ?;

    COMMIT;`;
    let res;

    res = await db.query(sql, [table, amount, toAccount, table, amount, fromAccount]);
    // console.info(`SQL: ${sql} (${table}) got ${res.length} rows.`);

    return res;
}
