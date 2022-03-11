/**
 * Flytta pengar med terminal-program och med express
 *
 * @author frpe21
 */

("use strict");

// const db = require("./src/connect_db");
const helpers = require("./src/helpers");
const eshop = require("./src/eshop");
const eshop2 = require("./src/eshop2");

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
        case "product":
            console.table(await eshop.showProduct());
            break;
        case "shelf":
            console.table(await eshop.showShelfs());
            break;
        case "inv":
            if (parts.length == 1) {
                console.table(await eshop.showInv());
            } else {
                console.table(await eshop.searchInv(parts[1]));
            }
            break;
        case "invadd":
            await eshop.addToShelf(parts[1], parts[2], parts[3]);
            console.info(
                `${parts[3]} products with id ${parts[1]} added to shelf ${parts[2]}`
            );
            break;
        case "invdel":
            await eshop.removeFromShelf(parts[1], parts[2], parts[3]);
            console.info(
                `${parts[3]} products with id ${parts[1]} removed from shelf ${parts[2]}`
            );
            break;
        case "order":
            // await eshop.removeFromShelf(parts[1], parts[2], parts[3]);
            if (parts.length == 1) {
                console.table(await eshop2.showOrder());
            } else {
                console.table(await eshop2.searchOrder(parts[1]));
            }
            break;
        case "picklist":
            if (parts.length == 1) {
                console.info(`You need to enter a ordernumber`);
            } else {
                console.table(await eshop2.show_plocklista(parts[1]));
            }
            break;
        case "ship":
            // await eshop.removeFromShelf(parts[1], parts[2], parts[3]);
            console.info(`ORDERSTATUS for ${parts[1]} has been changed`);
            console.table(await eshop2.update_kundorder(parts[1]));
            // console.table(await eshop2.update_kundorder());
            break;
        default:
            helpers.errorLog("Invalid command passed");
    }
    rl.prompt();
}
