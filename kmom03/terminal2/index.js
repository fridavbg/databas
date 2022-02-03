/**
 * Node.js terminalprogram mot MySQL med kommandoloop
 *
 * @author frpe21
 */

"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

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
    const db = await mysql.createConnection(config);

    rl.on("close", exitProgram);
    rl.on("line", handleInput);

    rl.setPrompt(
        `Please choose an option:\n` +
            `write menu/help - to see all options \n` +
            `Write and option: `
    );
    rl.prompt();
    db.end();
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
        case "search":
            startSearch();
            break;
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
        `search: search database \n`;
    console.info(message);
}

/**
 * Show the user all search options
 *
 * @returns (string) menu options
 *
 */
async function startSearch() {
    rl.on("line", handleInputSearch);

    rl.setPrompt(`What would you like to search for ?\n` + `Search: `);
    rl.prompt();
}

function handleInputSearch(line) {
    line = line.trim();
    switch (line) {
        case "quit":
        case "exit":
            exitProgram();
            break;
        case "larare":
            return "teacher-search";
        case "kompetens":
            return "kompetens";
        case "lon":
            return "lon";
        case "nylon":
            return "nylon";
        default:
            return "sok";
    }

    rl.prompt();
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
