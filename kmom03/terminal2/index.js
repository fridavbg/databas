/**
 * Node.js terminalprogram mot MySQL med kommandoloop
 *
 * @author frpe21
 */

("use strict");

const db = require("./src/connect_db");
const helpers = require("./src/helpers");
const teachers = require("./src/teachers");
const competence = require("./src/competence");
const lon = require("./src/salary");
const search = require("./src/search");
const nylon = require("./src/nylon");

// Read from commandline
const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

/**
 * Main function.
 *
 * @returns void
 */

(function () {
    console.log(`
        ----- Please choose one of the following:
            # exit or quit or ctrl + d: to quit
            # menu or help: to see programme option
    `);
    rl.on("close", helpers.exitProgram);
    rl.on("line", handleInput);
    rl.prompt();
})();

/**
 * Handle input as a cmd and send it to a function that deals with it.
 *
 * @param (string) line the guessed number from user
 *
 * @returns (void)
 */

function handleInput(line) {
    line = line.trim();
    let parts = line.split(" ");

    switch (parts[0]) {
        case "quit":
        case "exit":
            helpers.exitProgram();
            break;
        case "help":
        case "menu":
            helpers.printMenu();
            break;
        case "larare":
            teachers.showLarare();
            break;
        case "kompetens":
            competence.showKompetens();
            break;
        case "lon":
            lon.showLon();
            break;
        case "sok":
            search.searchLarare(parts[1]);
            break;
        case "nylon":
            nylon.updateSalary(parts[1], parts[2]);
            break;
        case "checkDb":
            db.connectDb();
            break;
        default:
            helpers.errorLog("Invalid command passed");
    }
    rl.prompt();
}
