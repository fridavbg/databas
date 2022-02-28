/**
 * Flytta pengar med terminal-program och med express
 *
 * @author frpe21
 */

("use strict");

const db = require("./src/connect_db");
const helpers = require("./src/helpers");
const eshop = require("./src/eshop");

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
    helpers.printMenu();
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

async function handleInput(line) {
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
        case "about":
            helpers.printGroupNames();
            break;
        case "log":
            console.table(await eshop.showLog(parts[1]));
            break;
        default:
            helpers.errorLog("Invalid command passed");
    }
    rl.prompt();
}
