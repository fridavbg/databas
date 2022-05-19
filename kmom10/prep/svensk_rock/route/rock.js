/**
 * General routes.
 */
"use strict";

const express = require("express");
const router = express.Router();
const rock = require("../src/rock");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });
const sitename = "Svensk Rock";

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
 *     summary: Display concertinfo table
 *     description: Render information for database
 */
router.get("/exam/visa", async (req, res) => {
    let data = {
        title: `Visa  ${sitename}`,
    };

    data.res = await rock.showGigs();

    res.render("exam/visa", data);
});

/**
 * Search ROUTE
 * /exam/search:
 *   get:
 *     summary: Display db info matching searchWord
 *     description: Render information of database query
 */ router.get("/exam/search", urlencodedParser, async (req, res) => {
    let searchWord = req.query.search;
    let data = {
        title: `Search  ${sitename}`,
    };

    data.res = await rock.searchGigs(searchWord);

    res.render("exam/search", data);
});

module.exports = router;
