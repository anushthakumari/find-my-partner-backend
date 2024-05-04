const { Router } = require("express");

const testRoutes = require("./test.routes");
const userRoutes = require("./users.routes");

const authMiddleware = require("../middlewares/auth");

const router = Router();

router.use("/", testRoutes);
router.use("/users", userRoutes);

module.exports = router;
