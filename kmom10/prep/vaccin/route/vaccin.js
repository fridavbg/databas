/**
 * Route for vaccin.
 */
"use strict";

const express = require("express");
const router = express.Router();
const vaccine = require("../src/vaccin.js");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });
const sitename = " | Effektiv Vaccinering";

/**
 * INDEX ROUTE
 * /exam/index:
 *   get:
 *     summary: Display welcome page
 *     description: Render welcome page
 */
router.get("/exam/index", (req, res) => {
    let data = {
        title: `Välkommen  ${sitename}`,
    };

    res.render("exam/", data);
});

/**
 * VISA ROUTE
 * /exam/visa:
 *   get:
 *     summary: Display vaccine report
 *     description: Render visa page
 */
router.get("/exam/visa", async (req, res) => {
    let data = {
        title: `Vaccine Rapport ${sitename}`,
    };

    data.res = await vaccine.showVaccineReport();
    res.render("exam/visa", data);
});

/**
 * INDEX ROUTE
 * /exam/visa:
 *   get:
 *     summary: Display vaccine report
 *     description: Render visa page
 */
router.get("/exam/search", async (req, res) => {
    let searchWord = req.query.search;
    let data = {
        title: `Vaccine Search ${sitename}`,
    };

    data.res = await vaccine.searchVaccineInfo(searchWord);

    res.render("exam/search", data);
});

module.exports = router;
