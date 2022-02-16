"use strict";
const express = require("express");
const port = 1337;
const app = express();
const indexRoutes = require("./routes/index.js");
const path = require("path");

app.use((req, res, next) => {
    console.log(`Got a request on: ${req.path}`);
    next();
});

app.use(express.static(path.join(__dirname + "/public")));

app.use("/", indexRoutes);

app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
