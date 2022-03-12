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

/**
 * INDEX ROUTE
 * /eshop/index:
 *   get:
 *     summary: Display welcome page
 *     description: Render welcome page
 */
router.get("/eshop/index", (req, res) => {
    let data = {
        title: `Välkommen  ${sitename}`,
    };

    res.render("eshop/", data);
});

/**
 * About ROUTE
 * /eshop/about:
 *   get:
 *     summary: Display about page
 *     description: Render information of creators
 */
router.get("/eshop/about", async (req, res) => {
    let data = {
        title: `Om  ${sitename}`,
    };

    res.render("eshop/about", data);
});

/**
 * CATEGORY ROUTE
 * /eshop/category:
 *   get:
 *     summary: Display category page
 *     description: Render data from the
 */

router.get("/eshop/category", async (req, res) => {
    let data = {
        title: `Kategori  ${sitename}`,
    };

    data.res = await eshop.showCategory();

    res.render("eshop/category", data);
});

/**
 * PRODUCT ROUTE
 * /eshop/product:
 *   get:
 *     summary: Display produkt table from db eshop
 *     description: Render data from produkt table
 */
router.get("/eshop/product", async (req, res) => {
    let data = {
        title: "Produkter",
    };

    data.res = await eshop.showProduct();

    res.render("eshop/product", data);
});

/**
 * PRODUCT ROUTE
 * /eshop/product/:produktkod:
 *   get:
 *     summary: Display information of a product
 *     description: CRUD - READ information of a produkt
 */
router.get("/eshop/product/:produktkod", async (req, res) => {
    let produktkod = req.params.produktkod;
    let data = {
        title: `Produkt | ${produktkod} ${sitename}`,
        account: produktkod,
    };

    data.res = await eshop.showProductkod(produktkod);

    res.render("eshop/product-view", data);
});

/**
 * PRODUCT ROUTE
 * /eshop/edit/:produktkod:
 *   get:
 *     summary: Display information of a product
 *     description: CRUD - READ information of a produkt
 */
router.get("/eshop/edit/:produktkod", async (req, res) => {
    let produktkod = req.params.produktkod;
    let data = {
        title: `Edit account ${produktkod} ${sitename}`,
    };

    data.res = await eshop.showProductkod(produktkod);

    res.render("eshop/product-edit", data);
});

/**
 * PRODUCT ROUTE
 * /eshop/delete/:produktkod:
 *   get:
 *     summary: Display information of a product
 *     description: CRUD - READ information of a produkt
 */
router.get("/eshop/delete/:produktkod", async (req, res) => {
    let produktkod = req.params.produktkod;
    let data = {
        title: `Delete produkt ${produktkod} ${sitename}`,
    };

    data.res = await eshop.showProductkod(produktkod);

    res.render("eshop/product-delete", data);
});

/**
 * PRODUCT ROUTE
 * /eshop/create/:produktkod:
 *   get:
 *     summary: Display information of a product
 *     description: CRUD - READ information of a produkt
 */
router.get("/eshop/create", async (req, res) => {
    let data = {
        title: `Create account ${sitename}`,
    };

    res.render("eshop/product-create", data);
});

/**
 * PRODUCT ROUTE
 * /eshop/edit/:produktkod:
 *   post:
 *     summary: Update information of a product
 *     description: CRUD - UPDATE information of a produkt
 */

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

/**
 * PRODUCT ROUTE
 * /eshop/create/:produktkod:
 *   post:
 *     summary: Display information of a product
 *     description: CRUD - CREATE information for a produkt
 */
router.post("/eshop/create", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.createProduct(
        req.body.produktnamn,
        req.body.produktbeskrivning,
        req.body.produktpris
    );
    res.redirect(`/eshop/crud`);
});


/**
 * PRODUCT ROUTE
 * /eshop/delete/:produktkod:
 *   post:
 *     summary: Display information of a product
 *     description: CRUD - DELETE information of a produkt
 */
router.post("/eshop/delete", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.deleteProduct(req.body.produktkod);
    res.redirect(`/eshop/crud`);
});
module.exports = router;

/**
 * PRODUCT ROUTE
 * /eshop/crud:
 *   get:
 *     summary: Display information of product table
 *     description: CRUD - READ information produkt table
 */
router.get("/eshop/crud", async (req, res) => {
    let data = {
        title: `CRUD |  ${sitename}`,
    };

    data.res = await eshop.showProduct();

    res.render("eshop/crud", data);
});
module.exports = router;

/**
 * CUSTOMERS ROUTE
 * /eshop/customer:
 *   get:
 *     summary: Display information of customer table
 *     description: CRUD - READ information customer table
 */
router.get("/eshop/customers", async (req, res) => {
    let data = {
        title: `Customer |  ${sitename}`,
    };

    data.res = await eshop.showCustomers();

    res.render("eshop/customers", data);
});

/**
 * CREATE ORDER ROUTE
 * /eshop/customers/:id:
 *   get:
 *     summary: Display information of a customer
 *     description: CRUD - Create new order
 */
router.get("/eshop/order/create/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Create order for ${id} ${sitename}`,
    };

    data.res = await eshop.showIndividualCustomer(id);

    res.render("eshop/order-create", data);
});

/**
 * CREATE ORDER ROUTE
 * /eshop/order/create:
 *   get:
 *     summary: Display information of a customer
 *     description: CRUD - Create new order
 */
router.post("/eshop/order/create", urlencodedParser, async (req, res) => {
    console.log(JSON.stringify(req.body, null, 4));
    // console.log(req.body.id);
    await eshop.createOrder(req.body.id);
    res.redirect(`/eshop/order`);
});

/**
 * ORDER ROUTE
 * /eshop/order:
 *   get:
 *     summary: Display information of order
 *     description: CRUD - READ information order
 */
router.get("/eshop/order", async (req, res) => {
    let data = {
        title: `Order |  ${sitename}`,
    };

    data.res = await eshop.showOrders();

    res.render("eshop/order", data);
});

/**
 * ORDER SHOW ROUTE
 * /eshop/order/show/:ordernummer:
 *   get:
 *     summary: Display information of individual order
 *     description: CRUD - READ information order
 */
router.get("/eshop/order/show/:ordernummer", async (req, res) => {
    let ordernummer = req.params.ordernummer;
    let data = {
        title: `Show order with ${ordernummer} ${sitename}`,
    };

    data.res = await eshop.showSpecificOrder(ordernummer);
    data.res2 = await eshop.showSpecificOrderRows(ordernummer);

    res.render("eshop/order-specific", data);
});


/**
 * CHANGE ORDER STATUS
 * /eshop/order/add/show:
 *   get:
 *     summary: Change order status to "beställd"
 *     description: CRUD - Change order status to "beställd"
 */
router.post("/eshop/order/show", urlencodedParser, async (req, res) => {
    console.log(JSON.stringify(req.body, null, 4));
    await eshop.setOrderDate(
        req.body.ordernummer
    );
    res.redirect(`/eshop/order`);
});



/**
 * ORDER SHOW PRODUCTS TO ADD
 * /eshop/order/add/:ordernummer:
 *   get:
 *     summary: Display information of order
 *     description: CRUD - READ information order
 */
router.get("/eshop/order/add/:ordernummer", async (req, res) => {
    let ordernummer = req.params.ordernummer;
    // OBS, vi använder ordernumret bara för
    // att komma tillbaka till rätt varukorg sen
    let data = {
        title: `Show order with ${ordernummer} ${sitename}`,
    };

    data.res = await eshop.showProduct();
    data.ordernummer = ordernummer;

    res.render("eshop/order-add", data);
});


/**
 * ADD TO ORDER ROUTE
 * /eshop/order/add:
 *   get:
 *     summary: Add to shop list
 *     description: CRUD - Add to shop list
 */
router.post("/eshop/order/add", urlencodedParser, async (req, res) => {
    console.log(JSON.stringify(req.body, null, 4));
    await eshop.insertOrderRow(
        req.body.ordernummer,
        req.body.produktkod,
        req.body.quantity
    );
    res.redirect(`/eshop/order/show/` + req.body.ordernummer);
});
