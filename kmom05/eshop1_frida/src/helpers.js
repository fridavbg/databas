const eshop = require("./eshop");


module.exports = {
    printMenu,
    errorLog,
    exitProgram,
    printGroupNames
};


/**
 * Show the user all programme options
 *
 * @returns (string) menu options
 *
 */

function printMenu() {
    let message;

    message = `
    ----- Please choose one of the following:
            # exit or quit or ctrl + d: to quit
            # menu or help: to see programme option
            # about: to see names of group members
            # log <number>: to see latest <number> of logs
            # product: to see table of products
            # shelf: to see shelfs in inventory
            # inv: to see inventory
            # inv <str>: to search inventory on <str>
            # invadd <productid> <shelf> <number>: to add number of products to shelf
            # invdel <productid> <shelf> <number>: to remove number of products from shelf
    `;
    console.info(message);
}

function printGroupNames() {
    let message;

    message = `
    ----- Group Members:
        # Frida Persson
        # Erik Nästesjö Todd
    `;
    console.info(message)
}

function errorLog(error) {
    console.error(error);
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

