const jwtUtils = require("../libs/jwt");

const authMiddleware = (req, res, next) => {
	const token = req.headers.authorization;

	if (!token) {
		return res.status(401).json({ message: "Unauthorized" });
	}

	try {
		const userId = jwtUtils.verifyToken(token);

		req.user_id = userId;

		next();
	} catch (error) {
		res.status(401).json({ message: "Invalid token" });
	}
};

module.exports = authMiddleware;
