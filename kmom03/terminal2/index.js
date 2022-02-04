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

(async function () {
    await db.connectDb();
    rl.on("close", helpers.exitProgram);
    rl.on("line", handleInput);

    rl.setPrompt(
        ` --- Please choose an option:\n` +
            ` --- write menu/help - to see all options \n` +
            `Write your option: \n`
    );
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
        case "teachers":
            teachers.searchTeachers();
            break;
        default:
            helpers.errorLog("Invalid command passed");
    }

    rl.prompt();
}
