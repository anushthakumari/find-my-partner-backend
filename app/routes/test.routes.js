const express = require("express");

const testControllers = require("../controllers/test.controller");

const router = express.Router();

router.route("/").get(testControllers.test);

module.exports = router;
