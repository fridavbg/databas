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
            # move: move 1.5 money to Eva
            # balance: check account balances
            # checkDb: Is the db connected?
    `;
    console.info(message);
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

module.exports = {
    printMenu,
    errorLog,
    exitProgram,
};
