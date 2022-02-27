/**
 * Route for eshop.
 */
"use strict";

const express = require("express");
const router = express.Router();
const eshop = require("../src/eshop.js");

router.get("/eshop/index", (req, res) => {
    let data = {
        title: "Välkommen | BuckStar",
    };

    res.render("eshop/", data);
});

router.get("/eshop/about", async (req, res) => {
    let data = {
        title: "Om | BuckStar",
    };

    res.render("eshop/about", data);
});

router.get("/eshop/category", async (req, res) => {
    let data = {
        title: "Kategori | BuckStar",
    };

    // data.res = await eshop.showBalance();    ersätta med tabell över kategorier

    res.render("eshop/product", data);
});

router.get("/eshop/product", async (req, res) => {
    let data = {
        title: "Produkter | BuckStar",
    };

    // data.res = await eshop.showBalance();    ersätta med tabell över produkter

    res.render("eshop/product", data);
});

router.get("/eshop/crud", async (req, res) => {
    let data = {
        title: "CRUD | BuckStar",
    };

    res.render("eshop/crud", data);
});

module.exports = router;
