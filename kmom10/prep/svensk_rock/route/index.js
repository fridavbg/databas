/**
 * General routes.
 */
"use strict";

const express = require("express");
const router = express.Router();
const sitename = "Svensk Rock";

/**
 * INDEX ROUTE
 * /exam/index:
 *   get:
 *     summary: Display welcome page
 *     description: Render welcome page
 */ router.get("/exam/index", (req, res) => {
    let data = {
        title: `Välkommen  ${sitename}`,
    };
    res.render("exam/", data);
});

// Add a route for the path /about
router.get("/exam/visa", (req, res) => {
    let data = {
        title: `Om  ${sitename}`,
    };

    res.render("exam/visa", data);
});

module.exports = router;
