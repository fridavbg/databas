const mysql = require("promise-mysql");
const config = require("../config.json");

async function connectDb() {
    const db = await mysql.createConnection(config);

    console.info("#### You have connected to the Db");
    db.end();
}

module.exports.connectDb = connectDb;
