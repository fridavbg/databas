/**
 * Main program for searching skolan database
 */
"use strict";

// Read from commandline
const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

require("console.table");

// const showAllData = require("./src/show_all_data.js");
// const showCompetenceChange = require("./src/competence_change.js");

const helper = require("./src/helper.js");

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
    console.info( "\n\n*** VÄLKOMMEN TILL SKOLANS DATABAS ***\n");
    drawMenu();
})();


function drawMenu() {
    console.info(
        "\n--------- COMMANDS ---------\n"
        + "\n(help/menu) Visar alla kommandon\n"
        + "\n(larare) Visar all information om skolans lärare\n"
        + "\n(kompetens) Visar förändringen av lärares kompetens\n"
        + "i samband med senaste lönerevisionen\n"
        + "\n(lon) Visar förändringen av lärares lön i samband med senaste lönerevisionen\n"
        + "\n(sok <sokstrang>) Genomför en sökning t.ex. 'sok dumbledore\n"
        + "\n(nylon <akronym> <nylon>) Uppdatera en lärares lön t.ex. 'nylon sna 5000'\n"
        + "\n(exit/quit) Stänger program\n"
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
        case "larare":
            console.table(await helper.showAll());
            break;
        case "kompetens":
            console.table(await helper.showCompetenceChange());
            break;
        case "lon":
            console.table(await helper.showSalaryChange());
            break;
        case "sok":
            console.table(await helper.searchAll(input[1]));
            break;
        case "nylon":
            console.table(await helper.updateLon(input[1], input[2]));
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

