/**
 * Route for bank.
 */
"use strict";

const express = require("express");
const router = express.Router();
const bank = require("../src/bank.js");

router.get("/bank/index", (req, res) => {
    let data = {
        title: "Welcome | The Bank",
    };

    res.render("bank/", data);
});

router.get("/bank/balance", async (req, res) => {
    let data = {
        title: "Account balance | The Bank",
    };

    data.res = await bank.showBalance();

    res.render("bank/balance", data);
});

router.get("/bank/move-to-adam", async (req, res) => {
    let data = {
        title: "Move to Adam | The Bank",
    };

    data.res = await bank.moveToAdam();

    res.render("bank/move-to-adam", data);
});

module.exports = router;
