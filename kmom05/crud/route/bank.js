/**
 * Route for bank.
 */
"use strict";

const express = require("express");
const router = express.Router();
const bank = require("../src/bank.js");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

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

router.get("/bank/account/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Account ${id} | Bank`,
        account: id,
    };

    data.res = await bank.showAccount(id);

    res.render("bank/account-view", data);
});

router.get("/bank/move-to-adam", async (req, res) => {
    let data = {
        title: "Move to Adam | The Bank",
    };

    data.res = await bank.moveToAdam();

    res.render("bank/move-to-adam", data);
});

router.get("/bank/create", async (req, res) => {
    // view form
    let data = {
        title: "Create account | The Bank",
    };
    res.render("bank/create", data);
});

router.get("/bank/account/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `account ${id} | The Bank}`,
        account: id,
    };

    data.res = await bank.showAccount(id);

    res.render("bank/account-view", data);
});

router.post("/bank/create", urlencodedParser, async (req, res) => {
    // Extract the data from the posted form
    await bank.createAccount(req.body.id, req.body.name, req.body.balance);
    // console.log(JSON.stringify(req.body, null, 4));
    // Send data to a stored procedure
    res.redirect("/bank/balance");
});

module.exports = router;
