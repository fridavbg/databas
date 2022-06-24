/**
 * Route for vaccin.
 */
"use strict";

const express = require("express");
const router = express.Router();
const formogenhet = require("../src/formogenhet.js");
// const bodyParser = require("body-parser");
// const urlencodedParser = bodyParser.urlencoded({ extended: false });
const sitename = " | Formogenhet";

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
 *     summary: Display all peoples asset
 *     description: Render person report
 */
router.get("/exam/visa", async (req, res) => {
    let data = {
        title: `Person Rapport ${sitename}`,
    };

    data.res = await formogenhet.showPersonReport();
    res.render("exam/visa", data);
});

/**
 * SEARCH ROUTE
 * /exam/search:
 *   get:
 *     summary: Search person report
 *     description: Render search query
 */
router.get("/exam/search", async (req, res) => {
    let searchWord = req.query.search;
    let data = {
        title: `Assets Search ${sitename}`,
    };

    data.res = await formogenhet.searchPersonInfo(searchWord);

    res.render("exam/search", data);
});

module.exports = router;
