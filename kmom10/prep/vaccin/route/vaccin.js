/**
 * Route for vaccin.
 */
"use strict";

const express = require("express");
const router = express.Router();
const eshop = require("../src/vaccin.js");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });
const sitename = " | BuckStar";

/**
 * INDEX ROUTE
 * /eshop/index:
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

module.exports = router;
