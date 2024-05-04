const pool = require("../libs/pool");

module.exports.test = async (req, res, next) => {
	const { rows } = await pool.query("SELECT * FROM users");

	res.send({ message: "Its working!!", data: rows });
};
