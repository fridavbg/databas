/**
 * Main program for terminal program
 */
"use strict";

// Read from commandline
const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

require("console.table");
const bank = require("./src/bank");



/**
 * Main function.
 *
 * @returns void
 */
(function () {
    rl.on("close", exitProgram);
    // Lägger en eventhanterare till “close-eventet”.
    //Det är till exempel om användaren trycker ctrl - d vilket ofta innebär slutet på inmatning.
    //När det eventet fångas så anropas dess eventhanterare,
    //som nu är funktionen exitProgram.
    rl.on("line", handleInput);
    // Definierar den eventhanterare som anropas när eventet “line” sker,
    //det är när användaren har matat in något och tryckt enter.
    // Då anropas eventets callback som är funktionen handleInput.
    console.info("\n\n*** Welcome to Bank ***\n");
    drawMenu();
})();


function drawMenu() {
    console.info(
        "\n--------- COMMANDS ---------\n"
        + "\n(help/menu) Show available commands\n"
        + "\n(balance) Check balance on accounts\n"
        + "\n(move) Transfer money from Adam to Eva\n"
        + "\n(exit/quit) Exit program\n"
        + "\n------------------------"
    );
    rl.setPrompt("\n --> ");
    rl.prompt();
}


/**
 * Handle input as a command and send it to a function that deals with it.
 *
 * @param {string} line The input from the user.
 *
 * @returns {void}
 */
async function handleInput(input) {
    input = input.trim();
    input = input.split(" ");

    switch (input[0]) {
        case "menu":
        case "help":
            drawMenu();
            break;
        case "balance":
            console.table(await bank.showBalance());
            break;
        case "move":
            await bank.transfer("1111", "2222", 1.5);
            console.info("Transfer complete");
            break;
        case "quit":
        case "exit":
            process.exit();
    }

    rl.setPrompt("\n --> ");
    rl.prompt();
}

// function enterToContinue() {
//     pressEnter = true;
//     rl.setPrompt("\n[Enter] för att återgå till menu --> ");
//     rl.prompt();
// }


/**
 * Close down program and exit with a status code.
 *
 * @param {number} code Exit with this value, defaults to 0.
 *
 * @returns {void}
 */
function exitProgram(code) {
    code = code || 0;

    console.info("Exiting with status code " + code);
    process.exit(code);
}

