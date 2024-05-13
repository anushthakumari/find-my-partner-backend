module.exports.isProd = () => {
	return process.env.NODE_ENV === "production";
};
