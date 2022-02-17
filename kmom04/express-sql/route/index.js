"use strict";

const express = require("express");
const router = express.Router();

router.get("/", (req, res) => {
    res.send(`<h1>Root route</h1>`);
});

router.get("/about", (req, res) => {
    res.send(`<h1>About route</h1>`);
});

router.get("/query/:test", (req, res) => {
    console.log(req.params.test);
    res.send(`<h1>Query route</h1>`);
});

module.exports = router;
