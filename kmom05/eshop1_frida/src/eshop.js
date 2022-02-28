/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showCategory: showCategory,
    showProduct: showProduct,
    showProductkod: showProductkod,
    editProduct: editProduct,
    createProduct: createProduct,
    showLog: showLog,
    showShelfs: showShelfs,
    showInv: showInv,
    searchInv: searchInv
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
 * Show all entries in the categories table.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */

async function showCategory() {
    let sql = `CALL show_category();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show all entries in the categories table.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */

async function showProduct() {
    let sql = `CALL show_product();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show details for a product.
 *
 * @async
 * @param {string} id A id of the account.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showProductkod(produktkod) {
    let sql = `CALL show_productkod(?);`;
    let res;

    res = await db.query(sql, [produktkod]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Edit details on a product.
 *
 * @async
 * @param {string} produktkod      The id of the product to be updated.
 * @param {string} produktnamn    The updated name of the product.
 * @param {string} produktbeskrivning The updated details of the product.
 *  @param {integer} produktpris The updated price of the product.
 *
 * @returns {void}
 */
async function editProduct(
    produktkod,
    produktnamn,
    produktbeskrivning,
    produktpris
) {
    let sql = `CALL edit_produkt(?, ?, ?, ?);`;
    let res;

    res = await db.query(sql, [
        produktkod,
        produktnamn,
        produktbeskrivning,
        produktpris,
    ]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * Create a new product.
 *
 * @async
 * @param {string} produktkod      The id of the product to be updated.
 * @param {string} produktnamn    The updated name of the product.
 * @param {string} produktbeskrivning The updated details of the product.
 *  @param {integer} produktpris The updated price of the product.
 * @returns {void}
 */
async function createProduct(produktnamn, produktbeskrivning, produktpris) {
    let sql = `CALL insert_produkt(?, ?, ?);`;
    let res;

    res = await db.query(sql, [produktnamn, produktbeskrivning, produktpris]);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}


/**
 * Show details for a product.
 *
 * @async
 * @param {integer} numberOfLogs      The number of logs you want to be displayed.
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showLog(numberOfLogs) {
    let sql = `CALL show_logg(${numberOfLogs});`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show shelfs.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showShelfs() {
    let sql = `CALL show_lagerhylla();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show inventory.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showInv() {
    let sql = `CALL show_stock();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Search inventory.
 *
 * @async
 * @param {string} searchWord      Search on this word
 * @returns {RowDataPacket} Resultset from the query.
 */
async function searchInv(searchWord) {
    let sql;
    sql = `CALL search_stock('${searchWord}');`;

    let res;
    res = await db.query(sql);
    //console.log(res);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

