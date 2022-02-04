/**
 * Node.js terminalprogram mot MySQL med kommandoloop
 *
 * @author frpe21
 */

("use strict");

const db = require("./src/connect_db.js");

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
    rl.on("close", exitProgram);
    rl.on("line", handleInput);

    rl.setPrompt(
        `Please choose an option:\n` +
            `write menu/help - to see all options \n` +
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
            exitProgram();
            break;
        case "help":
        case "menu":
            printMenu();
            break;
        case "teachers":
            searchTeachers();
            break;
        default:
            errorLog("Invalid command passed");
    }

    rl.prompt();
}

/**
 * Show the user all programme options
 *
 * @returns (string) menu options
 *
 */

function printMenu() {
    let message;

    message =
        `Please choose one of the following\n` +
        `exit or quit or ctrl + d: to stop game\n` +
        `menu or help: to see programme options \n` +
        `teachers: search database \n`;
    console.info(message);
}

/**
 * Show all information regarding teachers
 *
 * @returns (string) menu options
 *
 */
async function searchTeachers() {
    // let sql;

    console.log("TEACHERS");
}

function errorLog() {
    console.log("Invalid command");
}

function exitProgram(code) {
    /**
     * Close down program and exit with a status code
     *
     * @param (number) Code Exit with this value, defaults to 0.
     *
     * @return (void)
     */

    code = code || 0;

    console.info("Exiting with status code " + code);
    process.exit(code);
}
