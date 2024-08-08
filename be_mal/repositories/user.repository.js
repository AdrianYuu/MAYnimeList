const db = require("../config/mysql.database");

const getUserByEmail = async (email) => {
  try {
    const [results] = await db
      .promise()
      .query("SELECT * FROM users WHERE email = ?", [email]);

    return results[0];
  } catch (error) {
    throw new Error(error.message);
  }
};

module.exports = {
  getUserByEmail,
};
