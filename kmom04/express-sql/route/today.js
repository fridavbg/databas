/**
 * Route for today.
 */
"use strict";

var express = require("express");
var router = express.Router();

router.get("/", (req, res) => {
    let data = {};

    data.date = new Date();

    // "today" refererar till filen today.ejs som ligger under views-katalogen
    // vi säger till att den ska renderas med alla variabler som ingår i data
    // se ovan, vi använder routen "/" som referens o i index4.js anger vi... pathen?
    res.render("today", data);
});

module.exports = router;
