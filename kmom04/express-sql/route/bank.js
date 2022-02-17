/**
 * Route for bank.
 */
"use strict";

const express = require("express");
const router = express.Router();
const bank = require("../src/bank.js");

router.get("/", (req, res) => {
    let data = {
        title: "Welcome | The Bank",
    };

    res.render("pages/", data);
});

router.get("/balance", async (req, res) => {
    let data = {
        title: "Account balance | The Bank",
    };

    data.res = await bank.showBalance();

    res.render("pages/balance", data);
});

module.exports = router;
