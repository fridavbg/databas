const mysql = require("promise-mysql");
const config = require("../config.json");

async function connectDb() {
    let sql;
    let res;
    const db = await mysql.createConnection(config);

    sql = "USE skolan;";
    res = await db.query(sql);
    console.info("You have connected to the Db");
    db.end();
}

module.exports.connectDb = connectDb;
