/**
 * A simple test program.
 *
 * @author frpe21
 */

"use strict";

/**
 * A sample of a main function stating the famous Hello World.
 *
 * @returns void
 */
function main() {
    let a = 1;
    let b;
    let range = "";
    let currentDate = new Date();
    let day = currentDate.getDate();
    let month = currentDate.getMonth() + 1;
    let year = currentDate.getFullYear();

    b = a + 1;

    for (let i = 0; i < 9; i++) {
        range += i + ", ";
    }

    let i = 0;
    let str = "";

    while (range.length > i) {
        if (range[i] % 2 == 0) {
            str += range[i];
        }
        i++;
    }

    console.info("Hello World");
    console.info(range.substring(0, range.length - 2));
    console.info(a, b);
    console.info(str);
    console.log(day, month, year);
}

main();
