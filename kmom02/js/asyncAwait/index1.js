/**
 * A test program to show off async and await.
 *
 * @author Mitt Namn
 */
"use strict";

const fs = require("fs");
const path = "file.txt";
let data;

console.info("1) Program is starting up!");

// fs.readFile(path, "utf-8", (err, data) => {
//     console.info(data);
// });

data = fs.readFileSync(path, "utf-8");
console.info(data);

console.info("3) End of the program!");
