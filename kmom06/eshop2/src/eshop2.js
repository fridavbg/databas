/**
 * A module exporting functions to access the eshop database.
 */

"use strict";

module.exports = {
    searchOrder: searchOrder,
    showOrder: showOrder,
    show_plocklista: show_plocklista,
    update_kundorder: update_kundorder,
};

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
 * Show order.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showOrder() {
    let sql;

    sql = `CALL show_orders();`;

    let res;

    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Search order.
 *
 * @async
 * @param {string} searchWord      Search on this word.
 * @returns {RowDataPacket} Resultset from the query.
 */
async function searchOrder(searchWord) {
    let sql;

    sql = `CALL search_order('${searchWord}');`;

    let res;

    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show picklist for order number.
 *
 * @async
 * @param {string} orderNumber      Search on this number.
 * @returns {RowDataPacket} Resultset from the query.
 */
async function show_plocklista(orderNumber) {
    let sql;

    sql = `CALL show_plocklista('${orderNumber}');`;

    let res;

    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show picklist for order number.
 *
 * @async
 * @param {string} orderNumber      Search on this number.
 * @returns {RowDataPacket} Resultset from the query.
 */
async function update_kundorder(orderNumber) {
    let sql;

    sql = `CALL update_orderstatus('${orderNumber}');`;

    let res;

    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}
