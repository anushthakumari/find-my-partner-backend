const express = require("express");

const usersControllers = require("../controllers/users.controller");

const router = express.Router();

router.route("/login").post(usersControllers.login);
router.route("/register").post(usersControllers.register);
router.route("/onboard").post(usersControllers.save_onboard_details);
router.route("/matches").get(usersControllers.getMatches);

module.exports = router;
