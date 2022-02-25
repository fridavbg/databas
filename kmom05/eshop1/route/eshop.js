/**
 * Route for eshop.
 */
"use strict";

const express = require("express");
const router = express.Router();
const bank = require("../src/eshop.js");

router.get("/eshop/index", (req, res) => {
    let data = {
        title: "Welcome | BuckStar",
    };

    res.render("eshop/", data);
});

router.get("/eshop/about", async (req, res) => {
    let data = {
        title: "About | BuckStar",
    };

    res.render("eshop/about", data);
});

module.exports = router;
