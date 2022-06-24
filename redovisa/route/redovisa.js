/**
 * Route for vaccin.
 */
"use strict";

const express = require("express");
const router = express.Router();
// const bodyParser = require("body-parser");
// const urlencodedParser = bodyParser.urlencoded({ extended: false });
const sitename = " | Redovisa";

/**
 * INDEX ROUTE
 * /:
 *   get:
 *     summary: Display welcome page
 *     description: Render welcome page
 */
router.get("/", (req, res) => {
    let data = {
        title: `Välkommen  ${sitename}`,
    };

    res.render("redovisa/", data);
});

/**
 * About ROUTE
 * /redovisa:
 *   get:
 *     summary: Display course information
 *     description: Render about page
 */
router.get("/about", async (req, res) => {
    let data = {
        title: `Rapport ${sitename}`,
    };

    res.render("redovisa/om", data);
});

/**
 * Redovisa ROUTE
 * /redovisa:
 *   get:
 *     summary: Display course report
 *     description: Render redovisa page
 */
router.get("/redovisa", async (req, res) => {
    let data = {
        title: `Course Report ${sitename}`,
    };

    res.render("redovisa/redovisa", data);
});

module.exports = router;
