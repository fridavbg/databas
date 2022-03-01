/**
 * A sample Express server.
 */

"use strict";

// Enable server to run on port selected by the user selected
// environment variable DBWEBB_PORT
const port = process.env.DBWEBB_PORT || 1337;
// Set upp Express server
const express = require("express");
const app = express();
const routeEshop = require("./route/eshop.js");

const path = require("path");

// This is middleware called for all routes.
// Middleware takes three parameters.
// Its callback ends with a call to next() to proceed to the next
// middleware, or the actual route.
const middleware = require("./middleware/index.js");

app.use(middleware.logIncomingToConsole);
app.use(express.static(path.join(__dirname + "/public")));
app.use("/", routeEshop);

app.listen(port, logStartUpDetailsToConsole);
app.set("view engine", "ejs");

/**
 * Log app details to console when starting up.
 *
 * @return {void}
 */
function logStartUpDetailsToConsole() {
    let routes = [];

    // Find what routes are supported
    app._router.stack.forEach((middleware) => {
        if (middleware.route) {
            // Routes registered directly on the app
            routes.push(middleware.route);
        } else if (middleware.name === "router") {
            // Routes added as router middleware
            middleware.handle.stack.forEach((handler) => {
                let route;

                route = handler.route;
                route && routes.push(route);
            });
        }
    });

    console.info(`Server is listening on port ${port}.`);
    console.info("Available routes are:");
    console.info(routes);
}
