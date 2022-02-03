/**
 * Guess my number, a sample CLI client.
 */
"use strict";

// Read from commandline
const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

// Import game module
const Game = require("./game.js");
const game = new Game();

/**
 * Main function.
 *
 * @returns void
 */
(function () {
    rl.on("close", exitProgram);
    rl.on("line", handleInput);

    game.init();
    console.log(
        "Lets run a game of 'Guess my number!'\n" +
            "I am guessing of a number between 1 and 100. \n" +
            "Can you find out what number I'm guessing?\n"
    );

    rl.setPrompt("Guess my number: ");
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
    let guess;
    let thinking;

    thinking = game.cheat();

    line = line.trim();
    switch (line) {
        case "quit":
        case "exit":
            exitProgram();
            break;
        case "cheat":
            console.info(thinking);
            break;
        case "init":
            game.init();
            break;
        case "help":
        case "menu":
            printMenu();
            break;
        default:
            guess = Number.parseInt(line);
            makeGuess(guess);
    }

    rl.prompt();
}

/**
 * Guess the number and check if its correct
 *
 * @param (integer) guess The number begin guessed.
 *
 * @returns (boolean) true if correct guess, otherwise false.
 *
 */

function makeGuess(guess) {
    let match;

    match = game.check(guess);

    if (match) {
        console.info(` Congratulations! You guessed the number I thought of.`);
        return;
    }

    console.info(` Wrong! The number is ${game.compare(guess)}.`);
}

/**
 * Show the user all game options
 *
 * @returns (string) menu options
 *
 */

function printMenu() {
    let message;

    message =
        `Please choose one of the following\n` +
        `exit or quit : to stop game\n` +
        `cheat : to see correct number\n` +
        `init : to restart the game\n` +
        `menu: display game options\n`;
    console.info(message);
}

/**
 * Close down program and exit with a status code
 *
 * @param (number) Code Exit with this value, defaults to 0.
 *
 * @return (void)
 */

function exitProgram(code) {
    code = code || 0;

    console.info("Exiting with status code " + code);
    process.exit(code);
}
