/**
 * Route for eshop.
 */
"use strict";

const express = require("express");
const router = express.Router();
const eshop = require("../src/eshop.js");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });
const sitename = " | BuckStar";

// INDEX

router.get("/eshop/index", (req, res) => {
    let data = {
        title: `Välkommen  ${sitename}`,
    };

    res.render("eshop/", data);
});

// ABOUT

router.get("/eshop/about", async (req, res) => {
    let data = {
        title: `Om  ${sitename}`,
    };

    res.render("eshop/about", data);
});

// KATEGORI

router.get("/eshop/category", async (req, res) => {
    let data = {
        title: `Kategori  ${sitename}`,
    };

    data.res = await eshop.showCategory();

    res.render("eshop/category", data);
});

// PRODUCT
// GETS
router.get("/eshop/product", async (req, res) => {
    let data = {
        title: "Produkter",
    };

    data.res = await eshop.showProduct();

    res.render("eshop/product", data);
});

router.get("/eshop/product/:produktkod", async (req, res) => {
    let produktkod = req.params.produktkod;
    let data = {
        title: `Produkt | ${produktkod} ${sitename}`,
        account: produktkod,
    };

    data.res = await eshop.showProductkod(produktkod);

    res.render("eshop/product-view", data);
});

router.get("/eshop/edit/:produktkod", async (req, res) => {
    let produktkod = req.params.produktkod;
    let data = {
        title: `Edit account ${produktkod} ${sitename}`,
    };

    data.res = await eshop.showProductkod(produktkod);

    res.render("eshop/product-edit", data);
});

router.get("/eshop/delete/:produktkod", async (req, res) => {
    let produktkod = req.params.produktkod;
    let data = {
        title: `Delete produkt ${produktkod} ${sitename}`,
    };

    data.res = await eshop.showProductkod(produktkod);

    res.render("eshop/product-delete", data);
});

router.get("/eshop/create", async (req, res) => {
    let data = {
        title: `Create account ${sitename}`,
    };

    res.render("eshop/product-create", data);
});

// PRODUKT POSTS

router.post("/eshop/edit", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.editProduct(
        req.body.produktkod,
        req.body.produktnamn,
        req.body.produktbeskrivning,
        req.body.produktpris
    );
    res.redirect(`/eshop/crud`);
});

router.post("/eshop/create", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.createProduct(
        req.body.produktnamn,
        req.body.produktbeskrivning,
        req.body.produktpris
    );
    res.redirect(`/eshop/crud`);
});

router.post("/eshop/delete", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.deleteProduct(req.body.produktkod);
    res.redirect(`/eshop/crud`);
});
module.exports = router;

// CRUD

router.get("/eshop/crud", async (req, res) => {
    let data = {
        title: `CRUD |  ${sitename}`,
    };

    data.res = await eshop.showProduct();

    res.render("eshop/crud", data);
});

module.exports = router;
