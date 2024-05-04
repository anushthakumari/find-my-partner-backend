const pool = require("../libs/pool");

module.exports.set_user_steps = async (
	user_id,
	step_number = 1,
	step_complete = false
) => {
	const q = `
			UPDATE public.user_steps
			SET step_number=$1, step_complete=$2
			WHERE user_id=$3;
		`;

	await pool.query(q, [step_number, step_complete, user_id]);
	return true;
};
