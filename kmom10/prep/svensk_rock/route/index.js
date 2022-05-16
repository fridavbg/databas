/**
 * General routes.
 */
"use strict";

const express = require("express");
const router = express.Router();
const rock = require("../src/rock");
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

// Add a route for the path /about
router.get("/exam/visa", async (req, res) => {
    let data = {
        title: `Visa  ${sitename}`,
    };

    data.res = await rock.showGigs();

    res.render("exam/visa", data);
});

module.exports = router;
