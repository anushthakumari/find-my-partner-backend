const jwt = require("jsonwebtoken");

const configs = require("../configs");

const jwtUtils = {
	signToken: (userId) => {
		return jwt.sign({ userId }, configs.JWT_SECRET, { expiresIn: "2d" });
	},
	verifyToken: (token) => {
		return jwt.verify(token, configs.JWT_SECRET, (err, decoded) => {
			if (err) {
				return null;
			}
			return decoded.userId;
		});
	},
};

module.exports = jwtUtils;
