/**
 * Route for exam.
 */
"use strict";

const express = require("express");
const router = express.Router();
const hund = require("../src/hund.js");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });
const sitename = " | Hund";

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
 * Visa ROUTE
 * /exam/visa:
 *   get:
 *     summary: Display about page
 *     description: Render information of creators
 */
router.get("/exam/visa", async (req, res) => {
    let data = {
        title: `Om  ${sitename}`,
    };

    res.render("exam/visa", data);
});

module.exports = router;
