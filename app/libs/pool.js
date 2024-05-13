const { Pool } = require("pg");

const { isProd } = require("../utils/helpers");

const pool = new Pool({
	ssl: isProd() ? "no-verify" : undefined,
});

module.exports = pool;
