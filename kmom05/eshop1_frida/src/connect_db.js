const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");

async function connectDb() {
    const db = await mysql.createConnection(config);

    console.log("#### DB is connected");
    db.end();
}

module.exports.connectDb = connectDb;
