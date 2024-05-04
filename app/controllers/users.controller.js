const bcrypt = require("bcrypt");

const users_services = require("../services/users.services");

const pool = require("../libs/pool");
const jwt = require("../libs/jwt");
const uuid = require("../libs/uuid");

module.exports.register = async (req, res, next) => {
	const { name, email, password, phoneNumber } = req.body;

	// Trim whitespace from input fields
	const trimmedFullname = name.trim();
	const trimmedEmail = email.trim();
	const trimmedPassword = password.trim();
	const trimmedPhoneNumber = phoneNumber.trim();
	const number = parseInt(trimmedPhoneNumber);

	let q = `
			SELECT * FROM users WHERE email=$1
	`;

	let { rows } = await pool.query(q, [trimmedEmail]);

	if (rows.length > 0) {
		res.status(400).send({ message: "User with this email already exists!" });
		return;
	}

	let { rowCount } = await pool.query(
		`
			SELECT * FROM users WHERE phone_number=$1
	`,
		[number]
	);

	if (rowCount > 0) {
		res
			.status(400)
			.send({ message: "User with this phone number already exists!" });
		return;
	}

	const hashedPassword = await bcrypt.hash(trimmedPassword, 10);

	const user_id = uuid.generateUUID();

	await pool.query(
		"INSERT INTO users (user_id, name, email, password, phone_number) VALUES ($1, $2, $3, $4, $5)",
		[user_id, trimmedFullname, trimmedEmail, hashedPassword, number]
	);

	q = `INSERT INTO public.user_profile(user_id) VALUES($1)`;

	await pool.query(q, [user_id]);

	q = `INSERT INTO public.user_steps(user_id, step_number) VALUES ($1, $2);`;

	await pool.query(q, [user_id, 1]);

	const token = jwt.signToken(user_id);

	q = `SELECT * FROM users WHERE user_id=$1`;

	const { rows: userRows } = await pool.query(q, [user_id]);

	res.send({ ...userRows[0], password: null, token });
};

module.exports.login = async (req, res, next) => {
	const { email = "", password = "" } = req.body;

	if (!email || !password) {
		return res.send({ message: "Email and password are required" });
	}

	try {
		const { rows } = await pool.query("SELECT * FROM users WHERE email = $1", [
			email,
		]);
		if (rows.length === 0) {
			return res.send({ message: "Invalid email or password" });
		}

		const user = rows[0];

		// Compare the passwords
		const isPasswordValid = await bcrypt.compare(
			password.trim(),
			user.password
		);

		if (!isPasswordValid) {
			return res.send({ message: "Invalid email or password" });
		}

		const token = jwt.signToken(user.user_id);

		res.send({ token, ...user, password: null });
	} catch (error) {
		console.error("Login failed:", error);
		return res.status(500).send({
			message: "An unexpected error occurred. Please try again later",
		});
	}
};

module.exports.save_onboard_details = async (req, res, next) => {
	const {
		basic_details,
		education,
		family_details,
		partner_pref,
		verification,
		user_id,
	} = req.body;

	const city = basic_details.location;
	const highest_qualification = education.degree;
	const num_sisters = family_details.n_sis;
	const num_brothers = family_details.n_bros;
	const from_age = partner_pref.minAge;
	const to_age = partner_pref.maxAge;
	const id_proof = verification.idProof;
	const id_num = verification.idNum;

	let q = `
			UPDATE public.user_profile
				SET
					city=$1, highest_qualification=$2, id_proof=$3,
					id_num=$4, num_sisters=$5, num_brothers=$6
				WHERE
					user_id=$7
		`;

	await pool.query(q, [
		city,
		highest_qualification,
		id_proof,
		id_num,
		num_sisters,
		num_brothers,
		user_id,
	]);

	q = `
			UPDATE public.user_preferences
				SET
					from_age=$1, to_age=$2
				WHERE
					user_id=$3
		`;

	await pool.query(q, [from_age, to_age, user_id]);

	await users_services.set_user_steps(user_id, 5, true);

	res.send({ message: "Saved successfully!" });
};

module.exports.getMatches = async (req, res, next) => {
	q = `SELECT * FROM users
		INNER JOIN user_profile
		ON users.user_id=user_profile.user_id`;

	const { rows } = await pool.query(q);

	res.send(rows);
};
