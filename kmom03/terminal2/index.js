/**
 * Node.js terminalprogram mot MySQL med kommandoloop
 *
 * @author frpe21
 */

("use strict");

/// WHY NOT ????? const chalk = require("chalk");
const db = require("./src/connect_db.js");
const helpers = require("./src/helpers.js");
const teachers = require("./src/teachers");
const competence = require("./src/competence");

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
    switch (line) {
        case "quit":
        case "exit":
            helpers.exitProgram();
            break;
        case "help":
        case "menu":
            helpers.printMenu();
            break;
        case "larare":
            teachers.searchLarare();
            break;
        case "kompetens":
            competence.searchKompetens();
            break;
        case "lon":
            // teachers.searchTeachers();
            break;
        case "sok":
            // teachers.searchTeachers();
            break;
        case "nylon":
            // teachers.searchTeachers();
            break;
        case "checkDb":
            db.connectDb();
            break;
        default:
            helpers.errorLog("Invalid command passed");
    }
    rl.prompt();
}
