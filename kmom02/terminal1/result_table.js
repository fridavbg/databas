/**
 * Erik Nästesjö Todd
 * Render in form of table
 */
"use strict";

/**
 * Output resultset as formatted table with details on a teacher.
 *
 * @param {RowDataPacket} res Resultset with details on a teacher.
 *
 * @returns {string} Formatted table to print out.
 */
function teacherAsTable(res) {
    let str;

    str = "+-----------+---------------------+-----------+------------+---------+-------------+\n";
    str += "| Akronym   | Namn                | Avd       | Lön        | Komp    | Född        |\n";
    str += "|-----------|---------------------|-----------|------------+---------+-------------+\n";
    for (const row of res) {
        str += "| ";
        str += row.akronym.padEnd(10);
        str += "| ";
        str += (row.fornamn + " " + row.efternamn).padEnd(20);
        str += "| ";
        str += row.avdelning.padEnd(10);
        str += "| ";
        str += row.lon.toString().padEnd(11);
        str += "| ";
        str += row.kompetens.toString().padEnd(8);
        str += "| ";
        str += row.fodd.toLocaleDateString("sv-SE").padEnd(11);
        str += " |\n";
    }
    str += "+-----------+---------------------+-----------+------------+---------+-------------+\n";

    return str;
}

module.exports = teacherAsTable;
